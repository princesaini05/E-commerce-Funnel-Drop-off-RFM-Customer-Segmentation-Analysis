# Full Report
## E-commerce Funnel Drop-off & RFM Customer Segmentation Analysis

**Analyst:** Prince
**Date:**
**Tools:** Python (Pandas, Matplotlib, Seaborn) · MySQL · Power BI
**Dataset:** Online Retail I + II (UCI / Kaggle)

---

## 1. Business Context

An online retail store has grown traffic but revenue has remained flat.
Leadership lacks visibility into:

- Where customers drop off in the purchase journey
- Which customers are most valuable vs. at risk of leaving

**Goal:** Analyze the customer funnel and RFM segments to recommend
targeted actions for conversion and retention.

---

## 2. Dataset Overview

| Attribute | Value |
|-----------|-------|
| Source | Online Retail I + II (UCI / Kaggle) |
| Raw rows (combined) | ~1.07M |
| Cleaned rows | ~776,000 |
| Unique customers | ~5,861 |
| Date range | Dec 2009 → Dec 2011 |
| Total revenue | £17.07M |
| Columns | Invoice, StockCode, Description, Quantity, InvoiceDate, Price, CustomerID, Country |

---

## 3. Data Cleaning (Python — `data_cleaning.ipynb`)

The following cleaning steps were applied:

| Issue | Action |
|-------|--------|
| Cancellations (Invoice starting with 'C') | Removed |
| Missing CustomerID | Removed |
| Negative Quantity | Removed |
| Zero / negative Price | Removed |
| Non-product StockCodes (POST, DOT, M, D, C2, BANK CHARGES, B, PADS, CRUK, TEST, DCGS*) | Removed |
| Duplicate rows | Removed |
| Column naming | Renamed `Customer ID` → `CustomerID` |
| New column | Added `TotalPrice = Quantity × Price` |

**Output:** `data/cleaned/online_retail_clean.csv`

**Final cleaned data:**
- Rows: ~776,000
- Customers: ~5,861
- Revenue: £17.07M
- Date range: 2009-12-01 to 2011-12-09

---

## 4. Exploratory Data Analysis (Python — `eda.ipynb`)

### Key findings

| Finding | Detail |
|---------|--------|
| Monthly revenue | November spike (Christmas seasonality) |
| Geography | UK = ~85% of revenue |
| Order values | Right-skewed (mean > median) |
| Purchase frequency | Many customers buy only once |
| Pareto check | Top 20% of customers = 77% of revenue |

### Visuals produced
- Monthly revenue line chart
- Revenue by country bar chart
- Order value distribution histogram
- Customer purchase frequency distribution
- Pareto curve (cumulative revenue vs. customer %)

---

## 5. RFM Segmentation (Python — `rfm_scoring.ipynb`)

### Methodology

- **Snapshot date:** 2011-12-10 (last transaction + 1 day)
- **Recency:** days since last purchase
- **Frequency:** count of unique invoices
- **Monetary:** total spend

### Scoring

- Each metric scored **1–4** using `pd.qcut()` (quartiles)
- **Recency reversed** — recent = score 4
- Segments assigned based on R/F/M combinations:

| Segment | Description |
|---------|-------------|
| Champions | Recent, frequent, high spend |
| Loyal Customers | Frequent, good spend |
| Potential Loyalist | Recent, moderate frequency |
| New Customers | Recent, low frequency |
| At Risk | High spend, not recent |
| Cant Lose Them | High spend, very not recent |
| Lost | Low spend, not recent |
| Others | Remaining combinations |

**Output:** `rfm_segments.csv` (5,861 rows)

---

## 6. Funnel Analysis (MySQL — `funnel_analysis.sql`)

### Funnel stages

| Stage | Customers | Conversion from Previous | Drop-off from Previous |
|-------|-----------|--------------------------|------------------------|
| All Buyers | 5,861 | — | — |
| Repeat Buyers | 4,236 | 72.27% | 27.73% |
| Loyal Buyers | 2,141 | 50.54% | 49.46% |
| Champions | 961 | 44.89% | 55.11% |
| **Overall** | — | **16.40%** | — |

### Key insights

- **Only 1 in 6 buyers becomes a Champion (16.4%)**
- **Biggest % drop-off:** Loyal → Champion (55.11% lost)
- **Biggest absolute loss:** All → Repeat (1,625 customers)

---

## 7. RFM Segment Analysis (MySQL + Power BI)

### Segment revenue share

| Segment | Revenue | Share |
|---------|---------|-------|
| Champions | £9,282,816 | 54.37% |
| Loyal Customers | £3,701,002 | 21.68% |
| At Risk | £2,024,835 | 11.86% |
| Others | £960,359 | 5.63% |
| Lost | £554,669 | 3.25% |
| New Customers | £386,690 | 2.27% |
| Potential Loyalist | £162,705 | 0.95% |

### Key insights

- **Champions = 14% of customers → 54% of revenue**
- **At Risk = £2.02M at stake (11.86%)**
- **Top 3 segments = 88% of revenue** (concentration risk)
- **Lost = only 3.25%** → low ROI to chase

### Pareto

- Top 20% of customers = **77.18%** of revenue

---

## 8. Dashboard (Power BI)

### Page 1 — Customer Funnel
- 4-stage funnel with conversion + drop-off
- KPI cards: overall conversion, Champions, total revenue
- Stage detail table with conditional formatting

### Page 2 — RFM Segments
- Revenue by segment (bar)
- Customer count by segment (bar)
- Segment detail table with RFM averages
- Pareto callout

### Page 3 — Segment Deep Dive
- Top 10 Champions (VIP targets)
- Top 10 At-Risk (win-back targets)
- Country revenue breakdown
- Monthly revenue trend (seasonality)

**File:** `dashboard/ecommerce_funnel_rfm.pbix`

---

## 9. Key Business Insights

1. Only 1 in 6 buyers becomes a Champion (16.4% overall conversion)
2. Biggest % drop-off: Loyal → Champion (55.11% lost)
3. Biggest absolute loss: All → Repeat (1,625 customers)
4. Champions: 14% of customers drive 54% of revenue
5. At Risk: £2.02M in revenue at stake (11.86% share)
6. Pareto: Top 20% of customers = 77% of revenue
7. Seasonality: Revenue spikes in November (Christmas)
8. Geography: UK = ~85% of revenue

---

## 10. Recommendations

| Segment / Stage | Recommendation |
|-----------------|----------------|
| Stage 1 → 2 (Drop-off 27.73%) | Second-purchase discount email within 7 days |
| Stage 2 → 3 (Drop-off 49.46%) | Loyalty program with tier rewards at 5 orders |
| Stage 3 → 4 (Drop-off 55.11%) | VIP perks at 10-order milestone (free shipping, early access) |
| Champions | No discounts — VIP perks instead |
| At Risk | Win-back campaign (£2M recovery opportunity) |
| Lost | Ignore (only 3.25% of revenue) |
| New Customers | Onboarding campaign + second-purchase incentive |
| Loyal Customers | Nurture to Champions with tier rewards |

Full detail: see `recommendations.md`

---

## 11. Limitations

- Dataset ends Dec 2011 — no recent data
- RFM thresholds are quartile-based (not business-tuned)
- No cost data → cannot calculate true ROI
- No marketing channel data → cannot attribute acquisition source
- UK concentration limits generalizability to other markets

---

## 12. Next Steps

1. Deploy win-back campaign for At Risk segment
2. A/B test second-purchase incentive on new buyers
3. Build monthly RFM monitoring dashboard
4. Add cost data to calculate campaign ROI
5. Expand analysis to product-level funnel (which products drive Champions?)

---

## Appendix

- Python notebooks: `python/`
- SQL scripts: `sql/`
- Dashboard: `dashboard/`
- Visuals: `visuals/`