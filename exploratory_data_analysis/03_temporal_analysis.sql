/*
=============================================================================
Temporal Coverage Analysis
=============================================================================
Purpose:
    Examine the date ranges of sales transactions and customer birthdates
    to understand the temporal scope of the dataset.

Analysis:
    1. Determine the first and last sales order dates.
    2. Calculate the inclusive sales coverage in years and months.
    3. Identify the oldest and youngest customers.
=============================================================================
*/

-- =============================================================================
-- 1. Sales Date Range Exploration
-- =============================================================================

-- Identify the first and last order dates and inclusive calendar-year coverage.
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    YEAR(MAX(order_date)) - YEAR(MIN(order_date)) + 1 AS order_range_years
FROM gold.fact_sales;


-- =============================================================================
-- 2. Monthly Sales Coverage
-- =============================================================================

-- Calculate the inclusive number of calendar months covered by sales records.
SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    PERIOD_DIFF(
        EXTRACT(YEAR_MONTH FROM MAX(order_date)),
        EXTRACT(YEAR_MONTH FROM MIN(order_date))
    ) + 1 AS order_range_months
FROM gold.fact_sales;


-- =============================================================================
-- 3. Customer Age Exploration
-- =============================================================================

-- Identify the oldest and youngest customers based on their birthdates.
SELECT
    MIN(birthdate) AS oldest_customer_birthdate,
    TIMESTAMPDIFF(YEAR, MIN(birthdate), CURDATE()) AS oldest_customer_age,
    MAX(birthdate) AS youngest_customer_birthdate,
    TIMESTAMPDIFF(YEAR, MAX(birthdate), CURDATE()) AS youngest_customer_age
FROM gold.dim_customers;
