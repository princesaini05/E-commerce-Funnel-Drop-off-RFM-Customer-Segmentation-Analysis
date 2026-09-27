-- ============================================
-- E-COMMERCE FUNNEL & RFM: BUSINESS QUERIES
-- ============================================
-- Author: Prince
-- Database: ecommerce_rfm
-- ============================================

USE ecommerce_rfm;

-- O1: Business Snapshot
SELECT 
    COUNT(DISTINCT Invoice) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers,
    COUNT(DISTINCT StockCode) AS total_products,
    ROUND(SUM(TotalPrice), 2) AS total_revenue,
    ROUND(SUM(TotalPrice) / COUNT(DISTINCT Invoice), 2) AS avg_order_value
FROM transactions;

-- ============================================

-- Q2: Customer Funnel
with customer_orders as
(
select
      customerID,
      count(distinct Invoice) as num_orders
from transactions
group by CustomerID
)
select
    count(*) as all_buyers,
    sum(case when num_orders>=2 then 1 else 0 end) as repeat_buyers,
    SUM(CASE WHEN num_orders >= 5  THEN 1 ELSE 0 END)               AS loyal_buyers,
    SUM(CASE WHEN num_orders >= 10 THEN 1 ELSE 0 END)               AS champions,
    ROUND(100.0 * SUM(CASE WHEN num_orders >= 2  THEN 1 ELSE 0 END) / COUNT(*), 2) AS repeat_rate,
    ROUND(100.0 * SUM(CASE WHEN num_orders >= 5  THEN 1 ELSE 0 END) / COUNT(*), 2) AS loyal_rate,
    ROUND(100.0 * SUM(CASE WHEN num_orders >= 10 THEN 1 ELSE 0 END) / COUNT(*), 2) AS champion_rate
FROM customer_orders;

-- ============================================

-- Q3: Funnel Drop-off %
with customer_orders as
(
select
CustomerID,
count(distinct Invoice) as order_count
from transactions
group by CustomerID
),
funnel as
(
select
count(*) as s1,
sum(case when order_count>=2 then 1 else 0 end) as s2,
sum(case when order_count>=5 then 1 else 0 end) as s3,
sum(case when order_count>=10 then 1 else 0 end) as s4
from customer_orders
)
select
s1 as Stage1_all_buyers,
s2 as stage2_repeat,
s3 as Stage3_loyal,
s4 as stage4_champions,
round((100.0*s2/s1),2) as s1_to_s2_pct,
round((100.0*s3/s2),2) as s2_to_s3_pct,
round((100.0*s4/s3),2) as s3_to_s4_pct,
round((100.0*s4/s1),2) as overall_conversion_pct
from funnel;

-- ============================================

-- Q4: Revenue by Funnel Stage
with customer_orders as
(
select CustomerID,
 count(distinct Invoice) as order_count,
 sum(TotalPrice) as revenue
 from transactions
 group by CustomerID
)
select
'Stage 1 - All buyers' as stage,
count(*) as Customers,
round(sum(revenue),2) as total_revenue
from customer_orders

-- ============================================

union all
select'Stage 2 - Repeat',
count(*),
round(sum(revenue),2)
from customer_orders
where order_count >=2

union all
select'Stage 2 - Loyal',
count(*),
round(sum(revenue),2)
from customer_orders
where order_count >=5

union all
select'Stage 2 - Champions',
count(*),
round(sum(revenue),2)
from customer_orders
where order_count >=10;

-- ============================================

-- Q5: RFM Segment Distribution
SELECT 
    Segment,
    COUNT(*) AS customers,
    ROUND((COUNT(*) / (SELECT 
                    COUNT(*)
                FROM
                    rfm_segments) * 100),
            2) AS customer_pct,
    ROUND(SUM(Monetary), 2) AS revenue,
    ROUND((SUM(Monetary) / (SELECT 
                    SUM(Monetary)
                FROM
                    rfm_segments) * 100),
            2) AS revenue,
    ROUND(AVG(Monetary), 2) AS avg_Monetary,
    ROUND(AVG(Recency), 2) AS avg_Recency,
    ROUND(AVG(Frequency), 2) AS avg_Frequency
FROM
    rfm_segments
GROUP BY Segment
ORDER BY revenue;

-- ============================================

-- Q6: Top 10 Champions
-- Identify specific VIP customers to reward.

SELECT 
    CustomerID, Recency, Frequency, Monetary, Segment
FROM
    rfm_segments
WHERE
    Segment = 'Champions'
ORDER BY Monetary DESC
LIMIT 10;

-- ============================================

-- Q7: At-Risk Customers with High Past Spend
-- The most urgent win-back targets.

SELECT 
    CustomerID, Recency, Frequency, Monetary, Segment
FROM
    rfm_segments
WHERE
    Segment = 'At Risk'
    and Monetary>2000
ORDER BY Monetary DESC
LIMIT 20;

-- ============================================

--  Q8: Segment Revenue Share
SELECT 
    Segment,
    ROUND(SUM(Monetary), 2) AS revenue,
    ROUND(100.0 * SUM(Monetary) / (SELECT 
                    SUM(Monetary)
                FROM
                    rfm_segments),
            2) AS revenue_pct
FROM
    rfm_segments
GROUP BY Segment
ORDER BY revenue DESC;

-- ============================================

-- Q9: Average Metrics per Segment
SELECT 
    Segment,
    ROUND(AVG(Recency), 1) AS avg_recency,
    ROUND(AVG(Frequency), 1) AS avg_frequency,
    ROUND(AVG(Monetary), 2) AS avg_monetary,
    COUNT(*) AS customers
FROM rfm_segments
GROUP BY Segment
ORDER BY avg_monetary DESC;

-- ============================================

-- Q10: Country + Segment Cross-Analysis
SELECT 
    t.Country,
    r.Segment,
    COUNT(DISTINCT r.CustomerID) AS customers,
    ROUND(SUM(r.Monetary), 2) AS revenue
FROM rfm_segments r
JOIN (
    SELECT DISTINCT CustomerID, Country
    FROM transactions
) t ON r.CustomerID = t.CustomerID
WHERE r.Segment IN ('Champions', 'Loyal Customers', 'At Risk')
GROUP BY t.Country, r.Segment
ORDER BY t.Country, revenue DESC
LIMIT 20;

-- ============================================

-- Q11: Monthly Revenue Trend
SELECT 
    DATE_FORMAT(InvoiceDate, '%Y-%m') AS month,
    COUNT(DISTINCT Invoice) AS orders,
    ROUND(SUM(TotalPrice), 2) AS revenue
FROM transactions
GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
ORDER BY month;

-- ============================================

-- Q12: Top 10 Products by Revenue
SELECT 
    Description,
    COUNT(DISTINCT Invoice) AS orders,
    SUM(Quantity) AS units_sold,
    ROUND(SUM(TotalPrice), 2) AS revenue
FROM transactions
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;

-- ============================================

-- Q13: Top 10 Countries by Revenue
SELECT 
    Country,
    COUNT(DISTINCT CustomerID) AS customers,
    COUNT(DISTINCT Invoice) AS orders,
    ROUND(SUM(TotalPrice), 2) AS revenue,
    ROUND(100.0 * SUM(TotalPrice) / (SELECT SUM(TotalPrice) FROM transactions), 2) AS revenue_pct
FROM transactions
GROUP BY Country
ORDER BY revenue DESC
LIMIT 10;

-- ============================================

-- Q14: Pareto Check — Revenue Concentration
with customer_revenue as
(
select
CustomerID,
sum(TotalPrice) as revenue,
row_number() over (order by sum(TotalPrice) desc) rank_num,
count(*) over () as total_customers
from transactions
group by customerID
)
SELECT 
    ROUND(100.0 * SUM(CASE
                WHEN rank_num <= total_customers * 0.20 THEN revenue
                ELSE 0
            END) / SUM(revenue),
            2) AS top_20_pct_revenue
FROM
    customer_revenue;