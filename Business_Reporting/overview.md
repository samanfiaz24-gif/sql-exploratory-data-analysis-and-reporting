# Business Reporting Overview

## 1. Overview

The Business Reporting section develops reusable analytical datasets from sales, customer, and product data.

Using MySQL 8.0, transactional records are transformed into structured, business-oriented reporting views. These views consolidate key performance indicators (KPIs), customer and product attributes, and analytical segments to support business intelligence, further analysis, and stakeholder reporting.

The reporting layer consists of two views:

- **`report_customers`** — Customer Behavioral and Performance Report
- **`report_products`** — Product Performance and Revenue Report

These datasets serve as a foundation for subsequent analysis and visualization in Excel, Power BI, or Tableau.

## 2. Data Sources

The reporting views are developed using three datasets:

| Dataset | Description |
|---|---|
| `fact_sales` | Sales transactions, including orders, quantities, revenue, and transaction dates |
| `dim_customers` | Customer attributes, including customer identifiers, names, and demographic information |
| `dim_products` | Product attributes, including product names, categories, subcategories, and costs |

The datasets are joined using customer and product keys to combine transactional measures with relevant descriptive attributes.

## 3. Customer Reporting Dataset

**View:** `report_customers`

The customer reporting view consolidates sales transactions into one record per customer with recorded sales activity.

It provides customer attributes, purchasing metrics, and derived KPIs for evaluating customer behavior.

**Key measures and attributes:**

- Customer name, number, and age group
- Customer segmentation: VIP, Regular, and New
- Total orders and total sales
- Total quantity purchased and distinct products purchased
- Customer lifespan and purchase recency
- Average order value and average monthly spending

Customer segments are assigned using predefined thresholds based on customer lifespan and total spending.

This reporting dataset supports further analysis of customer value, purchasing frequency, demographic distribution, and engagement patterns.

## 4. Product Reporting Dataset

**View:** `report_products`

The product reporting view consolidates sales transactions into one record per product with recorded sales activity.

It provides product attributes, aggregated sales measures, and derived KPIs for evaluating product performance.

**Key measures and attributes:**

- Product name, category, subcategory, and cost
- Product segmentation: High Performer, Mid Performer, and Low Performer
- Total orders and total sales
- Total quantity sold and distinct customers
- Product lifespan and sales recency
- Average order revenue, average selling price, and average monthly revenue

Product segments are assigned using predefined total revenue thresholds.

This reporting dataset supports product performance comparisons, revenue ranking, demand analysis, and product portfolio evaluation.

## 5. Intended Users and Business Applications

The reporting datasets are designed for business analysts, BI analysts, sales analysts, and other stakeholders who require structured data for analysis and decision support.

**Business analysts** can consume these datasets in Excel, Tableau, or Power BI to build their own analytical views, investigate business questions, and create additional calculated fields, measures, and KPIs.

**BI analysts** can use the reporting views as data sources for interactive dashboards, recurring performance reports, and management reporting.

**Sales and marketing analysts** can examine customer purchasing behavior, customer segments, product demand, and revenue distribution to support further business investigation.

**Business managers and decision-makers** can consume the resulting reports and dashboards to monitor performance, compare business segments, and identify areas requiring attention.

The SQL reporting views provide standardized foundational measures while allowing downstream users to perform additional calculations and develop analyses according to their business requirements.

## 6. Recommended Visualizations

The following visualizations can be developed using the reporting datasets:

| Analysis | Recommended visualization | Tools |
|---|---|---|
| Customer segmentation | Customer count and revenue by segment | Excel, Tableau, Power BI |
| Customer demographics | Customer distribution and sales by age group | Excel, Tableau, Power BI |
| Customer engagement | Recency and purchasing frequency distribution | Tableau, Power BI |
| Product performance | Top and bottom products by revenue | Excel, Tableau, Power BI |
| Product segmentation | Revenue contribution by performance segment | Excel, Tableau, Power BI |
| Product demand | Quantity sold and customer reach by product | Tableau, Power BI |
| Category performance | Revenue and product distribution by category | Excel, Tableau, Power BI |

Additional measures and visualizations can be developed within these tools based on stakeholder requirements.

## 7. Reporting Considerations

The reporting views include only customers and products associated with recorded sales transactions that have valid order dates.

Customer and product recency are calculated relative to the current date. When working with historical data, these values should be interpreted in relation to the dataset's reporting period.

Customer and product segments are based on predefined analytical thresholds and should not be interpreted as independently validated business classifications.

The reporting views provide descriptive and aggregated measures; additional analysis is required to establish specific business findings or recommendations.

## 8. Conclusion

The Business Reporting layer transforms transactional sales data into reusable customer-level and product-level analytical datasets.

By centralizing essential metrics, segmentation logic, and KPIs in SQL views, the project establishes a consistent foundation for downstream business intelligence and exploratory analysis.

These datasets can subsequently be used in Excel, Tableau, or Power BI to develop visualizations, calculate additional measures, and communicate evidence-based findings to business stakeholders.
