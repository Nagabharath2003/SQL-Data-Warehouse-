/*
===============================================================================
Procedure Name : bronze.load_bronze
Author         : Nagabharath
Layer          : Bronze (Raw Ingestion Layer)
Purpose        :
    - Load raw CRM and ERP source data into Bronze schema
    - Truncate existing data and perform full reload
    - Track load duration for each table
    - Handle errors gracefully using TRY...CATCH

Data Sources   :
    - CSV files from local file system
    - CRM Source
    - ERP Source

Execution Type :
    - Manual / Scheduled (Batch Load)

===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    -- Declare variables to track load time
    DECLARE @START_TIME DATETIME,
            @END_TIME   DATETIME;

    BEGIN TRY
        PRINT '========================';
        PRINT 'Loading Bronze Layer';
        PRINT '========================';

        /* ============================================================
           CRM TABLE LOAD
           ============================================================ */
        PRINT '-------------------------';
        PRINT 'Loading CRM tables';
        PRINT '-------------------------';

        -- Load CRM Sales Details
        SET @START_TIME = GETDATE();

        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Users\nagab\OneDrive\Desktop\SQL_Warehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();
        PRINT '>> crm_sales_details Load Time: '
              + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
              + ' seconds';
        PRINT '-------------------------';

        -- Load CRM Customer Info
        SET @START_TIME = GETDATE();

        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Users\nagab\OneDrive\Desktop\SQL_Warehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();
        PRINT '>> crm_cust_info Load Time: '
              + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
              + ' seconds';
        PRINT '-------------------------';

        -- Load CRM Product Info
        SET @START_TIME = GETDATE();

        TRUNCATE TABLE bronze.crm_pro_info;

        BULK INSERT bronze.crm_pro_info
        FROM 'C:\Users\nagab\OneDrive\Desktop\SQL_Warehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();
        PRINT '>> crm_pro_info Load Time: '
              + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
              + ' seconds';
        PRINT '-------------------------';


        /* ============================================================
           ERP TABLE LOAD
           ============================================================ */
        PRINT '-------------------------';
        PRINT 'Loading ERP tables';
        PRINT '-------------------------';

        -- Load ERP Customer Table
        SET @START_TIME = GETDATE();

        TRUNCATE TABLE bronze.erp_CUST_AZ12;

        BULK INSERT bronze.erp_CUST_AZ12
        FROM 'C:\Users\nagab\OneDrive\Desktop\SQL_Warehouse\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();
        PRINT '>> erp_CUST_AZ12 Load Time: '
              + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
              + ' seconds';
        PRINT '-------------------------';

        -- Load ERP Location Table
        SET @START_TIME = GETDATE();

        TRUNCATE TABLE bronze.erp_LOC_A101;

        BULK INSERT bronze.erp_LOC_A101
        FROM 'C:\Users\nagab\OneDrive\Desktop\SQL_Warehouse\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();
        PRINT '>> erp_LOC_A101 Load Time: '
              + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
              + ' seconds';
        PRINT '-------------------------';

        -- Load ERP Product Category Table
        SET @START_TIME = GETDATE();

        TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

        BULK INSERT bronze.erp_PX_CAT_G1V2
        FROM 'C:\Users\nagab\OneDrive\Desktop\SQL_Warehouse\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @END_TIME = GETDATE();
        PRINT '>> erp_PX_CAT_G1V2 Load Time: '
              + CAST(DATEDIFF(SECOND, @START_TIME, @END_TIME) AS NVARCHAR)
              + ' seconds';
        PRINT '-------------------------';

        PRINT 'Bronze Layer Load Completed Successfully';

    END TRY
    BEGIN CATCH
        PRINT '-------------------------------------------------';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT ERROR_MESSAGE();
        PRINT '-------------------------------------------------';
    END CATCH
END;
GO

