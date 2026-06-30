USE HRManagementDB;

-- =====================================================
-- JOINS - HR DATABASE MANAGEMENT SYSTEM
-- =====================================================

-- Query 1: Display employee details with department and job role
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName
FROM Employees e
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID;

-- Query 2: Display employee salary details
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    p.MonthlyIncome
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
ORDER BY p.MonthlyIncome DESC;

-- Query 3: Display employee performance details
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    pf.PerformanceRating,
    pf.JobSatisfaction
FROM Employees e
JOIN Performance pf
    ON e.EmployeeNumber = pf.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID;

-- Query 4: Display employee experience details
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    ex.TotalWorkingYears,
    ex.YearsAtCompany,
    ex.YearsInCurrentRole
FROM Employees e
JOIN Experience ex
    ON e.EmployeeNumber = ex.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

-- Query 5: Find the top 10 highest-paid employees
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    p.MonthlyIncome
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
ORDER BY p.MonthlyIncome DESC
LIMIT 10;

-- Query 6: Find employees with Performance Rating = 4
SELECT
    e.EmployeeNumber,
    j.JobRoleName,
    pf.PerformanceRating
FROM Employees e
JOIN Performance pf
    ON e.EmployeeNumber = pf.EmployeeNumber
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
WHERE pf.PerformanceRating = 4;

-- Query 7: Find employees who work overtime
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    ex.OverTime
FROM Employees e
JOIN Experience ex
    ON e.EmployeeNumber = ex.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
WHERE ex.OverTime = 'Yes';

-- Query 8: Find employees who left the company
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    ex.Attrition
FROM Employees e
JOIN Experience ex
    ON e.EmployeeNumber = ex.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
WHERE ex.Attrition = 'Yes';

-- Query 9: Department-wise average salary
SELECT
    d.DepartmentName,
    ROUND(AVG(p.MonthlyIncome),2) AS AverageSalary
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY AverageSalary DESC;

-- Query 10: Department-wise total salary expense
SELECT
    d.DepartmentName,
    SUM(p.MonthlyIncome) AS SalaryExpense
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY SalaryExpense DESC;

-- Query 11: Job role-wise average salary
SELECT
    j.JobRoleName,
    ROUND(AVG(p.MonthlyIncome),2) AS AverageSalary
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
GROUP BY j.JobRoleName
ORDER BY AverageSalary DESC;

-- Query 12: Department-wise attrition count
SELECT
    d.DepartmentName,
    COUNT(*) AS EmployeesLeft
FROM Employees e
JOIN Experience ex
    ON e.EmployeeNumber = ex.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE ex.Attrition = 'Yes'
GROUP BY d.DepartmentName
ORDER BY EmployeesLeft DESC;

-- Query 13: Job role-wise attrition count
SELECT
    j.JobRoleName,
    COUNT(*) AS EmployeesLeft
FROM Employees e
JOIN Experience ex
    ON e.EmployeeNumber = ex.EmployeeNumber
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
WHERE ex.Attrition = 'Yes'
GROUP BY j.JobRoleName
ORDER BY EmployeesLeft DESC;

-- Query 14: Average performance rating by department
SELECT
    d.DepartmentName,
    ROUND(AVG(pf.PerformanceRating),2) AS AverageRating
FROM Employees e
JOIN Performance pf
    ON e.EmployeeNumber = pf.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- Query 15: Employees with more than 10 years at the company
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    ex.YearsAtCompany
FROM Employees e
JOIN Experience ex
    ON e.EmployeeNumber = ex.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
WHERE ex.YearsAtCompany > 10
ORDER BY ex.YearsAtCompany DESC;