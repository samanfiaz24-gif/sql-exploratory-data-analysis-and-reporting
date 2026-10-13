/*
=============================================================================
Performance Ranking Analysis
=============================================================================
Purpose:
    Evaluate product and customer performance through revenue-based
    rankings and order frequency analysis.

Analysis:
    1. Identify the five highest-revenue products.
    2. Identify the five lowest-revenue products.
    3. Rank products using SQL window functions.
    4. Identify the ten highest-revenue customers.
    5. Identify three customers with the fewest orders.
=============================================================================
*/

-- =============================================================================
-- 1. Top-Performing Products
-- =============================================================================

-- Identify the five products generating the highest sales revenue.
SELECT
    p.product_key,
    p.product_name,
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p
    ON s.product_key = p.product_key
GROUP BY
    p.product_key,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 5;


-- =============================================================================
-- 2. Lowest-Revenue Products
-- =============================================================================

-- Identify the five lowest-revenue products among products with recorded sales.
SELECT
    p.product_key,
    p.product_name,
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p
    ON s.product_key = p.product_key
GROUP BY
    p.product_key,
    p.product_name
ORDER BY total_revenue ASC
LIMIT 5;


-- =============================================================================
-- 3. Product Revenue Ranking Using Window Functions
-- =============================================================================

-- Rank products by revenue and retrieve the five highest-ranked products.
SELECT
    *
FROM (
    SELECT
        p.product_key,
        p.product_name,
        SUM(s.sales_amount) AS total_revenue,
        ROW_NUMBER() OVER (
            ORDER BY SUM(s.sales_amount) DESC, p.product_key
        ) AS rank_products
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_products AS p
        ON s.product_key = p.product_key
    GROUP BY
        p.product_key,
        p.product_name
) AS t
WHERE rank_products <= 5
ORDER BY rank_products;


-- =============================================================================
-- 4. Customer Revenue Ranking
-- =============================================================================

-- Identify the ten customers generating the highest sales revenue.
SELECT
    *
FROM (
    SELECT
        c.customer_key,
        c.firstname,
        c.lastname,
        SUM(s.sales_amount) AS total_revenue,
        ROW_NUMBER() OVER (
            ORDER BY SUM(s.sales_amount) DESC, c.customer_key
        ) AS rank_by_revenue
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_customers AS c
        ON s.customer_key = c.customer_key
    GROUP BY
        c.customer_key,
        c.firstname,
        c.lastname
) AS t
WHERE rank_by_revenue <= 10
ORDER BY rank_by_revenue;


-- =============================================================================
-- 5. Customer Order Frequency Ranking
-- =============================================================================

-- Identify three purchasing customers with the fewest distinct orders.
SELECT
    c.customer_key,
    c.firstname,
    c.lastname,
    COUNT(DISTINCT s.order_number) AS total_orders
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c
    ON s.customer_key = c.customer_key
GROUP BY
    c.customer_key,
    c.firstname,
    c.lastname
ORDER BY total_orders ASC, c.customer_key
LIMIT 3;
