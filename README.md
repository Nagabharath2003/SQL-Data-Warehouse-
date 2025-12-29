# 🚀 SQL Data Warehouse from Scratch  
### End-to-End Data Engineering Project  
**Medallion Architecture | Star Schema | Enterprise SQL Design**

---

## 📌 Project Overview

This project showcases the **design and implementation of a real-world SQL Data Warehouse from scratch**, following **industry-standard data engineering best practices**.

The solution transforms **raw operational data** from multiple source systems into **analytics-ready datasets** using a **layered Medallion Architecture** and **dimensional modeling (Star Schema)**.

🔹 Designed for BI & reporting  
🔹 Built with scalability & maintainability in mind  
🔹 Focused on real enterprise use cases  

---

## 🧠 Business Problem

Modern organizations collect data from multiple systems such as **CRM, ERP, and Sales platforms**, but face challenges like:

❌ Raw and inconsistent data  
❌ Poor data quality  
❌ No analytics-ready structure  
❌ Difficult and slow reporting  

---

## ✅ Solution Approach

A **centralized SQL Data Warehouse** was built to:

✔ Ingest raw source data  
✔ Clean and standardize records  
✔ Apply business rules  
✔ Deliver analytics-optimized fact & dimension tables  

---

## 🏗️ Data Architecture

### Architecture Type
- **Data Warehouse**
- **Medallion Architecture**

### Layered Design
- **Bronze** → Raw data ingestion  
- **Silver** → Cleaned & standardized data  
- **Gold** → Business-ready analytics models  

This separation ensures:
- Clear data ownership  
- Easy debugging  
- Scalable ETL pipelines
---

<p align="center">
  <img src="Images/Picture1.png" width="80%" />
</p>

---

## 🥉 Bronze Layer — Raw Data Ingestion

### 🎯 Purpose
The Bronze layer stores **raw, unprocessed data exactly as received from source systems**.

### Key Characteristics
- No transformations applied
- Source-aligned schemas
- Acts as a system of record

### SQL & Engineering Skills Used
- DDL & DML
- CSV ingestion using `BULK INSERT`
- Stored Procedures for ingestion logic
- Schema-based layer isolation

---

## 🥈 Silver Layer — Data Cleansing & Transformation

### 🎯 Purpose
The Silver layer focuses on **data quality, consistency, and standardization**.

### Transformations Applied
✔ Duplicate removal  
✔ NULL value handling  
✔ String trimming & formatting  
✔ Standardization of codes and abbreviations  
✔ Normalization of attributes  
✔ Data enrichment  

### SQL Concepts & Functions Used
- `ROW_NUMBER()` for deduplication  
- `TRIM()` for string cleanup  
- `SUBSTRING()` for attribute extraction  
- `ISNULL()` for null handling  
- `LEAD()` for historical logic  
- Window Functions  
- Data validation rules  



### 🥇 Gold Layer — Business-Ready Analytics

### 🎯 Purpose
The **Gold Layer** represents the **final, analytics-optimized datasets** designed for direct consumption by:

- 📊 Power BI / Tableau dashboards  
- 📈 Business analytics & KPI reporting  
- 🧠 Decision-making systems  

This layer follows **dimensional modeling best practices** to ensure **performance, clarity, and scalability**.

---

## ⭐ Dimensional Modeling Approach

### Selected Model: **Star Schema**

**Why Star Schema?**
- ✅ Simple and intuitive design
- ✅ High query performance
- ✅ BI-tool friendly
- ✅ Industry standard for analytics

### Core Components
- **Fact Table** → Quantitative business metrics  
- **Dimension Tables** → Descriptive attributes  

---

## 📊 Gold Layer Data Models

### 🧍‍♂️ `dim_customer` — Customer Dimension

**Business Description**  
Stores clean and unified customer information used across all analytics.

**Grain**  
One row per customer (latest snapshot).

**Key Attributes**
- Customer demographics
- Geographic details
- Standardized gender & marital status

**Business Rules**
- Gender standardized to `Male / Female / N/A`
- Latest active record flagged
- Country standardized using ERP master

**Use Cases**
- Customer segmentation
- Demographic analysis
- Sales by geography

---

### 📦 `dim_product` — Product Dimension

**Business Description**  
Contains product hierarchy, categories, and cost information.

**Grain**  
One row per product per effective date.

**Key Attributes**
- Product name
- Category & sub-category
- Product line
- Cost & pricing details

**Business Rules**
- Product hierarchy standardized
- Effective dates handled for historical tracking

**Use Cases**
- Product performance analysis
- Margin & cost reporting

---

### 💰 `fact_sales` — Sales Fact Table

**Business Description**  
Stores transactional sales data at the most granular level.

**Grain**  
One row per:
- Order
- Product
- Customer
- Day

**Measures**
- Sales amount
- Quantity sold
- Unit price

**Foreign Keys**
- Customer Key
- Product Key
- Date Key

**Business Rules**
- Invalid sales recalculated
- Dates validated before load

**Use Cases**
- Revenue dashboards
- Trend analysis
- KPI reporting

---

## 👁️ SQL Views (Analytics Layer)

To simplify analytics access, **SQL Views** were created for:

- Customer Dimension
- Product Dimension
- Sales Fact Table

> Views act as **virtual tables** that encapsulate business logic without duplicating data, ensuring consistency across reports.

---

## 📚 Gold Layer Data Catalog

| Table Name     | Table Type | Description |
|---------------|-----------|-------------|
| dim_customer  | Dimension | Customer master & demographics |
| dim_product   | Dimension | Product hierarchy & attributes |
| fact_sales    | Fact      | Sales transactions & metrics |

---

## ⚙️ Key SQL Concepts Implemented

- Stored Procedures for ETL logic
- Surrogate Keys for dimensional tables
- Window Functions for deduplication & history
- Data Quality Checks
- Separation of Concerns
- Layer-wise data governance

---

## 🧩 End-to-End ETL Flow Summary

1️⃣ Raw data ingested into **Bronze Layer**  
2️⃣ Data cleaned & standardized in **Silver Layer**  
3️⃣ Analytics-ready models built in **Gold Layer**  
4️⃣ Views exposed for BI & reporting  

---

## 🛠️ Tech Stack & Tools

- **SQL Server**
- **T-SQL**
- **Stored Procedures**
- **Views**
- **Bulk Insert**
- **Dimensional Modeling**
- **Medallion Architecture**

---

## 📂 Repository Structure

```text
SQL-Data-Warehouse
│
├── bronze/
│   └── raw_tables.sql
├── silver/
│   └── cleaned_tables.sql
├── gold/
│   ├── dim_customer.sql
│   ├── dim_product.sql
│   └── fact_sales.sql
├── views/
└── README.md

