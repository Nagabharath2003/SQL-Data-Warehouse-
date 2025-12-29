# 🚀 SQL Data Warehouse from Scratch  
### End-to-End Data Engineering Project | Medallion Architecture | Star Schema

<p align="center">
  <img src="images/banner.png" width="100%" />
</p>

---

## 📌 Project Overview

This project demonstrates how a **real-world enterprise SQL Data Warehouse** is designed and implemented **from scratch** using industry-standard **data engineering best practices**.

The project transforms **raw operational data** into **business-ready analytical datasets** using a **layered Medallion Architecture** and **Star Schema modeling**, enabling reliable BI reporting and decision-making.

---

## 🧠 Business Problem

Organizations receive data from multiple systems such as CRM and ERP, but:

❌ Data is raw and inconsistent  
❌ No analytics-ready structure  
❌ Difficult to generate insights  

### ✅ Solution
Build a **centralized SQL Data Warehouse** that:
- Ingests raw data
- Cleans and standardizes it
- Produces analytics-optimized fact & dimension tables

---

## 🏗️ Data Architecture

<p align="center">
  <img src="images/architecture.png" width="85%" />
</p>

### Selected Architecture
- **Data Warehouse**
- **Medallion Architecture**

---

## 🥉 Bronze Layer — Raw Data

<p align="center">
  <img src="images/bronze_layer.png" width="80%" />
</p>

### Purpose
- Store raw, unprocessed data
- Preserve source system integrity

### Key Characteristics
- Direct CSV ingestion
- No transformations
- Source-aligned schemas

### SQL Techniques Used
- DDL & DML
- BULK INSERT
- Stored Procedures

---

## 🥈 Silver Layer — Cleansed & Standardized Data

<p align="center">
  <img src="images/silver_layer.png" width="80%" />
</p>

### Purpose
- Clean, standardize, and enrich data
- Ensure data quality and consistency

### Transformations Applied
✔ Removed duplicates  
✔ Handled NULL values  
✔ Trimmed strings  
✔ Standardized abbreviations  
✔ Normalized attributes  

### SQL Functions & Concepts
- `ROW_NUMBER()`
- `TRIM()`
- `SUBSTRING()`
- `ISNULL()`
- `LEAD()`
- Window Functions
- Data validation logic

### Stored Procedure
```sql
EXEC bronze.load_bronze;
# SQL-Data-Warehouse-
Develop a modern Data warehouse using SQL warehouse
