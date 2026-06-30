# HR Analytics Report

## Project Summary

The **HR Database Management using SQL** project demonstrates the complete lifecycle of building a relational database from a real-world HR dataset. Starting with raw employee data, the project includes data cleaning, normalization, advanced SQL analysis, and business reporting using MySQL.

---

# Project Objectives

- Build a normalized HR database using MySQL.
- Clean and validate raw employee data.
- Apply database normalization (3NF).
- Perform advanced SQL analysis.
- Generate HR business insights.
- Demonstrate the use of Views, Stored Procedures, Triggers, and Indexes.

---

# Dataset Information

| Attribute | Value |
|-----------|-------|
| Dataset | IBM HR Analytics Employee Attrition |
| Source | Kaggle |
| Total Records | 1470 |
| Total Columns | 35 |
| Database | MySQL |

---

# ETL Process

The project follows a structured ETL (Extract, Transform, Load) workflow:

1. Imported the raw HR dataset into a staging table.
2. Cleaned and validated employee records.
3. Removed redundant and unnecessary attributes.
4. Normalized the data into multiple relational tables.
5. Performed advanced SQL analysis and reporting.

---

# Database Design

The normalized database consists of six main tables:

- Employees
- Departments
- JobRoles
- Payroll
- Performance
- Experience

The schema follows **Third Normal Form (3NF)** to reduce redundancy and improve data integrity.

---

# SQL Concepts Implemented

The project demonstrates practical usage of:

- Data Definition Language (DDL)
- Data Manipulation Language (DML)
- Aggregate Functions
- GROUP BY
- HAVING
- INNER JOIN
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Views
- Stored Procedures
- Triggers
- Indexes

---

# Business Insights

The project provides answers to several HR-related business questions, including:

- Employee count by department
- Average salary by department
- Highest-paid employees
- Salary distribution
- Performance rating analysis
- Employee attrition analysis
- Overtime trends
- Work-life balance analysis
- Experience and tenure analysis
- Job role analysis

---

# Database Features

- Normalized relational database design
- Foreign key relationships
- SQL Views for reporting
- Stored Procedures for reusable operations
- Triggers for audit logging and validation
- Indexes for improved query performance

---

# Folder Structure

```
HR-Database-Management-SQL
│
├── Dataset
├── SQL
├── ER_Diagram
├── Reports
├── Screenshots
├── README.md
├── LICENSE
└── .gitignore
```

---

# Learning Outcomes

Through this project, the following skills were demonstrated:

- Database Design
- Data Cleaning
- Database Normalization
- Advanced SQL
- Query Optimization
- HR Data Analysis
- Git & GitHub Version Control
- Technical Documentation

---

# Conclusion

This project demonstrates the end-to-end implementation of an HR database management system using MySQL. It highlights practical SQL skills including database design, normalization, advanced querying, reporting, and optimization techniques that are commonly used in real-world HR and business applications.