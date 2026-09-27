CREATE DATABASE IF NOT EXISTS ecommerce_rfm;
USE ecommerce_rfm;

-- Create Transactions table
DROP TABLE IF EXISTS transactions;

CREATE TABLE transactions (
    Invoice      VARCHAR(20),
    StockCode    VARCHAR(20),
    Description  VARCHAR(255),
    Quantity     INT,
    InvoiceDate  DATETIME,
    Price        DECIMAL(10,2),
    CustomerID   INT,
    Country      VARCHAR(50),
    TotalPrice   DECIMAL(10,2)
);

truncate table transactions;

LOAD DATA LOCAL INFILE 'D:/DATA ANALYSIS/E-commerce Funnel & RFM/Data/cleaned/online_retail_clean.csv' INTO TABLE transactions
CHARACTER SET utf8mb4
FIELDS TERMINATED BY','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
ignore 1 lines
(Invoice, StockCode, Description, Quantity, InvoiceDate, Price, CustomerID, Country, TotalPrice);


-- Create RFM table
DROP TABLE IF EXISTS rfm_segments;

CREATE TABLE rfm_segments (
    CustomerID   INT PRIMARY KEY,
    Recency      INT,
    Frequency    INT,
    Monetary     DECIMAL(12,2),
    R_Score      INT,
    F_Score      INT,
    M_Score      INT,
    RFM_Score    VARCHAR(10),
    Segment      VARCHAR(50)
);

LOAD DATA LOCAL INFILE 'D:/DATA ANALYSIS/E-commerce Funnel & RFM/Data/cleaned/rfm_segments.csv' INTO TABLE rfm_segments
CHARACTER SET utf8mb4
FIELDS TERMINATED BY','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
ignore 1 lines
(CustomerID, Recency, Frequency, Monetary, R_Score, F_Score, M_Score, RFM_Score, Segment);

    
