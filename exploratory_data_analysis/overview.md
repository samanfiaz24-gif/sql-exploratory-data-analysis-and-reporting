# Exploratory Data Analysis Overview

## 1. Overview

The `exploratory_data_analysis` folder contains six SQL scripts that examine the structure, coverage, and key characteristics of the sales, customer, and product datasets. These queries establish an initial understanding of the available data through schema inspection, dimensional exploration, descriptive measures, aggregation, and ranking before more advanced analysis and reporting.

The scripts are written for **MySQL 8.0** and use the following datasets:

| Dataset | Purpose |
|---|---|
| `fact_sales` | Sales transactions, including order dates, sales amounts, quantities, orders, and customer/product keys |
| `dim_customers` | Customer attributes, including customer identifiers, countries, genders, and birth dates |
| `dim_products` | Product attributes, including product names, categories, subcategories, product lines, and costs |

## 2. Exploratory Approaches

| SQL file | Approach | What the script examines |
|---|---|---|
| [`01_database_schema_exploration.sql`](01_database_schema_exploration.sql) | Database Schema Exploration | Available tables, column names, and data types in the database schema |
| [`02_dimension_exploration.sql`](02_dimension_exploration.sql) | Dimension Exploration | Distinct customer and product attributes, including countries, categories, subcategories, and product names |
| [`03_temporal_analysis.sql`](03_temporal_analysis.sql) | Temporal Coverage Analysis | Earliest and latest sales dates, the span of recorded sales activity, and customer age boundaries |
| [`04_measures_analysis.sql`](04_measures_analysis.sql) | Descriptive Measures Analysis | Overall sales, quantities, average prices, distinct orders, products, and customers |
| [`05_magnitude_analysis.sql`](05_magnitude_analysis.sql) | Magnitude Analysis | Counts, sales, and quantities aggregated across customer and product dimensions |
| [`06_ranking_analysis.sql`](06_ranking_analysis.sql) | Ranking Analysis | Highest- and lowest-performing products and customers using sales and order activity |

### 2.1 Database Schema Exploration

**Definition:** Database schema exploration examines the organization and metadata of a database to understand which tables and columns are available and how the data is represented.

**File:** [`01_database_schema_exploration.sql`](01_database_schema_exploration.sql)

The script queries MySQL's `INFORMATION_SCHEMA` to inspect available tables and column definitions, including a closer examination of the customer dimension table.

**Analytical use:** Understand the structure of the source data and identify relevant fields before writing analytical queries.

### 2.2 Dimension Exploration

**Definition:** Dimension exploration investigates the distinct descriptive attributes used to categorize and interpret business records.

**File:** [`02_dimension_exploration.sql`](02_dimension_exploration.sql)

The script examines distinct customer countries and product attributes, including categories, subcategories, and product names.

**Analytical use:** Identify the business dimensions available for filtering, grouping, and comparing subsequent analytical results.

### 2.3 Temporal Coverage Analysis

**Definition:** Temporal coverage analysis establishes the time span represented in a dataset and examines relevant date-based characteristics.

**File:** [`03_temporal_analysis.sql`](03_temporal_analysis.sql)

The script identifies the earliest and latest recorded order dates and calculates the inclusive calendar-year and calendar-month coverage of sales. It also examines the earliest and latest customer birth dates and derives age-related measures.

**Analytical use:** Establish the reporting period and understand the time-related scope of the data before evaluating trends or customer characteristics.

### 2.4 Descriptive Measures Analysis

**Definition:** Descriptive measures analysis summarizes numerical and count-based properties of a dataset to provide an overall picture of business activity.

**File:** [`04_measures_analysis.sql`](04_measures_analysis.sql)

The script calculates total sales revenue, total quantity sold, average recorded price, distinct orders, products, and customers, including customers with recorded purchases. It also presents selected measures together in a consolidated result set.

**Analytical use:** Establish baseline business metrics that can be used to interpret more detailed analyses.

### 2.5 Magnitude Analysis

**Definition:** Magnitude analysis compares the size or total value of measures across categories and dimensions using aggregated counts, sums, or averages.

**File:** [`05_magnitude_analysis.sql`](05_magnitude_analysis.sql)

The script examines customer distributions by country and gender; product distributions by category and product line; average product costs by category; and sales revenue or quantity sold across products, customers, categories, and countries.

**Analytical use:** Compare the relative scale of customer groups, product groups, and geographic markets.

### 2.6 Ranking Analysis

**Definition:** Ranking analysis orders entities according to a selected performance measure to identify the highest and lowest results.

**File:** [`06_ranking_analysis.sql`](06_ranking_analysis.sql)

The script identifies top- and bottom-revenue products, ranks products using SQL window functions, and examines leading customers by sales alongside customers with the fewest recorded orders.

**Analytical use:** Identify notable products and customers for further investigation and performance comparison.

## 3. How to Use These Scripts

Each SQL file can be reviewed and executed independently in a **MySQL 8.0** environment once the source tables have been imported. The queries return exploratory result sets and do not create final stakeholder dashboards or reporting views.

Data and business analysts can use the results to assess data structure, establish baseline measures, identify important dimensions, and formulate questions for more advanced analysis. The `data_analytics` folder extends this exploratory work through trends, cumulative measures, comparisons, contributions, and segmentation, while the `Business_Reporting` folder provides reusable customer- and product-level reporting views.

## 4. Interpretation Notes

- Findings depend on the quality, completeness, and time coverage of the source datasets.
- Counts of distinct orders, customers, and products measure different aspects of activity and should not be treated as interchangeable.
- Rankings and category comparisons describe observed values; they do not independently explain the causes of performance differences.
- Descriptive statistics establish a baseline for further analysis rather than providing business recommendations on their own.
