# Executive Summary
## E-commerce Funnel Drop-off & RFM Customer Segmentation Analysis

**Prepared for:** Mr. Gaurav Tomar
**Analyst:** Prince
**Tools:** Python · MySQL · Power BI

---

### The Problem

The online retail store has grown traffic but revenue has remained flat.
Leadership lacks visibility into two critical questions:

1. **Where do customers drop off** in the purchase journey?
2. **Which customers are most valuable** — and which are at risk of leaving?

---

### What We Did

We analyzed **~776,000 cleaned transactions** from **5,861 unique customers**
between **Dec 2009 and Dec 2011** (£17.07M total revenue).

Two analytical frameworks were applied:

- **Funnel Analysis** — tracked buyers across 4 purchase stages
- **RFM Segmentation** — scored customers on Recency, Frequency, Monetary value

---

### Key Findings

**1. Only 1 in 6 buyers becomes a Champion (16.4% overall conversion)**

| Funnel Stage | Customers | Conversion |
|--------------|-----------|------------|
| All Buyers | 5,861 | — |
| Repeat Buyers | 4,236 | 72.27% |
| Loyal Buyers | 2,141 | 50.54% |
| Champions | 961 | 44.89% |

**2. The biggest % drop-off is Loyal → Champion (55.11% lost)**
**The biggest absolute loss is All → Repeat (1,625 customers)**

**3. Champions are 14% of customers but drive 54.37% of revenue (£9.28M)**
**4. At Risk customers hold £2.02M in revenue (11.86% share)**
**5. Top 20% of customers generate 77.18% of revenue (Pareto)**
**6. Revenue spikes every November — Christmas seasonality**
**7. UK = ~85% of revenue — geographic concentration risk**

---

### Business Impact

| Opportunity | Value |
|-------------|-------|
| At-Risk revenue recovery | £2.02M |
| Champions retention (54% of revenue) | £9.28M |
| Second-purchase conversion uplift | TBD (A/B test) |

---

### Recommendations (Top 3)

1. **Win-back campaign for At Risk segment** — £2M recovery opportunity
2. **VIP perks (not discounts) for Champions** — protect 54% of revenue
3. **Second-purchase discount within 7 days** — fix the largest absolute drop-off

Full recommendations: see `recommendations.md`

---

### Next Steps

- Deploy win-back campaign within 30 days
- A/B test second-purchase incentive on new buyers
- Build monthly RFM monitoring dashboard for ongoing segmentation

---

*Full analysis: see `full_report.md`*