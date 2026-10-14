/*
=============================================================================
Product Performance and Revenue Analysis
=============================================================================
Purpose:
    Consolidate product-level sales metrics to evaluate revenue
    performance, customer demand, and product activity.

Analysis:
    1. Retrieve product attributes and transaction details.
    2. Aggregate product-level sales, orders, quantities, and customers.
    3. Segment products according to total sales revenue.
    4. Calculate recency, average order revenue, average selling price,
       and average monthly revenue.
=============================================================================
*/

-- =============================================================================
-- 1. Product Report View
-- =============================================================================

CREATE OR REPLACE VIEW gold.report_products AS

WITH base_query AS (

    -- -------------------------------------------------------------------------
    -- Retrieve Product and Transaction Data
    -- -------------------------------------------------------------------------

    SELECT
        p.product_key,
        p.product_name,
        p.category,
        p.subcategory,
        p.cost,
        s.order_number,
        s.order_date,
        s.sales_amount,
        s.customer_key,
        s.quantity
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_products AS p
        ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL

),

product_aggregation AS (

    -- -------------------------------------------------------------------------
    -- Aggregate Product-Level Measures
    -- -------------------------------------------------------------------------

    SELECT
        product_key,
        product_name,
        category,
        subcategory,
        cost,

        PERIOD_DIFF(
            EXTRACT(YEAR_MONTH FROM MAX(order_date)),
            EXTRACT(YEAR_MONTH FROM MIN(order_date))
        ) AS product_lifespan,

        MAX(order_date) AS last_order_date,
        COUNT(DISTINCT order_number) AS total_orders,
        COUNT(DISTINCT customer_key) AS total_customers,
        SUM(sales_amount) AS total_sales,
        SUM(quantity) AS total_quantity_sold,

        ROUND(
            AVG(sales_amount / NULLIF(quantity, 0)), 2
        ) AS avg_selling_price

    FROM base_query
    GROUP BY
        product_key,
        product_name,
        category,
        subcategory,
        cost

)

SELECT
    product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_order_date,
    product_lifespan,

    -- -------------------------------------------------------------------------
    -- Product Recency
    -- -------------------------------------------------------------------------

    PERIOD_DIFF(
        EXTRACT(YEAR_MONTH FROM CURDATE()),
        EXTRACT(YEAR_MONTH FROM last_order_date)
    ) AS recency,

    total_orders,
    total_quantity_sold,
    total_customers,
    total_sales,

    -- -------------------------------------------------------------------------
    -- Product Revenue Segmentation
    -- -------------------------------------------------------------------------

    CASE
        WHEN total_sales > 50000 THEN 'High Performer'
        WHEN total_sales BETWEEN 10000 AND 50000 THEN 'Mid Performer'
        ELSE 'Low Performer'
    END AS product_segments,

    -- -------------------------------------------------------------------------
    -- Product Performance Indicators
    -- -------------------------------------------------------------------------

    CASE
        WHEN total_orders = 0 THEN 0
        ELSE ROUND(total_sales / total_orders, 2)
    END AS avg_order_revenue,

    avg_selling_price,

    CASE
        WHEN product_lifespan <= 0 THEN total_sales
        ELSE ROUND(total_sales / (product_lifespan + 1), 2)
    END AS avg_monthly_revenue

FROM product_aggregation;


-- =============================================================================
-- 2. Product Report Exploration
-- =============================================================================

-- Retrieve the complete product performance report.
SELECT *
FROM gold.report_products;
