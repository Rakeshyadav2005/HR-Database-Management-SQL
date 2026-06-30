# Dataset Flow

This project uses the IBM HR Analytics dataset from Kaggle.

## ETL Pipeline

Raw Dataset
↓
HR_Employee_Raw (Staging Table)
↓
HR_Employee_Clean (Data Cleaning)
↓
Normalized Database Tables
↓
CSV Export

## Folder Structure

- Raw_Data → Original Kaggle dataset
- Cleaned_Data → Cleaned staging dataset
- Normalized_Data → Normalized relational tables