# MySQL Data Analytics and Reporting Project

## Overview

This project uses **MySQL 8.0** to explore and analyze sales, customer, and product data. It progresses from exploratory data analysis to analytical SQL queries and reusable business reporting views.

The datasets were exported from the Gold layer of my separate MySQL data warehouse project.

The project demonstrates practical skills in:

- SQL and exploratory data analysis
- Aggregations and window functions
- Trend and comparative performance analysis
- Customer and product segmentation
- KPI development and business reporting

---

## Analysis Workflow

The project is organized into three stages:

### Exploratory Data Analysis

Examines the data structure, dimensions, date coverage, key measures, distributions, and rankings to establish an understanding of the datasets.

### Data Analytics

Applies trend, cumulative, comparative performance, contribution, and segmentation analyses to sales, customer, and product data.

### Business Reporting

Creates customer- and product-level SQL views containing aggregated metrics, segments, and KPIs for use in further analysis and reporting.

---

## Data Model

The analysis uses three related datasets derived from the warehouse's Gold-layer Star Schema:

| Dataset | Description |
|---|---|
| `fact_sales.csv` | Sales transactions, order dates, quantities, prices, and sales amounts. |
| `dim_customers.csv` | Customer identifiers and demographic attributes. |
| `dim_products.csv` | Product details, categories, and costs. |

Sales records are associated with customers and products through their respective keys.

---

## Repository Structure

```text
sql-exploratory-data-analysis-and-reporting/
│
├── dataset/
│   ├── dim_customers.csv
│   ├── dim_products.csv
│   └── fact_sales.csv
│
├── exploratory_data_analysis/
│   ├── overview.md
│   ├── 01_database_schema_exploration.sql
│   ├── 02_dimension_exploration.sql
│   ├── 03_temporal_analysis.sql
│   ├── 04_measures_analysis.sql
│   ├── 05_magnitude_analysis.sql
│   └── 06_ranking_analysis.sql
│
├── data_analytics/
│   ├── overview.md
│   ├── 01_trend_analysis.sql
│   ├── 02_cumulative_analysis.sql
│   ├── 03_performance_analysis.sql
│   ├── 04_contribution_analysis.sql
│   └── 05_segmentation_analysis.sql
│
├── Business_Reporting/
│   ├── overview.md
│   ├── report_customers.sql
│   └── report_products.sql
│
└── README.md
```

---

## Data Flow

```text
Gold-Layer CSV Exports
          ↓
     MySQL Tables
          ↓
Exploratory Data Analysis
          ↓
     Data Analytics
          ↓
    Reporting Views
          ↓
Further Analysis / Visualization
```

---

## Documentation

Each analytical folder contains an overview of its methods and SQL scripts:

| Document | Description |
|---|---|
| [Exploratory Data Analysis](exploratory_data_analysis/overview.md) | Schema, dimension, temporal, measure, magnitude, and ranking exploration. |
| [Data Analytics](data_analytics/overview.md) | Trend, cumulative, performance, contribution, and segmentation analysis. |
| [Business Reporting](Business_Reporting/overview.md) | Customer and product reporting views, metrics, and intended uses. |

---

## How to Run the Project

1. Import the CSV files from `dataset/` into MySQL as `dim_customers`, `dim_products`, and `fact_sales`.
2. Run the scripts in `exploratory_data_analysis/` to examine the datasets.
3. Run the scripts in `data_analytics/` to perform the analytical queries.
4. Run `Business_Reporting/report_customers.sql` and `Business_Reporting/report_products.sql` to create the reporting views.

The scripts use **MySQL 8.0 syntax**. Table and view references may need adjustment if your database uses different names or schemas.

---

## Tools & Technologies

- MySQL 8.0
- MySQL Workbench
- SQL
- CSV
- Git & GitHub

---

## Credits & Attribution

The source data originates from [DataWithBaraa's Data Warehouse and Analytics Project](https://github.com/DataWithBaraa/sql-data-warehouse-project). It was processed in my separate MySQL data warehouse implementation and exported from its Gold layer for this analysis project. The analysis is inspired by the original project but has been adapted and extended. 

---

## About Me

I am a Business Analytics graduate with a background in Accounting and Finance, interested in using data to understand business performance and support informed decision-making.

My work focuses on SQL, data analysis, data warehousing, and business intelligence. I use tools such as MySQL, Python, Excel, Power BI, and Tableau to prepare data, investigate business questions, and communicate findings.

Through this project, I have applied SQL to explore sales data, analyze customer and product performance, and develop reusable reporting datasets for further analysis and visualization.

**LinkedIn:** [linkedin.com/in/samanfiaz24](https://www.linkedin.com/in/samanfiaz24)
