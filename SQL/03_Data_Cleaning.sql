-- Verify Row Count
SELECT COUNT(*) AS TotalRows
FROM HR_Employee_Clean;

DESC HR_Employee_Clean;

-- Verify Duplicate Employees
SELECT EmployeeNumber, COUNT(*) AS DPNUM
FROM HR_Employee_Clean
GROUP BY EmployeeNumber
Having DPNUM>1;
 
 -- Changed column name
 DESC hr_employee_clean;
 
ALTER TABLE hr_employee_clean 
RENAME COLUMN `ï»¿Age` TO Age;

-- Check NULL Values
SELECT
SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS Age_NULLs,
SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS Department_NULLs,
SUM(CASE WHEN JobRole IS NULL THEN 1 ELSE 0 END) AS JobRole_NULLs,
SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS Income_NULLs,
SUM(CASE WHEN Attrition IS NULL THEN 1 ELSE 0 END) AS Attrition_NULLs
FROM HR_Employee_Clean;

-- Check Constant Columns
SELECT DISTINCT EmployeeCount FROM hr_employee_clean;
SELECT DISTINCT Over18
FROM HR_Employee_Clean;
SELECT DISTINCT StandardHours
FROM HR_Employee_Clean;

-- Remove Constant Columns
ALTER TABLE hr_employee_clean
DROP COLUMN EmployeeCount,
DROP COLUMN Over18,
DROP COLUMN StandardHours;

-- Verify Primary Key
SELECT count(*) as Total_employees, count(Distinct EmployeeNumber) AS UniqueEmployees
FROM hr_employee_clean;

-- check categories
SELECT DISTINCT Department from hr_employee_clean;
SELECT DISTINCT JobRole from hr_employee_clean;
SELECT DISTINCT BusinessTravel from hr_employee_clean;
SELECT DISTINCT Gender from hr_employee_clean;
SELECT DISTINCT MaritalStatus from hr_employee_clean;
SELECT DISTINCT EducationField from hr_employee_clean;
SELECT DISTINCT Attrition from hr_employee_clean;

-- Validate Numeric Ranges
SELECT
MIN(Age) AS MinimumAge,
MAX(Age) AS MaximumAge
FROM HR_Employee_Clean;

SELECT
MIN(MonthlyIncome),
MAX(MonthlyIncome)
FROM HR_Employee_Clean;

SELECT
MIN(YearsAtCompany),
MAX(YearsAtCompany)
FROM HR_Employee_Clean;

SELECT
MIN(TotalWorkingYears),
MAX(TotalWorkingYears)
FROM HR_Employee_Clean;

-- Check for Invalid Values
SELECT *
FROM HR_Employee_Clean
WHERE Age < 18;

SELECT *
FROM HR_Employee_Clean
WHERE MonthlyIncome <= 0;

-- Final Verification
SELECT *
FROM HR_Employee_Clean
LIMIT 5;