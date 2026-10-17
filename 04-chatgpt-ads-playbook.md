# ChatGPT Ads PlayBook

AI search advertising through OpenAI's Ads Manager Beta. Currently in pilot, not available in Singapore.

## What Are ChatGPT Ads?

ChatGPT Ads appear within AI-generated responses when users ask questions relevant to your product or category. Unlike Google Ads (keyword auction) or Meta (interest targeting), ChatGPT Ads use "entity confidence" -- the AI decides whether your brand is relevant to mention based on your content and brand signals.

**Key difference:** Ads appear AFTER the AI's answer, not before intent. Users are in research/recommendation mode, not immediate purchase mode.

## Current Status (October 2026)

- **Availability:** US, UK, Mexico, Brazil, Japan, South Korea (pilot)
- **Singapore:** NOT available. Register at openai.com/advertisers for waitlist
- **Platform:** ads.openai.com (Ads Manager Beta)
- **Pricing:** CPC model, recommended bid $3-5/click
- **Minimum spend:** No minimum, but $500/day recommended for stable campaigns
- **Fair test budget:** $3,000-5,000/month

## Early Results (OpenAI Partner Data, October 2026)

| Brand | Result | Measurement Partner |
|---|---|---|
| WeightWatchers | CPA 15.3% below blended paid search | DV Rockerbox |
| Dose (wellness) | Statistically significant lift, 67% incremental from net-new customers | WorkMagic |
| Portland Leather | 93% of ChatGPT Ads visitors were new | Triple Whale |

**Caveat:** These are curated partner results from OpenAI. No independent cross-advertiser benchmark exists. Lapis explicitly states "OpenAI publishes no cross-advertiser benchmark." Treat these as directional, not guaranteed.

## Pixel + CAPI for ChatGPT Ads

OpenAI published first benchmarks in September 2026:
- Pixel + Conversions API vs pixel alone: **57% more measured conversions, 28% lower measured CPA**
- Sample: 1,000+ advertisers at $500+ spend, May 26 to June 22, 2026

**Implication:** CAPI is even more important for ChatGPT Ads than for Meta. Browser-only tracking will significantly underreport.

## How ChatGPT Ads Differ from Google

| Dimension | Google Ads | ChatGPT Ads |
|---|---|---|
| Mechanic | Keyword auction (bid + quality score) | Entity confidence (content relevance) |
| Placement | Before/alongside search results | After AI answer |
| User intent | Immediate purchase ("buy tegaderm") | Research/evaluation ("best wound dressing") |
| Budget control | Strong (keyword bids, daily caps) | Developing |
| Targeting | Keywords, location, device, audience | Topic/category, location |
| Content influence | Limited (ad copy only) | Strong (website content, SEO, entity signals) |
| Transparency | High (search terms, auctions) | Low (cannot see chat content) |

## When ChatGPT Ads Make Sense

1. **Your buyers are in research mode:** "best wound dressing for chronic wounds," "how to choose stoma paste"
2. **You have strong content/SEO:** The AI references your content in organic responses, which reinforces ad relevance
3. **You're in a pilot country** (not Singapore yet)
4. **Google + Meta are already stable:** ChatGPT is incremental, not a replacement
5. **You have $3,000-5,000/month:** Below this, campaigns run unevenly

## When to Skip ChatGPT Ads

- You're in a non-pilot country (Singapore)
- Your budget is under $1,000/month
- You don't have CAPI installed
- Your website has thin content (AI can't find entity signals)
- Google Search isn't profitable yet (fix that first)

## Preparation for When Singapore Launches

While waiting for Singapore availability:
1. **Build content entities:** Create comprehensive product guides, comparison pages, "how to choose" articles
2. **Improve SEO:** Strong organic presence = stronger entity confidence for AI
3. **Install CAPI:** Will be required for accurate measurement
4. **Register for waitlist:** openai.com/advertisers
5. **Build brand entity:** Wikipedia, consistent NAP (name/address/phone), press mentions
6. **Product schema:** Ensure all product pages have structured data

## The AI Visibility Connection

ChatGPT Ads are part of the broader shift from "search optimization" to "AI visibility." The same work that improves ChatGPT Ads (strong content, entity signals, schema) also improves:
- Google AI Overviews
- Perplexity, Claude, and other AI search answers
- ChatGPT organic recommendations (separate from paid ads)

This is why the AI Visibility Playbook and Ads PlayBook are connected. Content built for SEO also feeds AI ad performance.

## Sources

- OpenAI official: "Building advertising for the way people use AI" (Oct 5, 2026)
- Index Lab: "OpenAI Publishes Its First ChatGPT Ads Benchmarks" (Sep 1, 2026)
- Lapis: "ChatGPT Ads Results: What Advertisers Can Expect in 2026"
- Sophyx: ChatGPT Ads guide (CPC, budget recommendations)
- Aurelius Media, North Country, Metaflow, Castle: platform comparisons
