# Ads PlayBook

A generic, evidence-based paid advertising playbook for any business type. Phase 0 foundation assessment first, then platform-specific tactics. Built with Gold Drop methodology across 30+ expert sources.

**The core rule: No ad spend until (1) the business type is classified, (2) tracking works, and (3) competitor ad patterns are proven effective.**

## Who this is for

- Founders and growth marketers at any business type (DTC, B2B, SaaS, local service, marketplace)
- Small to medium budgets ($500-5,000/month) who need to be efficient
- Anyone deciding where to spend first across Google, Meta, and emerging AI platforms
- Teams that want competitive intelligence before committing budget

## How to use this playbook

```
Phase 0: Business Foundation Assessment (MANDATORY, 1-2 days)
  │
  ├─ Score business on 4 dimensions (fit, demand, readiness, budget)
  ├─ Classify business type → determine platform priority
  ├─ Run competitive ad audit → find proven patterns
  └─ Go / Foundation-first / No-go decision
        │
        ▼
Phase 1: Tracking Setup (1-2 weeks)
  │
  ├─ Meta Pixel + CAPI
  ├─ Google Ads conversion tracking
  ├─ GA4
  └─ Verify with test purchase
        │
        ▼
Phase 2: First Campaign (30-60 days)
  │
  ├─ Start with highest-fit platform (from Phase 0)
  ├─ Use proven competitor patterns (from competitive intel)
  ├─ Small budget, manual bidding, learn
  └─ Daily intelligence report monitors competitors
        │
        ▼
Phase 3: Optimize & Scale (ongoing)
  │
  ├─ Weekly optimization loop (see 10-optimization-framework.md)
  ├─ Add second platform when first is profitable
  ├─ Creative testing at volume
  └─ Scale 20% every 3 days, never faster
```

## Playbook structure

| File | What it covers |
|---|---|
| [00-phase-0-foundation.md](00-phase-0-foundation.md) | **MANDATORY FIRST STEP.** 4-dimension business scoring, type classification, platform priority matrix, 7 key questions, go/no-go gate |
| [01-platform-comparison.md](01-platform-comparison.md) | Google vs Meta vs ChatGPT Ads: benchmarks, CPA, ROAS, CVR by industry |
| [02-google-ads-playbook.md](02-google-ads-playbook.md) | Search, Shopping, PMax: campaign structure, keywords, budgets, bid strategies |
| [03-meta-ads-playbook.md](03-meta-ads-playbook.md) | Advantage+ Shopping, retargeting, creative testing, UGC framework |
| [04-chatgpt-ads-playbook.md](04-chatgpt-ads-playbook.md) | AI search ads: how they work, eligibility, when to test, waitlist status |
| [05-budget-framework.md](05-budget-framework.md) | How much to spend, in what order, by business stage |
| [06-compliance-hsa.md](06-compliance-hsa.md) | Singapore HSA medical device advertising rules (for regulated businesses) |
| [07-emis-asia-specific.md](07-emis-asia-specific.md) | Case study: emis.asia (wound/stoma supplies) full campaign plan |
| [08-tracking-setup.md](08-tracking-setup.md) | Pixel, CAPI, Google Ads conversion tracking, verification checklist |
| [09-creative-ugc-framework.md](09-creative-ugc-framework.md) | AI-assisted UGC / synthetic creator content production system |
| [10-optimization-framework.md](10-optimization-framework.md) | Ad optimization closed loop: account structure, creative testing, bidding, product feed, landing page, weekly cadence |
| [11-competitive-intelligence.md](11-competitive-intelligence.md) | **Proven before we commit.** Ad effectiveness validation, daily signal monitoring, competitor crawling, pattern cloning |

## Automation

| Component | Location | Purpose |
|---|---|---|
| Daily ad intelligence script | `scripts/daily-ad-intel.sh` | Queries Meta Ad Library, detects new/disappeared/proven ads, generates report |
| Competitor watchlist | `data/watchlist.json` | Configurable list of competitors + keywords to monitor |
| Ad database | `data/ad-database.json` | Stored ad records with first-seen, age, validation score |
| Daily reports | `reports/intel-report-YYYY-MM-DD.md` | Generated intelligence reports |
| Cron job | Daily 8:00 AM SGT | Automated run of daily-ad-intel.sh |

### Setting up the cron job

```bash
# Edit crontab
crontab -e

# Add this line (runs daily at 8:00 AM Singapore time)
0 8 * * * /path/to/ads-playbook/scripts/daily-ad-intel.sh >> /path/to/ads-playbook/data/cron.log 2>&1
```

For automated Meta Ad Library queries, set your token:
```bash
export META_AD_LIBRARY_TOKEN="your_meta_developer_token"
```
Get a token at https://developers.facebook.com/apps/ (create app, add Marketing API, generate access token).

## The "Proven Effective Before We Follow" Gate

Before any new ad creative goes live, it must pass:

1. **Pattern proven?** Based on competitor ad scoring 7+/10 (30+ days running, multi-placement, direct-response) OR your own past winner
2. **Business fit?** Matches your Phase 0 business type, margins compatible, landing page matches promise
3. **Compliance?** No prohibited claims, no restricted imagery, platform rules checked
4. **Tracking ready?** Conversions verified, UTMs configured, page loads <2s

**All 4 gates must pass before budget is committed.**

## Quick start decision tree (after Phase 0)

```
Do people search for your product by name?
├── YES → Google Search first (brand + product keywords)
│   └── After 30 days data → Meta retargeting
│       └── After retargeting works → Meta cold / Advantage+
└── NO (discovery/impulse product)
    ├── Visual/under $75 → Meta first
    └── High consideration → Google Search (problem keywords) + Meta awareness

ChatGPT Ads? → Join waitlist if not in pilot country. Test only after Google + Meta are stable.
YouTube? → Skip below $50/day. Needs conversion history.
TikTok? → Lowest ROAS in health (1.2-2.0x). Skip unless demo is Gen Z.
```

## Benchmarks at a glance (Healthcare / Medical E-commerce, 2026)

| Metric | Google Search | Meta (cold) | Meta (retargeting) | ChatGPT Ads |
|---|---|---|---|---|
| Avg CPC | $3.50-8.00 | $1.85-6.40 | $1.20-3.00 | $3-5 |
| Avg CVR | 3.75% | 0.89% | 5-12% | In testing |
| Avg CPA | $55-100 | $60-110 | $25-50 | 15% below Google (vendor claim) |
| ROAS range | 3.5-5.0x | 2.0-3.2x | 4-8x | Unknown |
| Min daily budget | $10-15 | $10-20 | $5-10 | $500 recommended |
| Time to signal | 14-30 days | 30-50 conversions | 7-14 days | 30+ days |

## Sources and methodology

Built using the Gold Drop Research Methodology v1.1:
- 30+ expert sources across benchmark aggregators, platform data, and practitioners
- False corroboration check on every consensus claim (single-source vendor claims flagged)
- Ad longevity as primary effectiveness proxy (30+ days = proven, 60+ = definitive winner)
- Business-type-specific recommendations, not one-size-fits-all
- Competitive intelligence system with daily automation

Key data sources: Northbeam Q1 2026, Tinuiti Q2 2026, Calc4Marketers, Ryze AI, InsightIQ, EmberTribe, Adlibrary (2026 guides), OpenAI official partner results, HSA.gov.sg, Meta Ad Library API docs.

## License

Internal use. Update benchmarks quarterly. Re-run Phase 0 for each new business.
