/*
=============================================================================
Descriptive Measures Analysis
=============================================================================
Purpose:
    Calculate key business measures to establish an overview of sales,
    products, orders, and customers.

Analysis:
    1. Calculate total sales revenue and quantity sold.
    2. Determine the average selling price.
    3. Count distinct orders, products, and customers.
    4. Identify customers who have placed orders.
    5. Consolidate key measures into a summary.
=============================================================================
*/

-- =============================================================================
-- 1. Sales Measures
-- =============================================================================

-- Calculate total sales revenue.
SELECT
    SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- Calculate the total quantity of items sold.
SELECT
    SUM(quantity) AS total_quantity
FROM gold.fact_sales;

-- Calculate the average recorded selling price.
SELECT
    ROUND(AVG(price), 2) AS average_selling_price
FROM gold.fact_sales;


-- =============================================================================
-- 2. Order Volume Analysis
-- =============================================================================

-- Compare sales records with distinct orders to identify repeated order numbers.
SELECT
    COUNT(order_number) AS total_order_records,
    COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;


-- =============================================================================
-- 3. Product and Customer Counts
-- =============================================================================

-- Count distinct products.
SELECT
    COUNT(DISTINCT product_key) AS total_products
FROM gold.dim_products;

-- Count customers in the customer dimension.
SELECT
    COUNT(DISTINCT customer_key) AS total_customers
FROM gold.dim_customers;

-- Count distinct customers who have placed an order.
SELECT
    COUNT(DISTINCT customer_key) AS total_customers_with_orders
FROM gold.fact_sales;


-- =============================================================================
-- 4. Consolidated Business Measures
-- =============================================================================

-- Present key business measures in a single summary.
SELECT
    'Total Sales Revenue' AS measure_name,
    SUM(sales_amount) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT
    'Total Quantity Sold' AS measure_name,
    SUM(quantity) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT
    'Average Selling Price' AS measure_name,
    ROUND(AVG(price), 2) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT
    'Total Orders' AS measure_name,
    COUNT(DISTINCT order_number) AS measure_value
FROM gold.fact_sales

UNION ALL

SELECT
    'Total Products' AS measure_name,
    COUNT(DISTINCT product_key) AS measure_value
FROM gold.dim_products

UNION ALL

SELECT
    'Total Customers' AS measure_name,
    COUNT(DISTINCT customer_key) AS measure_value
FROM gold.dim_customers

UNION ALL

SELECT
    'Customers with Orders' AS measure_name,
    COUNT(DISTINCT customer_key) AS measure_value
FROM gold.fact_sales;
