/*
=============================================================================
Data Segmentation Analysis
=============================================================================
Purpose:
    Classify products and customers into distinct segments based on
    cost, purchasing history, and spending behavior.

Analysis:
    1. Segment products into predefined cost ranges.
    2. Classify customers based on spending and purchasing lifespan.
    3. Calculate the number of products and customers in each segment.
=============================================================================
*/

-- =============================================================================
-- 1. Product Cost Segmentation
-- =============================================================================

-- Segment products by cost and calculate the number in each segment.

WITH product_segments AS (

    SELECT
        product_key,
        product_name,
        cost,
        CASE
            WHEN cost < 100 THEN 'Below 100'
            WHEN cost BETWEEN 100 AND 500 THEN '100-500'
            WHEN cost BETWEEN 500 AND 1000 THEN '501-1000'
            ELSE 'Above 1000'
        END AS cost_range
    FROM gold.dim_products

)

SELECT
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;


-- =============================================================================
-- 2. Customer Behavioral Segmentation
-- =============================================================================

-- Classify customers based on total spending and purchasing lifespan.
-- VIP: At least 12 months of history and spending above 5000.
-- Regular: At least 12 months of history and spending 5000 or less.
-- New: Less than 12 months of purchasing history.

WITH customer_spending AS (

    SELECT
        c.customer_key,
        SUM(s.sales_amount) AS total_spending,
        MIN(s.order_date) AS first_order,
        MAX(s.order_date) AS last_order,
        PERIOD_DIFF(
            EXTRACT(YEAR_MONTH FROM MAX(s.order_date)),
            EXTRACT(YEAR_MONTH FROM MIN(s.order_date))
        ) AS lifespan
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_customers AS c
        ON s.customer_key = c.customer_key
    GROUP BY c.customer_key

)

SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (

    SELECT
        customer_key,
        CASE
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending

) AS t
GROUP BY customer_segment
ORDER BY total_customers DESC;
