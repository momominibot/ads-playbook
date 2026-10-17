# Google Ads PlayBook

Search, Shopping, and Performance Max for DTC e-commerce. Healthcare-specific guidance included.

## Campaign Types: When to Use Which

| Campaign Type | Best For | Min Budget | Requires |
|---|---|---|---|
| Search Ads | Brand + product keywords, high intent | $10-15/day | Keyword list, ad copy, landing pages |
| Shopping Ads | Product feed, visual comparison | $20-30/day | GMC account, clean product feed, GTINs |
| Performance Max | Scaling across all Google inventory | $30-50/day | Conversion history (30+ conversions), feed |
| Demand Gen | YouTube + Discover visual awareness | $30-50/day | Video/image creative, feed |
| Display | Retargeting only | $5-10/day | Remarketing list |

**For new accounts:** Start with Search only. Do NOT start with PMax. PMax needs conversion history and will waste money on a zero-data account.

## Search Campaign Structure

```
Campaign: [Brand] Search - [Country]
├── Ad Group: Brand
│   ├── Keywords: brand name, brand + product, misspellings
│   └── Ads: Brand-focused, link to homepage or bestsellers
├── Ad Group: [Product Category 1] (e.g. Wound Dressings)
│   ├── Keywords: product names, "buy [product]", "[product] singapore"
│   └── Ads: Product-specific, link to collection page
├── Ad Group: [Product Category 2] (e.g. Stoma Care)
│   └── ...
└── Ad Group: Competitor (optional)
    ├── Keywords: competitor brand names
    └── Ads: Comparison angle, link to comparison page
```

### Keyword Match Types

| Match Type | Symbol | When to Use | Risk |
|---|---|---|---|
| Exact | [keyword] | High-value product names, brand | Misses variations |
| Phrase | "keyword" | Product + intent phrases | Some irrelevant traffic |
| Broad | keyword | Discovery, finding new terms | Lots of waste, needs negatives |

**Start with exact + phrase for product names.** Add broad only for discovery campaigns with strict negative keyword lists.

### Negative Keywords (Mandatory)

Add these at account level for medical e-commerce:
- "free", "sample", "trial", "coupon", "discount code"
- "job", "career", "salary", "hiring"
- "DIY", "homemade", "recipe", "how to make"
- "wholesale", "bulk", "distributor" (unless you sell B2B)
- "veterinary", "pet", "animal" (unless you sell pet products)
- "side effects", "lawsuit", "danger", "risk" (these convert poorly)

Review Search Terms report weekly and add new negatives.

## Responsive Search Ads (RSA) Structure

Per ad group, provide:
- **15 headlines** (30 chars each): product names, benefits, trust signals, delivery
- **4 descriptions** (90 chars each): specs, shipping, returns, price
- Google tests combinations automatically
- Aim for "Good" or "Excellent" Ad Strength

**Headline formula for medical products:**
1. Exact product name (matches keyword)
2. Brand + authenticity ("Genuine 3M Products")
3. Key benefit ("Fast Delivery Singapore")
4. Trust signal ("Trusted by Hospitals")
5. Price/value ("From S$5.90")
6. Urgency/availability ("In Stock Now")

## Shopping Ads Setup

1. Install "Google & YouTube" sales channel in Shopify
2. Create Google Merchant Center (GMC) account
3. Verify and claim website domain
4. Link GMC to Google Ads (10-digit CID)
5. Fix feed disapprovals (GTIN, image, category)
6. Create Standard Shopping campaign (not PMax for new accounts)

**Shopping feed priorities (see 10-optimization-framework.md for full feed guide):**
- Title: Brand + Product Type + Size/Quantity
- Image: 1200x1200+, white background, product fills 75-90%
- GTIN: Required for branded products
- Google product category: Accurate (Health > Medical Supplies > ...)

## Bidding Progression

| Stage | Conversions/30d | Strategy |
|---|---|---|
| Launch | 0-15 | Manual CPC (control costs) |
| Learning | 15-30 | Maximize Conversions |
| Optimized | 30+ | Target CPA (set 20% above current CPA) |
| Scaling | Stable | Maximize Conversion Value with ROAS target |

## Quality Score Optimization

Quality Score = Expected CTR + Ad Relevance + Landing Page Experience

| Component | How to Improve |
|---|---|
| Expected CTR | More compelling headlines, use keywords in ad copy |
| Ad Relevance | Match ad copy to keyword intent, one theme per ad group |
| Landing Page | Fast load (<2s), message match, clear navigation, mobile-friendly |

Higher Quality Score = lower CPC + better ad positions. A Quality Score of 10 can halve your CPC vs a score of 5.

## Healthcare-Specific Google Ads Rules

- No health claims in ad copy ("heals", "cures", "prevents infection") without substantiation
- Use product facts: brand, size, material, delivery
- Some medical keywords may require pre-approval (Google Ads healthcare policy)
- Prescription products cannot be advertised to consumers
- Ensure landing pages comply with HSA Singapore advertising rules (see 06-compliance-hsa.md)

## Measurement Checklist

- [ ] gtag base code installed on all pages
- [ ] Conversion tracking: purchase (value + currency), add_to_cart, begin_checkout
- [ ] Enhanced conversions enabled (email/phone hashing)
- [ ] GA4 linked to Google Ads
- [ ] Conversion linker enabled
- [ ] New customer conversion action (for PMax)
- [ ] Store visit conversions (if physical retail)
