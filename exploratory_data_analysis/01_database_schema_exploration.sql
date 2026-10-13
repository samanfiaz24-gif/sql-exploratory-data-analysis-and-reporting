/*
=============================================================================
Database Schema Exploration
=============================================================================
Purpose:
    Examine the database structure and metadata to understand the
    available tables, views, and column definitions.

Analysis:
    1. Identify available database objects.
    2. Examine column-level metadata.
    3. Inspect the structure of the customer dimension.
=============================================================================
*/

-- =============================================================================
-- 1. Database Object Exploration
-- =============================================================================

-- Identify available tables and views.
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'gold';


-- =============================================================================
-- 2. Column Metadata Exploration
-- =============================================================================

-- Examine column definitions across the Gold schema.
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold'
ORDER BY TABLE_NAME, ORDINAL_POSITION;


-- =============================================================================
-- 3. Customer Dimension Schema Exploration
-- =============================================================================

-- Inspect column definitions in the customer dimension.
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold'
  AND TABLE_NAME = 'dim_customers'
ORDER BY ORDINAL_POSITION;
