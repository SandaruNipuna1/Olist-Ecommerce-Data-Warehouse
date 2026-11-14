/* =====================================================================
   03_load_staging.sql
   Purpose : Loads the 9 Olist CSV files into the Staging tables.

   BEFORE YOU RUN: edit @DataPath below (the ONLY line you need to change).
   The path is read by the SQL SERVER SERVICE, not by you, so:
     - use a plain folder such as C:\olist_dataset\archive\
     - do NOT use OneDrive / Desktop / Documents folders (access denied)

   Why these BULK INSERT options (verified against the real files):
     FORMAT = 'CSV', FIELDQUOTE = '"'
         The files quote SOME values and not others (e.g. "1234",abc).
         Without CSV mode the quote characters are loaded INTO the data,
         so keys like order_id differ between tables and joins silently
         lose rows. Some sellers/geolocation cities also contain commas
         inside quotes, and 3,852 review comments contain line breaks.
     ROWTERMINATOR = '0x0a'
         All 9 files use LF-only line endings. Using 0x0d0a (CRLF) finds
         no row breaks and loads ZERO rows with no error message.
     CODEPAGE = '65001'  -> UTF-8 (Portuguese accents)
     FIRSTROW = 2        -> skip the header row
     TABLOCK             -> faster bulk load

   Requires SQL Server 2017 or later (FORMAT = 'CSV').
   Safe to re-run: each table is truncated, then reloaded.
   ===================================================================== */
USE Olist_DW;
GO
SET NOCOUNT ON;

/* >>>>>>>>>>>>>>>>>>>>>>  EDIT THIS ONE LINE  <<<<<<<<<<<<<<<<<<<<<<<< */
DECLARE @DataPath NVARCHAR(400) = N'C:\olist_dataset\archive\';
/* >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> */

IF ISNULL(CAST(SERVERPROPERTY('ProductMajorVersion') AS INT), 0) < 14
    THROW 50001, 'SQL Server 2017 or later is required for BULK INSERT with FORMAT = CSV.', 1;

IF RIGHT(@DataPath, 1) <> N'\' SET @DataPath = @DataPath + N'\';

DECLARE @files TABLE (id INT IDENTITY(1,1), table_name SYSNAME, file_name NVARCHAR(200));
INSERT INTO @files (table_name, file_name) VALUES      -- smallest files first
    (N'Staging.stg_category_translation', N'product_category_name_translation.csv'),
    (N'Staging.stg_sellers',              N'olist_sellers_dataset.csv'),
    (N'Staging.stg_products',             N'olist_products_dataset.csv'),
    (N'Staging.stg_customers',            N'olist_customers_dataset.csv'),
    (N'Staging.stg_payments',             N'olist_order_payments_dataset.csv'),
    (N'Staging.stg_order_items',          N'olist_order_items_dataset.csv'),
    (N'Staging.stg_reviews',              N'olist_order_reviews_dataset.csv'),
    (N'Staging.stg_orders',               N'olist_orders_dataset.csv'),
    (N'Staging.stg_geolocation',          N'olist_geolocation_dataset.csv');

DECLARE @i INT = 1,
        @n INT = (SELECT COUNT(*) FROM @files),
        @t SYSNAME,
        @f NVARCHAR(200),
        @sql NVARCHAR(MAX),
        @c INT,
        @failed INT = 0;

PRINT N'Loading from: ' + @DataPath;
PRINT N'------------------------------------------------------------';

WHILE @i <= @n
BEGIN
    SELECT @t = table_name, @f = file_name FROM @files WHERE id = @i;

    BEGIN TRY
        SET @sql = N'TRUNCATE TABLE ' + @t + N';';
        EXEC (@sql);

        SET @sql = N'BULK INSERT ' + @t
                 + N' FROM ''' + @DataPath + @f + N''''
                 + N' WITH (FORMAT = ''CSV'', FIRSTROW = 2, FIELDQUOTE = ''"'','
                 + N' FIELDTERMINATOR = '','', ROWTERMINATOR = ''0x0a'','
                 + N' CODEPAGE = ''65001'', TABLOCK);';
        EXEC (@sql);

        SET @sql = N'SELECT @c = COUNT(*) FROM ' + @t + N';';
        EXEC sp_executesql @sql, N'@c INT OUTPUT', @c = @c OUTPUT;

        PRINT N'OK    ' + @t + N' : ' + FORMAT(@c, 'N0') + N' rows';
    END TRY
    BEGIN CATCH
        SET @failed += 1;
        PRINT N'FAIL  ' + @t + N' : ' + ERROR_MESSAGE();
    END CATCH;

    SET @i += 1;
END;

PRINT N'------------------------------------------------------------';
IF @failed = 0
    PRINT N'All 9 files loaded. Next: run 04_verify_staging.sql';
ELSE
    PRINT CAST(@failed AS NVARCHAR(10)) + N' file(s) failed - read the FAIL lines above (see README troubleshooting).';
GO
