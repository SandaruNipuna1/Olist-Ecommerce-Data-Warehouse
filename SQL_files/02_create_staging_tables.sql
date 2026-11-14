/* =====================================================================
   02_create_staging_tables.sql
   Purpose : Creates the 9 staging tables.

   DESIGN RULE: every column is NVARCHAR. Staging is a faithful,
   untyped landing zone. No type conversion happens here; dates and
   numbers are converted later with TRY_CAST / TRY_CONVERT in the
   transform step, so one bad value can never abort the whole load.
   NVARCHAR (not VARCHAR) keeps Portuguese characters intact.

   Column names/order match the CSV headers exactly (including the
   source's own misspelling "lenght" in the products file).
   Safe to re-run: drops and recreates the staging tables.
   ===================================================================== */
USE Olist_DW;
GO

-- 1. Orders  (olist_orders_dataset.csv)
DROP TABLE IF EXISTS Staging.stg_orders;
CREATE TABLE Staging.stg_orders
(
    order_id                        NVARCHAR(50),
    customer_id                     NVARCHAR(50),
    order_status                    NVARCHAR(30),
    order_purchase_timestamp        NVARCHAR(50),
    order_approved_at               NVARCHAR(50),
    order_delivered_carrier_date    NVARCHAR(50),
    order_delivered_customer_date   NVARCHAR(50),
    order_estimated_delivery_date   NVARCHAR(50)
);
GO

-- 2. Order items  (olist_order_items_dataset.csv)
DROP TABLE IF EXISTS Staging.stg_order_items;
CREATE TABLE Staging.stg_order_items
(
    order_id              NVARCHAR(50),
    order_item_id         NVARCHAR(10),
    product_id            NVARCHAR(50),
    seller_id             NVARCHAR(50),
    shipping_limit_date   NVARCHAR(50),
    price                 NVARCHAR(20),
    freight_value         NVARCHAR(20)
);
GO

-- 3. Customers  (olist_customers_dataset.csv)
DROP TABLE IF EXISTS Staging.stg_customers;
CREATE TABLE Staging.stg_customers
(
    customer_id                NVARCHAR(50),
    customer_unique_id         NVARCHAR(50),
    customer_zip_code_prefix   NVARCHAR(10),
    customer_city              NVARCHAR(100),
    customer_state             NVARCHAR(5)
);
GO

-- 4. Products  (olist_products_dataset.csv)
DROP TABLE IF EXISTS Staging.stg_products;
CREATE TABLE Staging.stg_products
(
    product_id                   NVARCHAR(50),
    product_category_name        NVARCHAR(100),
    product_name_lenght          NVARCHAR(10),   -- sic: spelling comes from the source file
    product_description_lenght   NVARCHAR(10),   -- sic
    product_photos_qty           NVARCHAR(10),
    product_weight_g             NVARCHAR(10),
    product_length_cm            NVARCHAR(10),
    product_height_cm            NVARCHAR(10),
    product_width_cm             NVARCHAR(10)
);
GO

-- 5. Sellers  (olist_sellers_dataset.csv)
DROP TABLE IF EXISTS Staging.stg_sellers;
CREATE TABLE Staging.stg_sellers
(
    seller_id                NVARCHAR(50),
    seller_zip_code_prefix   NVARCHAR(10),
    seller_city              NVARCHAR(100),
    seller_state             NVARCHAR(5)
);
GO

-- 6. Payments  (olist_order_payments_dataset.csv)
DROP TABLE IF EXISTS Staging.stg_payments;
CREATE TABLE Staging.stg_payments
(
    order_id               NVARCHAR(50),
    payment_sequential     NVARCHAR(10),
    payment_type           NVARCHAR(30),
    payment_installments   NVARCHAR(10),
    payment_value          NVARCHAR(20)
);
GO

-- 7. Reviews  (olist_order_reviews_dataset.csv)
--    Free-text comments contain commas and line breaks -> NVARCHAR(MAX)
DROP TABLE IF EXISTS Staging.stg_reviews;
CREATE TABLE Staging.stg_reviews
(
    review_id                 NVARCHAR(50),
    order_id                  NVARCHAR(50),
    review_score              NVARCHAR(5),
    review_comment_title      NVARCHAR(200),
    review_comment_message    NVARCHAR(MAX),
    review_creation_date      NVARCHAR(50),
    review_answer_timestamp   NVARCHAR(50)
);
GO

-- 8. Geolocation  (olist_geolocation_dataset.csv)  ~1,000,163 rows, duplicates kept on purpose
DROP TABLE IF EXISTS Staging.stg_geolocation;
CREATE TABLE Staging.stg_geolocation
(
    geolocation_zip_code_prefix   NVARCHAR(10),
    geolocation_lat               NVARCHAR(30),
    geolocation_lng               NVARCHAR(30),
    geolocation_city              NVARCHAR(100),
    geolocation_state             NVARCHAR(5)
);
GO

-- 9. Category translation  (product_category_name_translation.csv)
DROP TABLE IF EXISTS Staging.stg_category_translation;
CREATE TABLE Staging.stg_category_translation
(
    product_category_name           NVARCHAR(100),
    product_category_name_english   NVARCHAR(100)
);
GO

-- Confirm: should list 9 tables
SELECT s.name AS schema_name, t.name AS table_name
FROM sys.tables t
JOIN sys.schemas s ON s.schema_id = t.schema_id
WHERE s.name = N'Staging'
ORDER BY t.name;
GO
