/*
=============================================================================
Part-to-Whole Analysis
=============================================================================
Purpose:
    Evaluate the contribution of individual product categories to
    overall sales revenue using proportional analysis.

Analysis:
    1. Calculate total sales revenue by product category.
    2. Determine overall sales revenue.
    3. Calculate each category's percentage contribution to total revenue.
=============================================================================
*/

-- =============================================================================
-- 1. Product Category Revenue Contribution
-- =============================================================================

-- Calculate each product category's contribution to overall sales revenue.

WITH category_sales AS (

    SELECT
        p.category,
        SUM(s.sales_amount) AS total_sales
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_products AS p
        ON s.product_key = p.product_key
    GROUP BY p.category

)

SELECT
    category,
    total_sales,
    SUM(total_sales) OVER () AS overall_sales,
    CONCAT(
        ROUND(
            (total_sales / NULLIF(SUM(total_sales) OVER (), 0)) * 100,
            2
        ),
        '%'
    ) AS percentage_of_total
FROM category_sales
ORDER BY total_sales DESC;
