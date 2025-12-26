/* ============================================================
   Project: Data Warehouse Setup (Medallion Architecture)
   Author: Nagabharath
   Description:
   - Creates a Data Warehouse database
   - Implements Medallion Architecture schemas:
     Bronze  -> Raw Data
     Silver  -> Cleaned & Transformed Data
     Gold    -> Business-Ready Aggregates
   ============================================================ */

-- Switch to master database
USE master;
GO

-- Create Data Warehouse database
CREATE DATABASE data_Warehouse;
GO

-- Switch to Data Warehouse database
USE data_Warehouse;
GO

-- Create Bronze Schema (Raw Ingested Data)
CREATE SCHEMA bronze;
GO

-- Create Silver Schema (Cleaned & Transformed Data)
CREATE SCHEMA silver;
GO

-- Create Gold Schema (Business-Ready Data)
CREATE SCHEMA gold;
GO
