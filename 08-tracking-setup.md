# Tracking Setup

Meta Pixel + CAPI, Google Ads conversion tracking, GA4. The foundation that must work before any ad spend.

## Why Tracking Matters

- iOS 14.5+ blocks ~30-50% of browser pixel events
- Without CAPI, Meta underreports conversions and can't optimize
- Without Google Ads conversion tracking, you cannot use smart bidding
- GA4 is the free source of truth for channel comparison
- **Spending without tracking = guessing.**

## Meta Pixel + Conversions API (CAPI)

### Browser Pixel (theme.liquid)

Install in `<head>` of theme.liquid:

```html
<!-- Meta Pixel Code -->
<script>
!function(f,b,e,v,n,t,s)
{if(f.fbq)return;n=f.fbq=function(){n.callMethod?
n.callMethod.apply(n,arguments):n.queue.push(arguments)};
if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
n.queue=[];t=b.createElement(e);t.async=!0;
t.src=v;s=b.getElementsByTagName(e)[0];
s.parentNode.insertBefore(t,s)}(window, document,'script',
'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', 'YOUR_PIXEL_ID');
fbq('track', 'PageView');
</script>
<noscript><img height="1" width="1" style="display:none"
src="https://www.facebook.com/tr?id=YOUR_PIXEL_ID&ev=PageView&noscript=1"
/></noscript>
<!-- End Meta Pixel Code -->
```

### Standard Events to Track

| Event | When | Parameters |
|---|---|---|
| PageView | Every page | (none) |
| ViewContent | Product page | content_ids, content_type, value, currency |
| AddToCart | Add to cart button | content_ids, value, currency |
| InitiateCheckout | Checkout page start | value, currency, num_items |
| Purchase | Order confirmation / thank you page | value, currency, content_ids, transaction_id |
| CompleteRegistration | Account creation | (optional) |

### Shopify Purchase Tracking (additional scripts)

In Shopify Admin > Settings > Checkout > Order status page > Additional scripts:

```html
{% if first_time_accessed %}
<script>
fbq('track', 'Purchase', {
  value: {{ checkout.total_price | money_without_currency | remove: ',' }},
  currency: '{{ shop.currency }}',
  content_ids: [{% for line_item in checkout.line_items %}'{{ line_item.product_id }}'{% unless forloop.last %},{% endunless %}{% endfor %}],
  content_type: 'product',
  transaction_id: '{{ checkout.order_id }}'
});
</script>
{% endif %}
```

### Conversions API (CAPI)

**Option 1 (easiest):** Install the "Facebook & Instagram" sales channel app in Shopify. It automatically sets up CAPI with server-side tracking.

**Option 2 (manual):** Use a CAPI integration tool (Stape, Elevar, or Conversions API Gateway). Requires server endpoint and access token.

**CAPI must send:**
- Same events as browser pixel
- Customer data (email, phone, name, city, zip) hashed with SHA-256
- event_id for deduplication (same ID as browser event)
- event_time in Unix timestamp

**Target Event Match Quality: 7+ / 10.** Below 6 means CAPI isn't matching users well.

## Google Ads Conversion Tracking

### gtag Base Code (theme.liquid)

```html
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=AW-XXXXXXXXX"></script>
<script>
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', 'AW-XXXXXXXXX');
</script>
```

### Purchase Conversion (additional scripts)

```html
{% if first_time_accessed %}
<script>
gtag('event', 'conversion', {
  'send_to': 'AW-XXXXXXXXX/CONVERSION_LABEL',
  'value': {{ checkout.total_price | money_without_currency | remove: ',' }},
  'currency': '{{ shop.currency }}',
  'transaction_id': '{{ checkout.order_id }}'
});
</script>
{% endif %}
```

### Enhanced Conversions

Enable in Google Ads > Tools > Conversions > Settings > Enhanced conversions.
Add to gtag config:
```javascript
gtag('set', 'user_data', {
  'email': '{{ checkout.email }}',
  'phone_number': '{{ checkout.shipping_address.phone }}',
  'first_name': '{{ checkout.shipping_address.first_name }}',
  'last_name': '{{ checkout.shipping_address.last_name }}'
});
```

### Conversion Actions to Create

| Action | Category | Value | Count |
|---|---|---|---|
| Purchase | Purchase | Transaction value | One per transaction (deduplicate) |
| Add to Cart | Add to cart | No value | Every event |
| Begin Checkout | Begin checkout | No value | Every event |
| View Product | View content | No value | Every event |
| New Customer | Purchase | Transaction value | One per customer (for PMax) |

## GA4 Setup

1. Create GA4 property, get Measurement ID (G-XXXXXXXXXX)
2. Add gtag config for GA4 alongside Google Ads:
```javascript
gtag('config', 'G-XXXXXXXXXX');
```
3. Link GA4 to Google Ads (Admin > Google Ads Links)
4. Link GA4 to Google Merchant Center (for Shopping)
5. Enable enhanced measurement in GA4
6. Mark purchase event as a Key Event in GA4

## Verification Checklist

### Meta Pixel
- [ ] Pixel Helper Chrome extension shows PageView on all pages
- [ ] ViewContent fires on product pages with product ID
- [ ] AddToCart fires when adding to cart
- [ ] Purchase fires on thank you page (test order)
- [ ] Events Manager shows events receiving
- [ ] CAPI events showing in Events Manager
- [ ] Event Match Quality 7+
- [ ] No duplicate events (deduplication working)

### Google Ads
- [ ] gtag loads on all pages (check Tag Assistant)
- [ ] Purchase conversion fires on thank you page
- [ ] Conversion value and currency correct
- [ ] Enhanced conversions enabled
- [ ] No duplicate conversions (transaction_id dedup)
- [ ] Conversions showing in Google Ads (after 24-48h)

### GA4
- [ ] Realtime report shows active users
- [ ] purchase event in Realtime during test
- [ ] DebugView shows events correctly
- [ ] Google Ads linked
- [ ] Key Events configured

## Common Issues

| Problem | Cause | Fix |
|---|---|---|
| Meta events not showing | Pixel ID wrong, or ad blocker | Verify ID, test in incognito |
| Duplicate purchases | Script fires on page reload | Use `{% if first_time_accessed %}` |
| Google Ads conversion 0 | Wrong conversion label | Verify AW-ID + label in GMC |
| CAPI match quality low | Not sending customer data | Add email/phone/name hashing |
| GA4 no ecommerce data | Missing ecommerce parameters | Add items array, value, currency |
| iOS underreporting | No CAPI | Install CAPI via Facebook channel |

## Tools

- **Meta Pixel Helper:** Chrome extension, real-time event checking
- **Google Tag Assistant:** Chrome extension, gtag verification
- **GA4 DebugView:** Real-time event debugging
- **Triple Whale / Northbeam:** Multi-touch attribution (paid)
- **Stape / Elevar:** CAPI hosting and management (paid)
