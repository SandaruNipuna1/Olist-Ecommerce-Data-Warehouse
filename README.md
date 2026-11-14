<<<<<<< HEAD
# Olist E-Commerce Data Warehouse & Business Intelligence

A group project focused on building a data warehouse and developing business intelligence insights using the Olist Brazilian e-commerce dataset.

## Project Overview

This project demonstrates an end-to-end data warehousing and business intelligence workflow, covering exploratory data analysis, data staging, ETL processing, dimensional modelling, and interactive dashboard development.

## Technologies Used

- **Database:** Microsoft SQL Server, T-SQL
- **Business Intelligence:** Power BI, DAX
- **Data Analysis:** Python, Pandas, NumPy
- **Visualisation:** Matplotlib, Seaborn
- **Notebook Environment:** Google Colab

## Repository Structure

```text
2026-DS-27_DWBI/
├── 2026-DS-27_DWBI_Report.pdf
├── Olist_Ecommerce_EDA_COLAB (1).ipynb
├── Olist_Sales_Dashboard.pbix
├── SQL_files/
└── README.md
```

## Project Workflow

1. **Exploratory Data Analysis:** Examined the Olist e-commerce dataset using Python.
2. **Data Staging:** Prepared and loaded source data into SQL Server staging tables.
3. **ETL Processing:** Transformed and loaded data into the data warehouse.
4. **Dimensional Modelling:** Designed a star schema with fact and dimension tables.
5. **Data Mart Development:** Prepared analytical views and aggregations.
6. **Dashboard Development:** Built an interactive Power BI dashboard for business analysis.

## Dashboard

The Power BI dashboard provides an interactive view of e-commerce performance and business trends.

To explore it, download `Olist_Sales_Dashboard.pbix` and open it using Power BI Desktop.

## Project Files

| File | Description |
|---|---|
| `2026-DS-27_DWBI_Report.pdf` | Project documentation and report |
| `Olist_Ecommerce_EDA_COLAB (1).ipynb` | Exploratory data analysis notebook |
| `Olist_Sales_Dashboard.pbix` | Interactive Power BI dashboard |
| `SQL_files/` | SQL scripts used in the project |

## Reproducibility

The repository contains selected project deliverables. The original source datasets and SQL Server database backups are not included. Therefore, reproducing the complete workflow may require obtaining the original datasets and recreating the database environment.

## Academic Project

Completed as part of the Data Warehousing and Business Intelligence module at SLIIT.

**Group:** 27

=======
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
>>>>>>> a36c4f827bd0c0b02fa46f8567a2f5cc99d776b3
