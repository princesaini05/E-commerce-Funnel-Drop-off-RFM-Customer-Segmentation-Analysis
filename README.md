# E-commerce Funnel Drop-off & RFM Customer Segmentation Analysis

![E-commerce Dashboard](https://github.com/princesaini05/E-commerce-Funnel-Drop-off-RFM-Customer-Segmentation-Analysis/blob/23ee039460dab2556f0448528a74a4e7b247dd0a/E-commerce%20Funnel%20Drop-off%20%26%20RFM%20Customer%20Segmentation%20Analysis.png)

An end-to-end data analytics project analyzing **~776,000 transactions** from an online retail store to uncover **where customers drop off** in the purchase funnel and **which customers are most valuable vs. at risk of leaving**.

---

## Business Problem

The store has growing traffic but **flat revenue**. Leadership lacks visibility into:

1. **Where customers drop off** in the purchase journey (conversion problem)
2. **Which customers are most valuable** vs. at risk of leaving (retention problem)

**Goal:** Analyze the customer funnel and RFM segments to recommend targeted actions for conversion + retention.

---

## Key Findings

| Insight | Value |
|---------|-------|
| Overall funnel conversion | **16.4%** (only 1 in 6 buyers becomes a Champion) |
| Biggest % drop-off | **55.11%** (Loyal → Champion) |
| Biggest absolute loss | **1,625 customers** (All → Repeat) |
| Champions revenue share | **54.37%** (£9.28M from 14% of customers) |
| At Risk revenue at stake | **£2.02M** (11.86% share) |
| Pareto | Top 20% of customers = **77.18%** of revenue |
| Seasonality | November spike (Christmas) |
| Geography | UK = ~85% of revenue |

---
## Exploratory Data Analysis (Python — `eda.ipynb`)

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

## RFM Segmentation (Python — `rfm_scoring.ipynb`)

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

## Funnel Analysis (MySQL — `funnel_analysis.sql`)

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

## RFM Segment Analysis (MySQL + Power BI)

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


## Dashboard Preview

### Page 1 — Customer Funnel
![Funnel](https://github.com/princesaini05/E-commerce-Funnel-Drop-off-RFM-Customer-Segmentation-Analysis/blob/03b21b27956473e895e17a19096ac381839f01c3/visuals/page1_funnel.jpg)

### Page 2 — RFM Segments
![RFM Segments](https://github.com/princesaini05/E-commerce-Funnel-Drop-off-RFM-Customer-Segmentation-Analysis/blob/165f74dd7cdd2f73b274d6bd895b8ae244dfc231/visuals/page2_rfm_segments.jpg)

### Page 3 — Segment Deep Dive
![Deep Dive](https://github.com/princesaini05/E-commerce-Funnel-Drop-off-RFM-Customer-Segmentation-Analysis/blob/d9a17326ac8cf0cf3ee16854a185059b5d2fe5c6/visuals/page3_deep_dive.jpg)

> Full interactive dashboard: `dashboard/E-commerce Funnel & RFM.pbix`

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| **Python** (Pandas, Matplotlib, Seaborn) | Data cleaning, EDA, RFM scoring |
| **MySQL** | Data storage, funnel queries, business queries |
| **Power BI** | 3-page interactive dashboard |
| **GitHub + Markdown** | Portfolio + reports |
