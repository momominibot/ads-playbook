#!/bin/bash
# daily-ad-intel.sh - Daily competitive ad intelligence report
# Part of the Ads PlayBook: https://github.com/momominibot/ads-playbook
#
# Runs daily via cron. Queries Meta Ad Library, detects new/disappeared/proven ads,
# generates a markdown intelligence report.
#
# Usage: ./daily-ad-intel.sh [--business NAME]
#
# Required: jq, curl
# Optional: META_AD_LIBRARY_TOKEN env var (Meta developer access token)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYBOOK_DIR="$(dirname "$SCRIPT_DIR")"
DATA_DIR="$PLAYBOOK_DIR/data"
REPORTS_DIR="$PLAYBOOK_DIR/reports"
TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -v-1d +%Y-%m-%d 2>/dev/null || date -d "yesterday" +%Y-%m-%d)

WATCHLIST="$DATA_DIR/watchlist.json"
AD_DB="$DATA_DIR/ad-database.json"
DAILY_SNAPSHOT="$DATA_DIR/snapshot-$TODAY.json"
REPORT="$REPORTS_DIR/intel-report-$TODAY.md"

# Ensure directories exist
mkdir -p "$DATA_DIR" "$REPORTS_DIR"

# Initialize ad database if not exists
if [ ! -f "$AD_DB" ]; then
  echo '{"ads": [], "last_updated": null}' > "$AD_DB"
fi

echo "=== Ads PlayBook: Daily Intelligence Report ==="
echo "Date: $TODAY"
echo ""

# --- Step 1: Read watchlist ---
if [ ! -f "$WATCHLIST" ]; then
  echo "ERROR: Watchlist not found at $WATCHLIST"
  exit 1
fi

BUSINESS=$(jq -r '.business' "$WATCHLIST")
MARKET=$(jq -r '.market' "$WATCHLIST")
COMPETITOR_COUNT=$(jq '.competitors | length' "$WATCHLIST")
echo "Business: $BUSINESS | Market: $MARKET | Competitors on watchlist: $COMPETITOR_COUNT"
echo ""

# --- Step 2: Query Meta Ad Library for each competitor ---
NEW_ADS=0
DISAPPEARED_ADS=0
PROVEN_WINNERS=0
TOTAL_ACTIVE=0

# Load existing ad database
EXISTING_IDS=$(jq -r '.ads[].id' "$AD_DB" 2>/dev/null || echo "")

# Temp file for today's snapshot
echo '{"ads": [], "snapshot_date": "'"$TODAY"'"}' > "$DAILY_SNAPSHOT"

# Check for Meta token
if [ -z "${META_AD_LIBRARY_TOKEN:-}" ]; then
  echo "NOTE: META_AD_LIBRARY_TOKEN not set. Running in manual/observation mode."
  echo "      Set META_AD_LIBRARY_TOKEN for automated Meta Ad Library queries."
  echo "      Get token at: https://developers.facebook.com/apps/"
  echo ""
  HAS_TOKEN=false
else
  HAS_TOKEN=true
fi

# Process each competitor
for i in $(seq 0 $((COMPETITOR_COUNT - 1))); do
  COMP_NAME=$(jq -r ".competitors[$i].name" "$WATCHLIST")
  COMP_PAGE=$(jq -r ".competitors[$i].meta_page_url" "$WATCHLIST")
  COMP_TYPE=$(jq -r ".competitors[$i].type" "$WATCHLIST")

  echo "--- $COMP_NAME ($COMP_TYPE) ---"

  if [ "$HAS_TOKEN" = true ]; then
    # Query Meta Ad Library API
    # Search by page name (simplified; production would resolve page ID first)
    RESPONSE=$(curl -s -G "https://graph.facebook.com/v20.0/ads_archive" \
      --data-urlencode "access_token=$META_AD_LIBRARY_TOKEN" \
      --data-urlencode "ad_active_status=ACTIVE" \
      --data-urlencode "search_page_ids=$COMP_NAME" \
      --data-urlencode "ad_reached_countries=['SG']" \
      --data-urlencode "fields=id,ad_creative_bodies,ad_creative_link_titles,ad_delivery_start_time,ad_snapshot_url,page_name,impression_range" \
      2>/dev/null || echo '{"data":[]}')

    AD_COUNT=$(echo "$RESPONSE" | jq '.data | length' 2>/dev/null || echo "0")
    echo "  Active Meta ads found: $AD_COUNT"

    # Process each ad
    for j in $(seq 0 $((AD_COUNT - 1))); do
      AD_ID=$(echo "$RESPONSE" | jq -r ".data[$j].id" 2>/dev/null || echo "")
      AD_START=$(echo "$RESPONSE" | jq -r ".data[$j].ad_delivery_start_time" 2>/dev/null || echo "")
      AD_BODY=$(echo "$RESPONSE" | jq -r ".data[$j].ad_creative_bodies[0]" 2>/dev/null || echo "")
      AD_TITLE=$(echo "$RESPONSE" | jq -r ".data[$j].ad_creative_link_titles[0]" 2>/dev/null || echo "")
      AD_IMPRESSIONS=$(echo "$RESPONSE" | jq -r ".data[$j].impression_range" 2>/dev/null || echo "unknown")

      if [ -n "$AD_ID" ]; then
        # Calculate ad age
        if [ -n "$AD_START" ] && [ "$AD_START" != "null" ]; then
          AD_START_DATE=$(echo "$AD_START" | cut -d'T' -f1)
          AD_AGE_DAYS=$(( ( $(date -j -f "%Y-%m-%d" "$TODAY" +%s 2>/dev/null || date -d "$TODAY" +%s) - $(date -j -f "%Y-%m-%d" "$AD_START_DATE" +%s 2>/dev/null || date -d "$AD_START_DATE" +%s) ) / 86400 ))
        else
          AD_AGE_DAYS=0
        fi

        # Validation score
        SCORE=0
        [ "$AD_AGE_DAYS" -ge 30 ] 2>/dev/null && SCORE=$((SCORE + 3))
        [ "$AD_AGE_DAYS" -ge 60 ] 2>/dev/null && SCORE=$((SCORE + 2))
        echo "$AD_IMPRESSIONS" | grep -q "10000\|50000\|100000" && SCORE=$((SCORE + 1))
        echo "$AD_BODY" | grep -qi "free\|off\|discount\|%\|shop\|buy\|order" && SCORE=$((SCORE + 1))

        # Check if new
        if ! echo "$EXISTING_IDS" | grep -q "$AD_ID"; then
          NEW_ADS=$((NEW_ADS + 1))
          echo "  NEW AD: $AD_ID (age: ${AD_AGE_DAYS}d, score: $SCORE/10)"
        fi

        # Check if proven winner (30+ days, score >= 7)
        if [ "$AD_AGE_DAYS" -ge 30 ] 2>/dev/null && [ "$SCORE" -ge 7 ] 2>/dev/null; then
          PROVEN_WINNERS=$((PROVEN_WINNERS + 1))
          echo "  PROVEN WINNER: $AD_ID (age: ${AD_AGE_DAYS}d, score: $SCORE/10)"
        fi

        # Add to today's snapshot
        jq --arg id "$AD_ID" \
           --arg competitor "$COMP_NAME" \
           --arg start "$AD_START_DATE" \
           --arg body "$AD_BODY" \
           --arg title "$AD_TITLE" \
           --arg impressions "$AD_IMPRESSIONS" \
           --argjson age "$AD_AGE_DAYS" \
           --argjson score "$SCORE" \
           '.ads += [{"id": $id, "competitor": $competitor, "start_date": $start, "age_days": $age, "body": $body, "title": $title, "impression_range": $impressions, "validation_score": $score}]' \
           "$DAILY_SNAPSHOT" > "${DAILY_SNAPSHOT}.tmp" && mv "${DAILY_SNAPSHOT}.tmp" "$DAILY_SNAPSHOT"

        TOTAL_ACTIVE=$((TOTAL_ACTIVE + 1))
      fi
    done
  else
    # Manual mode: count from existing database
    AD_COUNT=$(jq --arg comp "$COMP_NAME" '[.ads[] | select(.competitor == $comp)] | length' "$AD_DB" 2>/dev/null || echo "0")
    echo "  (manual mode) Known ads in database: $AD_COUNT"
    TOTAL_ACTIVE=$((TOTAL_ACTIVE + AD_COUNT))
  fi
  echo ""
done

# --- Step 3: Detect disappeared ads ---
if [ -f "$DATA_DIR/snapshot-$YESTERDAY.json" ]; then
  YESTERDAY_IDS=$(jq -r '.ads[].id' "$DATA_DIR/snapshot-$YESTERDAY.json" 2>/dev/null || echo "")
  TODAY_IDS=$(jq -r '.ads[].id' "$DAILY_SNAPSHOT" 2>/dev/null || echo "")

  for id in $YESTERDAY_IDS; do
    if ! echo "$TODAY_IDS" | grep -q "$id"; then
      DISAPPEARED_ADS=$((DISAPPEARED_ADS + 1))
    fi
  done
fi

# --- Step 4: Update master ad database ---
# Merge today's snapshot into the database (dedupe by ad ID)
if [ "$HAS_TOKEN" = true ]; then
  jq -s '.[0].ads as $new | .[1] as $db |
    {
      ads: ($db.ads + ($new | map(. as $a | $db.ads[] | select(.id == $a.id) | . + $a) // $new)),
      last_updated: "'"$TODAY"'"
    }' "$DAILY_SNAPSHOT" "$AD_DB" > "${AD_DB}.tmp" 2>/dev/null && mv "${AD_DB}.tmp" "$AD_DB" || cp "$DAILY_SNAPSHOT" "$AD_DB"
fi

# --- Step 5: Platform signal checks ---
echo "=== Platform Signals ==="
echo ""

# Check for platform policy updates (simplified - would use RSS/API in production)
echo "Google Ads: Check https://blog.google/products/ads-commerce/ for policy updates"
echo "Meta Ads: Check https://www.facebook.com/business/news for policy updates"
echo "ChatGPT Ads: Pilot countries: US, UK, Mexico, Brazil, Japan, South Korea. Singapore: not available"
echo ""

# --- Step 6: Generate markdown report ---
cat > "$REPORT" << EOF
# Daily Ad Intelligence Report
**Date:** $TODAY
**Business:** $BUSINESS
**Market:** $MARKET

## Summary

| Metric | Count |
|---|---|
| Competitors monitored | $COMPETITOR_COUNT |
| Total active ads tracked | $TOTAL_ACTIVE |
| New ads detected | $NEW_ADS |
| Ads disappeared | $DISAPPEARED_ADS |
| Proven winners (30+ days, score 7+) | $PROVEN_WINNERS |

## New Ads Detected

EOF

if [ "$NEW_ADS" -gt 0 ]; then
  jq -r '.ads[] | "| \(.competitor) | \(.age_days)d | \(.validation_score)/10 | \(.title // "no title") |"' "$DAILY_SNAPSHOT" 2>/dev/null | head -20 >> "$REPORT" || echo "(details in snapshot file)" >> "$REPORT"
else
  echo "No new ads detected today." >> "$REPORT"
fi

cat >> "$REPORT" << EOF

## Proven Winners (Action Required)

EOF

if [ "$PROVEN_WINNERS" -gt 0 ]; then
  echo "These ads have been running 30+ days with validation score 7+. Extract patterns and test." >> "$REPORT"
  echo "" >> "$REPORT"
  jq -r '.ads[] | select(.age_days >= 30 and .validation_score >= 7) | "**\(.competitor)** - \(.age_days) days running, score \(.validation_score)/10\n- Hook/body: \(.body // "n/a")\n- Title: \(.title // "n/a")\n- Impressions: \(.impression_range)\n"' "$DAILY_SNAPSHOT" 2>/dev/null >> "$REPORT" || echo "(details in snapshot file)" >> "$REPORT"
else
  echo "No proven winners crossing threshold today." >> "$REPORT"
fi

cat >> "$REPORT" << EOF

## Disappeared Ads

$DISAPPEARED_ADS ads disappeared since yesterday. These may be failed tests or ended campaigns.
Review the snapshot diff to identify patterns that did NOT work (avoid these).

## Platform Signals

- Google Ads: Monitor blog.google/products/ads-commerce/ for policy/feature updates
- Meta Ads: Monitor facebook.com/business/news
- ChatGPT Ads: Singapore not yet in pilot. Register at openai.com/advertisers
- HSA Compliance: Review hsa.gov.sg for medical device ad policy changes

## Action Items

1. [ ] Review proven winners above, extract hook + offer patterns
2. [ ] Set up 2x2 test matrix for top 1-2 patterns
3. [ ] Check disappeared ads for patterns to avoid
4. [ ] Verify tracking still firing (Pixel + CAPI + Google conversions)
5. [ ] Review yesterday's campaign performance against CPA targets

## Data Files

- Watchlist: data/watchlist.json
- Ad database: data/ad-database.json
- Today's snapshot: data/snapshot-$TODAY.json
- Previous snapshot: data/snapshot-$YESTERDAY.json

---
*Generated by Ads PlayBook daily-ad-intel.sh*
*Part of https://github.com/momominibot/ads-playbook*
EOF

echo ""
echo "=== Report Generated ==="
echo "Report: $REPORT"
echo "New ads: $NEW_ADS | Disappeared: $DISAPPEARED_ADS | Proven winners: $PROVEN_WINNERS"
echo ""
echo "To view report: cat $REPORT"
echo "To set up automated Meta queries: export META_AD_LIBRARY_TOKEN='your_token'"
