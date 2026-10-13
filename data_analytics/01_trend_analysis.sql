/*
=============================================================================
Temporal Trend Analysis
=============================================================================
Purpose:
    Analyze changes in key business measures over time to identify
    sales trends, customer activity, and potential seasonal patterns.

Analysis:
    1. Examine annual sales performance.
    2. Analyze monthly sales performance.
    3. Present monthly trends using formatted reporting periods.
=============================================================================
*/

-- =============================================================================
-- 1. Annual Sales Trend Analysis
-- =============================================================================

-- Analyze annual sales revenue, purchasing customers, and quantities sold.
SELECT
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY order_year;


-- =============================================================================
-- 2. Monthly Sales Trend Analysis
-- =============================================================================

-- Examine sales performance by calendar year and month.
SELECT
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    YEAR(order_date),
    MONTH(order_date)
ORDER BY
    order_year,
    order_month;


-- =============================================================================
-- 3. Monthly Sales Trends with Formatted Periods
-- =============================================================================

-- Display year and month together for monthly reporting.
SELECT
    DATE_FORMAT(order_date, '%Y-%b') AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY
    DATE_FORMAT(order_date, '%Y-%b')
ORDER BY
    MIN(order_date);
