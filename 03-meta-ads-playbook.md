# Meta Ads PlayBook

Facebook + Instagram advertising for DTC e-commerce. Focus on Advantage+ Shopping, retargeting, and creative testing.

## Campaign Structure

### The 3-Campaign System (MAG Growth, Ecommerce Times)

```
Campaign 1: TOFU Prospecting (Advantage+ Shopping)
├── Broad audience (no interest targeting)
├── 10-15 creative variants (UGC, product, founder, comparison)
├── Lowest Cost bidding
└── Budget: 60-70% of total Meta spend

Campaign 2: MOFU Retargeting
├── Audience: Site visitors 30d, video viewers 50%+, page engagers
├── Dynamic product ads (catalog-based)
├── Creative: product-specific, offers, reviews
└── Budget: 20-30% of total Meta spend

Campaign 3: BOFU Existing Customers (optional)
├── Audience: Purchasers 90-180d
├── Creative: Cross-sell, replenishment, loyalty
└── Budget: 5-10% of total Meta spend
```

**Do NOT** create 10 ad sets with different interests. It fractures learning data. One broad ASC campaign outperforms.

## Advantage+ Shopping Campaigns (ASC)

ASC is Meta's AI-optimized campaign that handles audience, placement, and creative automatically.

**Requirements:**
- Meta Pixel + CAPI installed and firing correctly
- Product catalog synced (Facebook & Instagram sales channel)
- 5-10 creative variants minimum (10-15 preferred)
- At least 30-40 purchases/week potential for learning phase

**ASC Settings:**
- Campaign budget optimization (CBO)
- Broad audience (let Meta find buyers)
- Advantage+ placements (all placements)
- Advantage+ creative (dynamic creative)
- Lowest Cost bidding initially, switch to Cost Cap after 50+ conversions

**Creative types that work in ASC:**
1. UGC testimonial (customer using product)
2. Product demo (how to use, unboxing)
3. Problem/solution (before/after, pain point)
4. Founder story (brand authenticity)
5. Comparison (our product vs generic)
6. Educational (how to choose, what size)
7. Social proof (reviews, ratings, press)

## Retargeting Strategy

Retargeting has 5-12% CVR vs 0.89% cold CVR in healthcare. It's the highest-ROI Meta activity.

**Audiences to create:**
| Audience | Window | Creative |
|---|---|---|
| All site visitors | 30 days | Bestsellers, free shipping offer |
| Product page viewers | 14 days | Specific product, reviews |
| Add to cart | 14 days | Abandoned cart, 10% off |
| Initiate checkout | 7 days | Urgency, limited stock |
| Video viewers 50%+ | 30 days | Product-focused, CTA |
| Instagram engagers | 30 days | Brand story, new arrivals |

**Dynamic Product Ads (DPA):** Automatically show the exact product a user viewed. Requires catalog sync. Highest-performing retargeting format.

## Creative Testing Framework

See [10-optimization-framework.md](10-optimization-framework.md) for the full 3-layer system.

**Quick rules:**
- Test 3-5 new creatives per week
- $5-10/day per test, 3-5 day minimum
- Kill below 1% CTR or above target CPA
- Scale winners 20% budget every 3 days
- Refresh cadence scales with spend (Ezra Firestone rule)

## Creative Specs

| Format | Dimensions | Best For |
|---|---|---|
| Reels / Stories | 9:16 (1080x1920) | UGC, product demos, hooks |
| Feed | 1:1 (1080x1080) | Product shots, carousels |
| Feed | 4:5 (1080x1350) | Lifestyle, educational |
| Carousel | 1:1 cards | Product features, comparison |
| Collection | 1:1 hero + products | Catalog browsing |

**Hook formula (first 3 seconds):**
1. Problem statement ("Tired of dressings that won't stick?")
2. Contrarian take ("Most people use the wrong wound dressing")
3. Social proof ("10,000+ Singapore customers trust us")
4. Product reveal ("This is Tegaderm, and here's why doctors use it")
5. Question ("Which stoma paste is right for you?")

## Bidding & Budget

| Stage | Strategy | When |
|---|---|---|
| Launch | Lowest Cost | New campaign, need data |
| Learning (50+ conv) | Cost Cap (20-30% above target CPA) | Prevent overspending |
| Scaling | Bid Cap or Minimum ROAS | Stable performance, growing budget |

**Budget scaling rule:** Max 20% increase every 3 days. Larger jumps reset learning phase.

## Healthcare / Medical Restrictions on Meta

Meta has strict policies for health products:
- No before/after photos showing medical conditions
- No health claims ("cures", "heals", "prevents")
- No targeting based on health conditions (interest targeting for medical conditions is restricted)
- Use broad audience + creative that speaks to the problem without naming conditions
- Some products may require pre-approval
- Supplement and medical device categories have additional review

**Workaround:** Use educational creative ("How to choose a wound dressing") rather than condition-targeted creative. Broad audience + relevant creative outperforms restricted interest targeting anyway.

## Tracking Requirements

- Meta Pixel base code on all pages
- Conversions API (CAPI) for server-side tracking (mandatory post-iOS 14)
- Events: PageView, ViewContent, AddToCart, InitiateCheckout, Purchase
- Event Match Quality score of 7+ (send email, phone, name, city)
- Deduplication between browser pixel and CAPI (same event ID)

See [08-tracking-setup.md](08-tracking-setup.md) for full implementation.

## Measurement Reality

Meta's in-platform attribution overstates results (typically 20-40% inflation). Use:
- Triple Whale, Northbeam, or Hyros for multi-touch attribution
- GA4 for channel-level comparison
- Blended CPA (total ad spend / total orders) as the north star
- Don't optimize solely on Meta's reported ROAS
