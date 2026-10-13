/*
=============================================================================
Cumulative and Moving Average Analysis
=============================================================================
Purpose:
    Analyze cumulative sales revenue and moving averages over time
    to evaluate business growth and historical performance.

Analysis:
    1. Calculate monthly cumulative sales revenue.
    2. Calculate annual cumulative sales revenue.
    3. Examine annual moving averages of selling prices.
=============================================================================
*/

-- =============================================================================
-- 1. Monthly Cumulative Sales Analysis
-- =============================================================================

-- Calculate monthly sales and running totals, resetting each calendar year.
SELECT
    order_date,
    total_sales,
    SUM(total_sales) OVER (
			PARTITION BY YEAR(order_date) 
            ORDER BY order_date
            ) AS running_total_sales
            
FROM (
    SELECT
        DATE_FORMAT(order_date, '%Y-%m-01') AS order_date,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
) AS t
ORDER BY order_date;


-- =============================================================================
-- 2. Annual Cumulative Sales Analysis
-- =============================================================================

-- Calculate annual sales and cumulative revenue across years.
SELECT
    order_year,
    total_sales,
    SUM(total_sales) OVER (
        ORDER BY order_year
    ) AS running_total_sales
FROM (
    SELECT
        YEAR(order_date) AS order_year,
        SUM(sales_amount) AS total_sales
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date)
) AS t
ORDER BY order_year;


-- =============================================================================
-- 3. Annual Moving Average Analysis
-- =============================================================================

-- Calculate cumulative sales and the expanding average of annual prices.
SELECT
    order_year,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_year) AS running_total_sales,
    ROUND(AVG(avg_price) OVER (ORDER BY order_year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS moving_average
FROM (
    SELECT
        YEAR(order_date) AS order_year,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date)
) AS t
ORDER BY order_year;
