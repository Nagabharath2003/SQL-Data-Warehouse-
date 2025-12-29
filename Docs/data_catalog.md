# 📊 Gold Layer Data Catalog

## Overview
The Gold layer represents business-ready, analytics-optimized datasets
designed using dimensional modeling principles.

These tables are consumed by:
- Power BI / Tableau dashboards
- Business analytics & reporting
- KPI tracking and decision support

## Modeling Approach
- Star Schema
- Conformed Dimensions
- Historical tracking where applicable (SCD)

## Refresh Strategy
- Full refresh (daily)
- Built from Silver layer standardized data

## Tables Included
| Table Name | Type | Description |
|-----------|------|-------------|
| dim_customer | Dimension | Customer master with demographics |
| dim_product | Dimension | Product hierarchy & attributes |
| dim_date | Dimension | Calendar attributes |
| fact_sales | Fact | Sales transactions & metrics |
# 🧍‍♂️ dim_customer

## Business Description
Stores cleaned and unified customer information used across all
sales and customer analytics.

## Grain
One row per customer (latest snapshot).

## Source Tables
- Silver.crm_cust_info
- Silver.erp_CUST_AZ12
- Silver.erp_LOC_A101

## Key Columns
| Column Name | Data Type | Description |
|-----------|-----------|-------------|
| customer_key | INT | Surrogate key |
| customer_id | INT | Business customer ID |
| first_name | NVARCHAR | Customer first name |
| last_name | NVARCHAR | Customer last name |
| gender | NVARCHAR | Standardized gender |
| marital_status | NVARCHAR | Standardized marital status |
| birth_date | DATE | Customer date of birth |
| country | NVARCHAR | Customer country |
| record_start_date | DATE | SCD start date |
| record_end_date | DATE | SCD end date |
| is_current | BIT | Current active record flag |

## Business Rules
- Gender standardized to Male/Female/N/A
- Country standardized using ERP master
- Latest active record marked as `is_current = 1`

## Usage Example
Used for:
- Customer segmentation
- Demographic analysis
- Sales by geography
# 📦 dim_product

## Business Description
Contains product hierarchy and pricing information.

## Grain
One row per product per effective date.

## Source Tables
- Silver.crm_pro_info
- Silver.erp_PX_CAT_G1V2

## Key Columns
| Column Name | Description |
|------------|-------------|
| product_key | Surrogate key |
| product_code | Business product key |
| product_name | Product name |
| category | Product category |
| sub_category | Product sub-category |
| product_line | Product line |
| cost | Product cost |
| start_date | Effective start date |
| end_date | Effective end date |

## Business Rules
- End date derived using next product start date
- Product line standardized

## Usage Example
- Product performance analysis
- Margin & cost reporting
# 💰 fact_sales

## Business Description
Stores transactional sales data at order line level.

## Grain
One row per order per product per customer per day.

## Source Tables
- Silver.crm_sales_details
- Gold.dim_customer
- Gold.dim_product
- Gold.dim_date

## Measures
| Column Name | Description |
|-----------|-------------|
| sales_amount | Total sales amount |
| quantity | Units sold |
| price | Unit price |

## Foreign Keys
| FK Column | References |
|---------|------------|
| customer_key | dim_customer |
| product_key | dim_product |
| date_key | dim_date |

## Business Rules
- Sales recalculated if invalid in source
- Dates validated before loading

## Usage Example
- Revenue dashboards
- Trend analysis
- KPI reporting
