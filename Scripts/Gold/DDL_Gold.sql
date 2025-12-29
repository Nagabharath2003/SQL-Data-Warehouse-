/****************************************************************************************
 Project Name : Enterprise Data Warehouse – Gold Layer
 Schema       : Gold
 Author       : Nagabharath
 Object Type  : Views (Dimensions & Facts)
 Description  :
    This script creates Gold-layer dimensional and fact views using
    cleansed and standardized Silver-layer data.

 Gold Layer Purpose:
    • Business-ready datasets
    • Dimensional modeling (Star Schema)
    • Optimized for BI & Analytics consumption

 Modeling Approach:
    • Dimensions: Product, Customer
    • Fact: Sales
    • Surrogate keys generated using ROW_NUMBER()

****************************************************************************************/


/****************************************************************************************
 Create Dimension : Gold.Dim_Product
 Description:
    Product dimension containing product hierarchy, category, cost,
    and maintenance details. Only active products are included.
****************************************************************************************/
PRINT '===================================================='
PRINT 'Create Dimension: Gold.Dim_Product'
PRINT '===================================================='

IF OBJECT_ID('Gold.Dim_Product','V') IS NOT NULL
    DROP VIEW Gold.Dim_Product;
GO

CREATE VIEW Gold.Dim_Product AS
SELECT
    ROW_NUMBER() OVER (ORDER BY pr.prd_start_dt, pr.pro_key) AS Product_key,
    pr.pro_id            AS Product_id,
    pr.cat_id            AS Category_id,
    px.CAT               AS Category,
    px.SUBCAT            AS Sub_Category,
    pr.pro_key           AS Product_num,
    pr.prd_nm            AS Product_name,
    pr.prd_cost          AS Product_cost,
    pr.prd_line          AS Product_line,
    px.MAINTENANCE       AS Maintenance,
    pr.prd_start_dt      AS Product_start_date
FROM Silver.crm_pro_info pr
LEFT JOIN Silver.erp_PX_CAT_G1V2 px
    ON pr.cat_id = px.ID
WHERE pr.prd_end_dt IS NULL;
GO


/****************************************************************************************
 Create Dimension : Gold.Dim_Customer
 Description:
    Customer dimension combining CRM and ERP customer data,
    enriched with demographics and location details.
****************************************************************************************/
PRINT '===================================================='
PRINT 'Create Dimension: Gold.Dim_Customer'
PRINT '===================================================='

IF OBJECT_ID('Gold.Dim_Customer','V') IS NOT NULL
    DROP VIEW Gold.Dim_Customer;
GO

CREATE VIEW Gold.Dim_Customer AS
SELECT
    ROW_NUMBER() OVER (ORDER BY cu.cst_id) AS Customer_key,
    cu.cst_id            AS Customer_id,
    cu.cst_key           AS Customer_num,
    cu.cst_firstname     AS First_name,
    cu.cst_lastname      AS Last_name,
    la.CNTRY             AS Country,
    cu.cst_marital_status AS Marital_status,
    ca.BDATE             AS Birth_date,
    CASE 
        WHEN cu.cst_gndr <> 'n/a' THEN cu.cst_gndr
        ELSE COALESCE(ca.GEN, 'n/a')
    END                  AS Gender,
    cu.cst_create_date   AS Create_date
FROM Silver.crm_cust_info cu
-- Left joins used to retain all CRM customers
LEFT JOIN Silver.erp_CUST_AZ12 ca
    ON cu.cst_key = ca.CID
LEFT JOIN Silver.erp_LOC_A101 la
    ON cu.cst_key = la.CID;
GO


/****************************************************************************************
 Create Fact : Gold.Fact_Sales
 Description:
    Sales fact view storing transactional sales data.
    Linked to Product and Customer dimensions using surrogate keys.
****************************************************************************************/
PRINT '===================================================='
PRINT 'Create Fact: Gold.Fact_Sales'
PRINT '===================================================='

IF OBJECT_ID('Gold.Fact_Sales','V') IS NOT NULL
    DROP VIEW Gold.Fact_Sales;
GO

CREATE VIEW Gold.Fact_Sales AS
SELECT 
    sc.sls_ord_num        AS Order_number,
    gp.Product_key,
    gc.Customer_key,
    sc.sls_order_dt       AS Order_date,
    sc.sls_ship_dt        AS Shipped_date,
    sc.sls_due_dt         AS Due_date,
    sc.sls_sales          AS Sales,
    sc.sls_quantity       AS Quantity,
    sc.sls_price          AS Price
FROM Silver.crm_sales_details sc
LEFT JOIN Gold.Dim_Customer gc
    ON gc.Customer_id = sc.sls_cust_id
LEFT JOIN Gold.Dim_Product gp
    ON gp.Product_num = sc.sls_prd_key;
GO


/****************************************************************************************
 END OF GOLD LAYER SCRIPT

 Notes:
    • Views follow Star Schema principles
    • Surrogate keys generated dynamically
    • Designed for reporting & BI tools (Power BI, Tableau)
    • No aggregations applied at view level

 Next Steps:
    → Create Gold Date Dimension
    → Materialize views into tables if required
    → Add semantic layer / Power BI model
****************************************************************************************/
