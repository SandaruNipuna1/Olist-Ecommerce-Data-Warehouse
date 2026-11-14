# Olist E-Commerce Data Warehouse and BI

An end-to-end data warehousing and business intelligence project built around the Brazilian Olist e-commerce dataset. The supplied artifacts cover SQL Server staging and warehouse workflows, exploratory analysis in Python, and a Power BI dashboard.

## Contents

- `sql/` — T-SQL scripts for staging, ETL, warehouse tables, validation, and a sales mart.
- `notebooks/olist_ecommerce_eda.ipynb` — Google Colab EDA notebook for the Olist CSV datasets.
- `dashboard/Olist_Sales_Dashboard.pbix` — Power BI dashboard.

## Requirements

- Microsoft SQL Server and a SQL client that supports T-SQL and `GO` batch separators.
- The nine Olist CSV files referenced by the SQL and notebook; dataset files are not included.
- Google Colab or Jupyter with pandas, NumPy, Matplotlib, and Seaborn for the notebook.
- Power BI Desktop for the dashboard.

## SQL workflow

Run scripts `01` through `10` in `sql/` order. Before running, review the scripts and edit the CSV directory in `03_load_staging.sql` for the path accessible to the SQL Server service account. Some scripts create or truncate tables.

## Attribution and sharing

The project uses the Brazilian E-Commerce Public Dataset by Olist. Check the dataset terms and attribution requirements before redistributing dataset files. No code license was supplied. Group approval for public sharing was confirmed. The project report is excluded pending a separate privacy review.
