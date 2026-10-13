/*
=============================================================================
Comparative Performance Analysis
=============================================================================
Purpose:
    Evaluate annual product sales performance against historical averages
    and previous-year revenue to identify changes in product performance.

Analysis:
    1. Calculate annual sales revenue for each product.
    2. Compare annual revenue against average annual product revenue.
    3. Evaluate year-over-year revenue changes using window functions.
=============================================================================
*/

-- =============================================================================
-- 1. Annual Product Performance Comparison
-- =============================================================================

-- Compare yearly product revenue against historical averages and prior-year sales.

WITH yearly_product_sales AS (

    SELECT
        YEAR(s.order_date) AS order_year,
        p.product_key,
        p.product_name,
        SUM(s.sales_amount) AS current_sales
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_products AS p
        ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL
    GROUP BY
        YEAR(s.order_date),
        p.product_key,
        p.product_name

)

SELECT
    order_year,
    product_name,
    current_sales,

    -- -------------------------------------------------------------------------
    -- Historical Average Comparison
    -- -------------------------------------------------------------------------

    ROUND(
        AVG(current_sales) OVER (
            PARTITION BY product_key
        ), 2
    ) AS avg_sales,

    current_sales - ROUND(
        AVG(current_sales) OVER (
            PARTITION BY product_key
        ), 2
    ) AS diff_avg,

    CASE
        WHEN current_sales > AVG(current_sales) OVER (PARTITION BY product_key)
            THEN 'Above Avg'
        WHEN current_sales < AVG(current_sales) OVER (PARTITION BY product_key)
            THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,

    -- -------------------------------------------------------------------------
    -- Year-over-Year Performance Comparison
    -- -------------------------------------------------------------------------

    LAG(current_sales) OVER (
        PARTITION BY product_key
        ORDER BY order_year
    ) AS py_sales,

    current_sales - LAG(current_sales) OVER (
        PARTITION BY product_key
        ORDER BY order_year
    ) AS diff_py,

    CASE
        WHEN current_sales > LAG(current_sales) OVER (
            PARTITION BY product_key ORDER BY order_year
        ) THEN 'Increase'

        WHEN current_sales < LAG(current_sales) OVER (
            PARTITION BY product_key ORDER BY order_year
        ) THEN 'Decrease'

        ELSE 'No Change'
    END AS py_change

FROM yearly_product_sales
ORDER BY product_name, order_year;
