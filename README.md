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

## Dashboard Preview

### Page 1 — Customer Funnel
![Funnel](visuals/page1_funnel.png)

### Page 2 — RFM Segments
![RFM Segments](visuals/page2_rfm_segments.png)

### Page 3 — Segment Deep Dive
![Deep Dive](visuals/page3_deep_dive.png)

> Full interactive dashboard: `dashboard/ecommerce_funnel_rfm.pbix`

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| **Python** (Pandas, Matplotlib, Seaborn) | Data cleaning, EDA, RFM scoring |
| **MySQL** | Data storage, funnel queries, business queries |
| **Power BI** | 3-page interactive dashboard |
| **GitHub + Markdown** | Portfolio + reports |
