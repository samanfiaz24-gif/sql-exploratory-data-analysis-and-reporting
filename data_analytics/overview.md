# Data Analytics Overview

## 1. Overview

The `data_analytics` folder contains five SQL scripts that apply analytical techniques to sales, customer, and product data. Building on exploratory data analysis, these queries examine changes over time, cumulative results, performance against benchmarks, revenue contribution, and customer and product segments.

The scripts are written for **MySQL 8.0** and use the following datasets:

| Dataset | Purpose |
|---|---|
| `fact_sales` | Sales transactions, including order dates, sales amounts, quantities, orders, and customer/product keys |
| `dim_customers` | Customer information used for customer-level analysis |
| `dim_products` | Product attributes, categories, and costs used for product-level analysis |

## 2. Analytical Approaches

| SQL file | Approach | What the script examines |
|---|---|---|
| [`01_trend_analysis.sql`](01_trend_analysis.sql) | Temporal Trend Analysis | Yearly and monthly sales activity, including revenue, quantities, and distinct purchasing customers |
| [`02_cumulative_analysis.sql`](02_cumulative_analysis.sql) | Cumulative and Moving Average Analysis | Running sales totals over time and historical averages of annual prices |
| [`03_performance_analysis.sql`](03_performance_analysis.sql) | Comparative Performance Analysis | Annual product sales compared with historical average sales and prior-year results |
| [`04_contribution_analysis.sql`](04_contribution_analysis.sql) | Part-to-Whole Analysis | Each product category's share of total sales revenue |
| [`05_segmentation_analysis.sql`](05_segmentation_analysis.sql) | Data Segmentation Analysis | Product groups based on cost and customer groups based on spending and purchasing lifespan |

### 2.1 Temporal Trend Analysis

**Definition:** Temporal trend analysis examines how business measures change across consecutive time periods to identify patterns, growth, or decline.

**File:** [`01_trend_analysis.sql`](01_trend_analysis.sql)

The script groups transactions by year and month to summarize total sales revenue, quantity sold, and distinct customers who placed orders. Monthly results are ordered chronologically to support time-series comparisons.

**Analytical use:** Understand the timing and direction of changes in sales activity.

### 2.2 Cumulative and Moving Average Analysis

**Definition:** Cumulative analysis tracks the progressive total of a measure over time. Moving and expanding averages summarize a series of observations to provide a broader perspective on changes.

**File:** [`02_cumulative_analysis.sql`](02_cumulative_analysis.sql)

The script calculates running sales totals at annual and monthly levels, including monthly cumulative sales that restart each calendar year. It also examines the running average of annual prices using SQL window functions.

**Analytical use:** Monitor sales accumulation and compare period-level results with longer-term patterns.

*Methodological note:* An average calculated over all preceding years is an **expanding average**, rather than a fixed-period moving average.

### 2.3 Comparative Performance Analysis

**Definition:** Comparative performance analysis evaluates a measure against a reference point, such as a historical average or a previous period.

**File:** [`03_performance_analysis.sql`](03_performance_analysis.sql)

The script aggregates annual sales by product and compares current annual sales with each product's historical annual average. It also uses the `LAG()` window function to compare a product's sales with its preceding available year, reporting differences and performance classifications.

**Analytical use:** Identify products performing above or below their historical benchmark and examine year-over-year changes.

### 2.4 Part-to-Whole Analysis

**Definition:** Part-to-whole analysis measures how much each component contributes to an overall total, commonly expressed as a percentage.

**File:** [`04_contribution_analysis.sql`](04_contribution_analysis.sql)

The script aggregates revenue by product category, calculates overall sales revenue, and expresses each category's contribution as a percentage of the total.

**Analytical use:** Assess the distribution of revenue across product categories and identify areas of revenue concentration.

### 2.5 Data Segmentation Analysis

**Definition:** Data segmentation divides records into groups using defined characteristics or thresholds, making patterns easier to compare across groups.

**File:** [`05_segmentation_analysis.sql`](05_segmentation_analysis.sql)

The script performs two types of segmentation:

- **Product cost segmentation:** Classifies products into cost bands (Below 100, 100–500, 500–1000, and Above 1000) and counts products in each band.
- **Customer behavioral segmentation:** Groups purchasing customers into VIP, Regular, and New segments based on total spending and the number of months between their first and last recorded orders. VIP customers have a lifespan of at least 12 months and spending above 5,000; Regular customers have a lifespan of at least 12 months and spending of 5,000 or less; remaining customers are classified as New.

**Analytical use:** Compare product mix and customer purchasing characteristics across consistently defined groups.

## 3. How to Use These Scripts

Each SQL file can be reviewed and executed independently in a MySQL 8.0 environment after the source tables are available. The queries produce analytical result sets for further investigation rather than creating a final stakeholder dashboard.

Business and data analysts can use these results to explore business questions, validate patterns, and develop subsequent calculations or visualizations in Excel, Tableau, or Power BI. The separate `Business_Reporting` folder contains reusable customer-level and product-level reporting views intended for downstream reporting.

## 4. Interpretation Notes

- Findings depend on the coverage and quality of the underlying transaction data.
- Historical comparisons describe observed changes; they do not, by themselves, establish the causes of those changes.
- Segment boundaries are predefined analytical rules and should be interpreted in that context.
- Numerical findings and business recommendations should be documented after executing the queries and reviewing their actual results.
