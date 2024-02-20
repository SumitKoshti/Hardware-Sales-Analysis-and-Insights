SHOW DATABASES;

SHOW TABLES FROM sales;

-- Dimension Table 1
SELECT * FROM customers;
SELECT DISTINCT(customer_type) FROM customers;

-- Dimension Table 2
SELECT * FROM date;
SELECT DISTINCT(year) FROM date;

-- Dimension Table 3
SELECT * FROM markets;
SELECT DISTINCT(markets_name) FROM markets;
SELECT DISTINCT(zone) FROM markets;

-- Dimension Table 4
SELECT * FROM products;
SELECT DISTINCT(product_type) FROM products;

-- Fact Table
SELECT * FROM transactions;
SELECT COUNT(*) FROM transactions;
SELECT DISTINCT(currency) FROM transactions;

# currency
'INR'
# currency
'USD'
# currency
'INR\r'
# currency
'USD\r'

SELECT COUNT(*)FROM transactions WHERE currency = 'USD\r';
SELECT COUNT(*)FROM transactions WHERE currency = 'USD';
SELECT COUNT(*)FROM transactions WHERE currency = 'INR\r';
SELECT COUNT(*)FROM transactions WHERE currency = 'INR';

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMER ANALYSIS
SELECT COUNT(*) FROM customers;

SELECT
	customer_type,
	COUNT(custmer_name)
FROM customers
GROUP BY customer_type;

SELECT
	 customer_type,
     SUM(sales_amount)
FROM transactions
INNER JOIN customers
ON transactions.customer_code = customers.customer_code
WHERE customer_type= "Brick & Mortar";

SELECT
	 customer_type,
     SUM(sales_amount) AS total_sales
FROM transactions
INNER JOIN customers
ON transactions.customer_code = customers.customer_code
GROUP BY customer_type
ORDER BY total_sales DESC;


SELECT
	year,
    SUM(sales_amount)
FROM transactions t INNER JOIN date d
ON t.order_date = d.date
WHERE year=2020;

SELECT
	customer_type,
    year,
    SUM(sales_amount)
FROM transactions t
	INNER JOIN customers c
ON t.customer_code = c.customer_code
	INNER JOIN date d
ON t.order_date = d.date
WHERE customer_type = "Brick & Mortar" AND year = 2020;

-- MARKET ANALYSIS 
SELECT
	market_code,
    SUM(sales_amount)
FROM transactions
WHERE market_code="Mark001";

SELECT
	markets_name,
	SUM(sales_amount)
FROM transactions t
	INNER JOIN markets m
ON t.market_code = m.markets_code
WHERE markets_name="Mumbai";

SELECT
	zone,
    SUM(sales_amount) AS total_sales
FROM transactions t
	INNER JOIN markets m
ON t.market_code = m.markets_code
GROUP BY zone
ORDER BY total_sales DESC;

SELECT
	markets_name,
    SUM(sales_amount) AS total_sales
FROM transactions t
	INNER JOIN markets m
ON t.market_code = m.markets_code
GROUP BY markets_name
ORDER BY total_sales DESC;

SELECT
	zone,
    COUNT(sales_qty) AS total_qty
FROM transactions t
	INNER JOIN markets m
ON t.market_code = m.markets_code
GROUP BY zone
ORDER BY total_qty DESC;

SELECT
	markets_name,
    COUNT(sales_qty) AS total_qty
FROM transactions t
	INNER JOIN markets m
ON t.market_code = m.markets_code
GROUP BY markets_name
ORDER BY total_qty DESC;

-- PRODUCT ANALYSIS 

SELECT
product_type,
SUM(sales_amount) AS total_sales
FROM transactions t 
INNER JOIN products p
ON t.product_code = p.product_code
GROUP BY product_type
ORDER BY total_sales DESC;

SELECT
	product_type,
	zone,
    ROUND(AVG(sales_amount),2) AS avg_sales
FROM transactions t
	INNER JOIN markets m
ON t.market_code=m.markets_code
	INNER JOIN products p
ON t.product_code = p.product_code
WHERE zone= "South" AND product_type= "Own Brand\r"; 

SELECT
	product_type,
    SUM(sales_amount)
FROM transactions t
	INNER JOIN products p
ON t.product_code=p.product_code
WHERE product_type = "Distribution\r";

SELECT
	year,
    zone,
    ROUND(AVG(sales_amount),2) AS avg_sales
FROM transactions t
	INNER JOIN markets m
ON t.market_code=m.markets_code
	INNER JOIN date d
ON t.order_date=d.date
WHERE year = 2019 AND zone = "Central";

-- -----------------------------------------------------------------------------------------------------------------------------------------------------------------------\
-- KEY PERFORMANCE INDICATORS --
-- Total Revenue
SELECT SUM(sales_amount) FROM transactions;

-- Total sold quantities
SELECT SUM(sales_qty) FROM transactions;

-- Revenue in per year
SELECT
	year,
    SUM(sales_amount) AS revenue_per_year
FROM transactions t
	INNER JOIN date d
ON t.order_date=d.date
GROUP BY year
ORDER BY revenue_per_year DESC;

















































































































































