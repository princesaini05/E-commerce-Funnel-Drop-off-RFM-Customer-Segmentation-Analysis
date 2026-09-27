USE ecommerce_rfm;
-- check rows
SELECT
    (SELECT COUNT(*) FROM transactions) AS transactions_rows_count,
    (SELECT COUNT(*) FROM rfm_segments) AS rfm_segments_rows_count;
    
    
-- Sanity check
SELECT 
    MIN(InvoiceDate) AS first_date,
    MAX(InvoiceDate) AS last_date,
    COUNT(DISTINCT Invoice) AS total_orders,
    SUM(TotalPrice) AS total_revenue
FROM transactions;

-- Check for nulls
SELECT 
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS null_customer,
    SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END) AS bad_quantity,
    SUM(CASE WHEN Price <= 0 THEN 1 ELSE 0 END) AS bad_price
FROM transactions;

-- Top 5 countries by revenue
SELECT Country, ROUND(SUM(TotalPrice), 2) AS revenue
FROM transactions
GROUP BY Country
ORDER BY revenue DESC
LIMIT 5;

-- Sample rows
SELECT * FROM transactions LIMIT 10;
SELECT * FROM rfm_segments LIMIT 10;


-- JOIN VERIFY

SELECT 
    t.CustomerID,
    t.Invoice,
    t.TotalPrice,
    r.Segment
FROM transactions t
JOIN rfm_segments r ON t.CustomerID = r.CustomerID
LIMIT 10;


-- Snapshot Date
SELECT DATE_ADD(MAX(InvoiceDate), INTERVAL 1 DAY) AS snapshot_date
FROM transactions;


-- Build RFM score Table
DROP TABLE IF EXISTS rfm_base;

CREATE TABLE rfm_base AS
SELECT 
    CustomerID,
    DATEDIFF('2011-12-10', MAX(InvoiceDate)) AS Recency,
    COUNT(DISTINCT Invoice) AS Frequency,
    ROUND(SUM(TotalPrice), 2) AS Monetary
FROM transactions
GROUP BY CustomerID;

SELECT * FROM rfm_base LIMIT 5;


-- Build RFM score Table
DROP TABLE IF EXISTS rfm_scored;

CREATE TABLE rfm_scored AS
SELECT 
    CustomerID,
    Recency,
    Frequency,
    Monetary,
    NTILE(4) OVER (ORDER BY Recency DESC) AS R_Score,
    NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
    NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
FROM rfm_base;

SELECT * FROM rfm_scored LIMIT 10;