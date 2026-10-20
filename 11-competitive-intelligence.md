# Competitive Intelligence & Ad Effectiveness Validation

The "proven effective before we follow the same" system. Daily monitoring of competitor ads, market signals, and validation criteria before committing budget.

## Core Principle

**Never copy an ad because it looks good. Only copy patterns that have been proven effective by public signals.** An ad running for 60+ days across multiple placements is almost certainly profitable. An ad that appeared 3 days ago is a test. Know the difference.

## Part 1: Ad Effectiveness Validation Framework

### The Longevity Signal (Primary)

Ad longevity is the strongest public performance proxy. Advertisers do not sustain spend on losing creatives.

| Ad Age | Interpretation | Action |
|---|---|---|
| 0-7 days | Test in progress | Ignore. Too early to judge. |
| 8-14 days | Possibly working, possibly not yet killed | Watch. Note pattern but don't copy. |
| 15-30 days | Likely profitable for the advertiser | Study. Extract hook + offer pattern. |
| 31-60 days | Almost certainly profitable | High priority. Test pattern immediately. |
| 60+ days | Definitive winner. Scaled creative | Highest priority. Clone pattern, not the ad. |

**Source:** Meta Ad Library "ad started running" date, Google Ads Transparency "last shown" date.

### The Impression Band Signal (Secondary)

Meta Ad Library shows impression ranges. Use them to estimate spend level.

| Active Ads | Impression Bands | Est. Monthly Meta Spend |
|---|---|---|
| 1-5 | Mostly <1K to 5K-10K | Under $5K/month |
| 5-15 | Mix of 1K-10K and 10K-50K | $5K-25K/month |
| 15-30 | Many 10K-50K, some 50K-100K | $25K-75K/month |
| 30+ | 50K-100K+ bands dominant | $75K+/month |

### The Multi-Placement Signal (Tertiary)

An ad appearing across Feed + Stories + Reels + Messenger means Meta's algorithm is distributing it broadly. This only happens when the ad performs well enough to win auctions across placements. Single-placement ads are weaker signals.

### The Direct-Response Signal

Proven performance ads almost always have:
- Clear price point or offer ("Free shipping over $50", "20% off first order")
- Direct CTA ("Shop now", "Buy now")
- Specific product name, not vague brand messaging
- Social proof (ratings, review count, "trusted by")

Brand awareness ads (vague messaging, no offer, no CTA) may run long for brand reasons but are not direct-response winners.

### Validation Score (0-10)

Score every competitor ad before considering it:

| Criterion | Points |
|---|---|
| Running 30+ days | 3 |
| Running 60+ days (adds to above) | +2 |
| Multi-placement (3+ placements) | 2 |
| Direct-response offer visible | 1 |
| Impression band 10K+ | 1 |
| Multiple variants of same pattern | 1 |
| **Total** | **/10** |

**Score 7+ = proven winner. Extract pattern and test.**
**Score 4-6 = possibly working. Watch, don't copy yet.**
**Score 0-3 = test or brand ad. Ignore.**

## Part 2: Pattern Cloning, Not Copy-Pasting

Never copy an ad verbatim. Extract the pattern and test it against your control.

### The 2x2 Test Matrix

When you find a proven competitor pattern, test it systematically:

| | Control Hook | New Hook (from competitor) |
|---|---|---|
| **Control Offer** | Cell A (your current best) | Cell B (new hook, your offer) |
| **New Offer (from competitor)** | Cell C (your hook, new offer) | Cell D (new hook + new offer) |

This isolates whether the hook, the offer, or the combination drives performance. Run all 4 cells at equal budget for 5-7 days. The winner gets scaled.

### Pattern Extraction Checklist

For every proven ad, document:
- [ ] Hook type (problem, contrarian, social proof, curiosity, product reveal)
- [ ] Hook text (exact first 3 seconds / first line)
- [ ] Offer structure (discount %, free shipping threshold, BOGO, bundle)
- [ ] CTA wording
- [ ] Visual format (UGC, product demo, comparison, text overlay)
- [ ] Length (15s, 30s, 60s)
- [ ] Landing page destination (homepage, product, collection)
- [ ] Price point shown
- [ ] Social proof element

## Part 3: Daily Signal Monitoring

### What to Monitor Daily

| Signal | Source | Frequency | Change to Watch |
|---|---|---|---|
| New competitor ads | Meta Ad Library, Google Transparency | Daily | New creatives, new offers |
| Disappearing competitor ads | Meta Ad Library (compare to yesterday) | Daily | Ads killed = failed tests; note what didn't work |
| Ad longevity milestones | Stored ad database | Daily | Ads crossing 30/60/90 days = proven |
| Competitor landing page changes | Website crawl | Weekly | New products, price changes, new offers |
| Platform policy changes | Google Ads blog, Meta Business blog, OpenAI | Daily | New restrictions, new features, policy updates |
| Industry benchmark shifts | Northbeam, Tinuiti, Calc4Marketers | Monthly | CPA/CVR/ROAS trend changes |
| New ad formats/features | Platform release notes | Weekly | New placements, new campaign types |
| Regulatory changes | HSA, FTC, platform ad policies | Weekly | New compliance requirements |

### The Daily Intelligence Report

Generated by cron, stored as markdown, includes:
1. **New ads found** (competitor, platform, first-seen date, creative type)
2. **Ads that disappeared** (competitor, how long it ran, likely reason)
3. **Proven winner alerts** (ads crossing 30-day threshold)
4. **Platform signals** (policy changes, new features)
5. **Action items** (patterns to test, competitors to watch)

## Part 4: Competitor Watchlist Setup

### How to Select Competitors

1. **Direct competitors** (same products, same market) - 3-5 brands
2. **Adjacent competitors** (same audience, different product) - 2-3 brands
3. **Category leaders** (biggest spenders in your niche) - 1-2 brands
4. **Cross-industry benchmarks** (brands with proven ad patterns you can adapt) - 2-3 brands

Total: 8-13 competitors on the watchlist.

### For Each Competitor, Track

- Business name, website, Meta Page URL
- Meta Ad Library URL (bookmark)
- Google Ads Transparency advertiser ID
- Estimated monthly ad spend (from impression bands)
- Product overlap with your business
- Key differentiators (price, selection, brand)
- Date added to watchlist

## Part 5: Automation Tools

### Free Tools

| Tool | What It Does | URL |
|---|---|---|
| Meta Ad Library | Search all active Meta ads by brand/keyword | facebook.com/ads/library |
| Google Ads Transparency Center | Search all active Google ads by advertiser | adstransparency.google.com |
| Meta Ad Library API | Programmatic access to ad archive | graph.facebook.com/v20.0/ads_archive |
| Apify Ad Library Scraper | Scrape Meta + Google + LinkedIn ads | apify.com/mediocre_interest/ads-library-scraper |

### Paid Tools (When Budget Allows)

| Tool | Price | Best For |
|---|---|---|
| AdLibrary API | ~$50/mo | Automated daily scans, API access |
| SpyFu | $39/mo | Google Ads keyword + spend estimates |
| SEMrush | $129/mo | Comprehensive competitive intelligence |
| Motion | $150/mo | Creative analytics + hook detection |
| Triple Whale | $300/mo | Attribution + creative-level data |

### The DIY Automation Stack (What We Use)

1. **Meta Ad Library API** - daily query for each competitor on watchlist
2. **Google Ads Transparency** - manual or Apify-scraped weekly
3. **SQLite database** - store all ads with first-seen, last-seen, impression bands
4. **Change detection script** - diff today vs yesterday, flag new/disappeared/proven
5. **Markdown report** - daily intelligence report generated automatically
6. **Cron job** - runs daily at 8am SGT

See `scripts/daily-ad-intel.sh` for the implementation.

## Part 6: The "Proven Before We Commit" Gate

Before any new ad creative goes live, it must pass this gate:

### Gate 1: Pattern Proven?
- [ ] Is this creative pattern based on a competitor ad scoring 7+ on the validation score?
- [ ] OR is it based on our own past winner (CPA 30%+ below average for 7+ days)?
- [ ] If neither, is it a deliberate test with a clear hypothesis and kill criteria?

### Gate 2: Business Fit?
- [ ] Does this pattern match our business type (from Phase 0)?
- [ ] Is the offer compatible with our margins?
- [ ] Does the landing page match the ad promise?

### Gate 3: Compliance?
- [ ] No prohibited claims (per 06-compliance guide)
- [ ] No restricted imagery
- [ ] Platform-specific rules checked

### Gate 4: Tracking Ready?
- [ ] Conversion tracking verified for this product/category
- [ ] UTM parameters configured
- [ ] Landing page loads <2s on mobile

**All 4 gates must pass before budget is committed.** If any gate fails, fix it first.

## Sources

- Adlibrary "How to Study Competitor Meta Ads" (2026) - longevity as performance proxy
- Adlibrary "Competitor Ad Campaigns Analysis: Six-Phase Framework" (2026)
- Adlibrary "Meta Ad Transparency Center: Complete Guide" (2026) - 45/60/90 day thresholds
- Adlibrary "How to Clone High-Performing Ads" (2026) - 2x2 test matrix
- Adlibrary "Winning Ad Elements Identification" (2026) - specificity, audience signal, promise-proof
- Adlibrary "Google Ads Transparency Center API" (2026) - programmatic nightly queries
- Apify "Build your own ad monitoring tool" (2026) - Meta + Google scraping
- Adligator "Meta Ad Library API: Automate Competitor Ad Monitoring" (2026)
- Rule1 "Winning ad creatives framework" (2026) - hook rate, hold rate, CTR, CPA, ROAS
- Trendtrack DTC ads validation (2026) - spend, impressions, days running, duplicate count
