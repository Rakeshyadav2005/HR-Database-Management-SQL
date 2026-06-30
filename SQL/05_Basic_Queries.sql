USE HRManagementDB;

-- =====================================================
-- BASIC SQL QUERIES - HR DATABASE MANAGEMENT SYSTEM
-- =====================================================

-- Query 1: Display all employees
SELECT *
FROM Employees;

-- Query 2: Display employee details with department and job role
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName
FROM Employees e
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID;

-- Query 3: Display employees older than 40 years
SELECT *
FROM Employees
WHERE Age > 40;

-- Query 4: Display all female employees
SELECT *
FROM Employees
WHERE Gender = 'Female';

-- Query 5: Display all married employees
SELECT *
FROM Employees
WHERE MaritalStatus = 'Married';

-- Query 6: Display employees living more than 15 km from office
SELECT *
FROM Employees
WHERE DistanceFromHome > 15;

-- Query 7: Find the highest monthly salary
SELECT
    MAX(MonthlyIncome) AS HighestSalary
FROM Payroll;

-- Query 8: Find the lowest monthly salary
SELECT
    MIN(MonthlyIncome) AS LowestSalary
FROM Payroll;

-- Query 9: Find the average monthly salary
SELECT
    ROUND(AVG(MonthlyIncome), 2) AS AverageSalary
FROM Payroll;

-- Query 10: Display employees earning more than ₹15,000 per month
SELECT *
FROM Payroll
WHERE MonthlyIncome > 15000;

-- Query 11: Count the total number of employees
SELECT
    COUNT(*) AS TotalEmployees
FROM Employees;

-- Query 12: Find the average employee age
SELECT
    ROUND(AVG(Age), 2) AS AverageAge
FROM Employees;

-- Query 13: Find the youngest employee age
SELECT
    MIN(Age) AS YoungestEmployee
FROM Employees;

-- Query 14: Find the oldest employee age
SELECT
    MAX(Age) AS OldestEmployee
FROM Employees;

-- Query 15: Count employees in each department
SELECT
    d.DepartmentName,
    COUNT(*) AS EmployeeCount
FROM Employees e
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- Query 16: Display employees working in the Sales department
SELECT
    e.EmployeeNumber,
    j.JobRoleName
FROM Employees e
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
WHERE d.DepartmentName = 'Sales';

-- Query 17: Display employees with a performance rating of 4
SELECT
    EmployeeNumber,
    PerformanceRating
FROM Performance
WHERE PerformanceRating = 4;

-- Query 18: Display employees working overtime
SELECT
    EmployeeNumber
FROM Experience
WHERE OverTime = 'Yes';

-- Query 19: Display employees who left the company (Attrition)
SELECT
    EmployeeNumber
FROM Experience
WHERE Attrition = 'Yes';

-- Query 20: Find the average Work-Life Balance score
SELECT
    ROUND(AVG(WorkLifeBalance), 2) AS AverageWorkLifeBalance
FROM Performance;