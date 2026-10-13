/*
=============================================================================
Dimensional Attribute Exploration
=============================================================================
Purpose:
    Explore categorical attributes within customer and product dimensions
    to understand geographic coverage and product classification.

Analysis:
    1. Identify distinct customer countries.
    2. Examine product categories, subcategories, and product names.
=============================================================================
*/

-- =============================================================================
-- 1. Geographic Attribute Exploration
-- =============================================================================

-- Identify distinct countries represented in the customer dimension.
SELECT DISTINCT
    country
FROM gold.dim_customers
ORDER BY country;


-- =============================================================================
-- 2. Product Hierarchy Exploration
-- =============================================================================

-- Examine the classification of products across categories and subcategories.
SELECT DISTINCT
    category,
    subcategory,
    product_name
FROM gold.dim_products
ORDER BY
    category,
    subcategory,
    product_name;
