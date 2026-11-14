/* =====================================================================
   01_create_database_and_schemas.sql
   Project : Olist E-Commerce Data Warehouse (DWBI assignment)
   Purpose : Creates the Olist_DW database and the layer schemas.
   Safe to re-run: it only creates what does not already exist.

   Schemas
     dbo        - default schema (unused)
     Staging    - raw, untyped copies of the 9 source CSV files
     Warehouse  - star schema (Fact_Order_Sales + dimensions)
     Mart       - department data marts (Sales / Customer / Delivery)
   ===================================================================== */

IF DB_ID(N'Olist_DW') IS NULL
    CREATE DATABASE Olist_DW;
GO

USE Olist_DW;
GO

IF SCHEMA_ID(N'Staging')   IS NULL EXEC (N'CREATE SCHEMA Staging');
IF SCHEMA_ID(N'Warehouse') IS NULL EXEC (N'CREATE SCHEMA Warehouse');
IF SCHEMA_ID(N'Mart')      IS NULL EXEC (N'CREATE SCHEMA Mart');
GO

-- Confirm
SELECT name AS schema_name
FROM sys.schemas
WHERE name IN (N'dbo', N'Staging', N'Warehouse', N'Mart')
ORDER BY name;
GO
