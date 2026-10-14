/*
=============================================================================
Customer Behavioral and Performance Report
=============================================================================
Purpose:
    Consolidate customer-level information and purchasing metrics to
    evaluate customer behavior, revenue contribution, and engagement.

Analysis:
    1. Retrieve customer attributes and transaction details.
    2. Segment customers by age and purchasing behavior.
    3. Aggregate customer-level sales, orders, products, and quantities.
    4. Calculate recency, average order value, and average monthly spending.
=============================================================================
*/

-- =============================================================================
-- 1. Customer Report View
-- =============================================================================

CREATE OR REPLACE VIEW gold.report_customers AS

WITH base_query AS (

    -- -------------------------------------------------------------------------
    -- Retrieve Customer and Transaction Data
    -- -------------------------------------------------------------------------

    SELECT
        s.order_number,
        s.product_key,
        s.order_date,
        s.sales_amount,
        s.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.firstname, ' ', c.lastname) AS customer_name,
        TIMESTAMPDIFF(YEAR, c.birthdate, CURDATE()) AS age
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_customers AS c
        ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL

),

customer_aggregation AS (

    -- -------------------------------------------------------------------------
    -- Aggregate Customer-Level Measures
    -- -------------------------------------------------------------------------

    SELECT
        customer_key,
        customer_number,
        customer_name,
        age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity_purchased,
        COUNT(DISTINCT product_key) AS total_products,
        MAX(order_date) AS last_order_date,
        PERIOD_DIFF(
            EXTRACT(YEAR_MONTH FROM MAX(order_date)),
            EXTRACT(YEAR_MONTH FROM MIN(order_date))
        ) AS customer_lifespan
    FROM base_query
    GROUP BY
        customer_key,
        customer_number,
        customer_name,
        age

)

SELECT
    customer_key,
    customer_number,
    customer_name,
    age,

    -- -------------------------------------------------------------------------
    -- Customer Age Segmentation
    -- -------------------------------------------------------------------------

    CASE
        WHEN age < 20 THEN 'Under 20'
        WHEN age BETWEEN 20 AND 29 THEN '20-29'
        WHEN age BETWEEN 30 AND 39 THEN '30-39'
        WHEN age BETWEEN 40 AND 49 THEN '40-49'
        WHEN age IS NULL THEN NULL
        ELSE '50 and above'
    END AS age_group,

    -- -------------------------------------------------------------------------
    -- Customer Behavioral Segmentation
    -- -------------------------------------------------------------------------

    CASE
        WHEN customer_lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
        WHEN customer_lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,

    last_order_date,

    PERIOD_DIFF(
        EXTRACT(YEAR_MONTH FROM CURDATE()),
        EXTRACT(YEAR_MONTH FROM last_order_date)
    ) AS recency,

    total_orders,
    total_sales,
    total_quantity_purchased,
    total_products,
    customer_lifespan,

    -- -------------------------------------------------------------------------
    -- Customer Performance Indicators
    -- -------------------------------------------------------------------------

    CASE
        WHEN total_orders = 0 THEN 0
        ELSE ROUND(total_sales / total_orders, 2)
    END AS avg_order_value,

    CASE
        WHEN customer_lifespan <= 0 THEN total_sales
        ELSE ROUND(total_sales / (customer_lifespan + 1), 2)
    END AS avg_monthly_spend

FROM customer_aggregation;


-- =============================================================================
-- 2. Customer Report Exploration
-- =============================================================================

-- Retrieve the complete customer report.
SELECT *
FROM gold.report_customers;


-- =============================================================================
-- 3. Customer Demographic Analysis
-- =============================================================================

-- Identify customers between 30 and 39 years of age.
SELECT
    customer_name,
    age
FROM gold.report_customers
WHERE age BETWEEN 30 AND 39;

-- Analyze customer distribution and revenue contribution by age group.
SELECT
    age_group,
    COUNT(customer_number) AS total_customers,
    SUM(total_sales) AS total_sales
FROM gold.report_customers
GROUP BY age_group;


-- =============================================================================
-- 4. Customer Segment Performance
-- =============================================================================

-- Evaluate customer distribution and revenue contribution by segment.
SELECT
    customer_segment,
    COUNT(customer_number) AS total_customers,
    SUM(total_sales) AS total_sales
FROM gold.report_customers
GROUP BY customer_segment;
