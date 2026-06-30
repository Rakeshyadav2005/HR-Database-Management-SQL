USE HRManagementDB;

-- =====================================================
-- SUBQUERIES & CTEs - HR DATABASE MANAGEMENT SYSTEM
-- =====================================================

-- Query 1: Employees earning more than the company average salary
SELECT
    EmployeeNumber,
    MonthlyIncome
FROM Payroll
WHERE MonthlyIncome >
(
    SELECT AVG(MonthlyIncome)
    FROM Payroll
);

-- Query 2: Employees younger than the average employee age
SELECT
    EmployeeNumber,
    Age
FROM Employees
WHERE Age <
(
    SELECT AVG(Age)
    FROM Employees
);

-- Query 3: Highest-paid employee(s)
SELECT
    EmployeeNumber,
    MonthlyIncome
FROM Payroll
WHERE MonthlyIncome =
(
    SELECT MAX(MonthlyIncome)
    FROM Payroll
);

-- Query 4: Lowest-paid employee(s)
SELECT
    EmployeeNumber,
    MonthlyIncome
FROM Payroll
WHERE MonthlyIncome =
(
    SELECT MIN(MonthlyIncome)
    FROM Payroll
);

-- Query 5: Employees whose salary is above their department's average salary
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    p.MonthlyIncome
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE p.MonthlyIncome >
(
    SELECT AVG(p2.MonthlyIncome)
    FROM Employees e2
    JOIN Payroll p2
        ON e2.EmployeeNumber = p2.EmployeeNumber
    WHERE e2.DepartmentID = e.DepartmentID
);

-- Query 6: Department with the highest average salary
SELECT
    DepartmentName,
    AverageSalary
FROM
(
    SELECT
        d.DepartmentName,
        AVG(p.MonthlyIncome) AS AverageSalary
    FROM Employees e
    JOIN Payroll p
        ON e.EmployeeNumber = p.EmployeeNumber
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
) AS DepartmentSalary
ORDER BY AverageSalary DESC
LIMIT 1;

-- Query 7: Employees with the maximum YearsAtCompany
SELECT
    EmployeeNumber,
    YearsAtCompany
FROM Experience
WHERE YearsAtCompany =
(
    SELECT MAX(YearsAtCompany)
    FROM Experience
);

-- Query 8: CTE - Department-wise average salary
WITH DepartmentSalary AS
(
    SELECT
        d.DepartmentName,
        ROUND(AVG(p.MonthlyIncome),2) AS AverageSalary
    FROM Employees e
    JOIN Payroll p
        ON e.EmployeeNumber = p.EmployeeNumber
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
)
SELECT *
FROM DepartmentSalary;

-- Query 9: CTE - Employees earning above department average
WITH DepartmentAverage AS
(
    SELECT
        e.DepartmentID,
        AVG(p.MonthlyIncome) AS AvgSalary
    FROM Employees e
    JOIN Payroll p
        ON e.EmployeeNumber = p.EmployeeNumber
    GROUP BY e.DepartmentID
)
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    p.MonthlyIncome
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN DepartmentAverage da
    ON e.DepartmentID = da.DepartmentID
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
WHERE p.MonthlyIncome > da.AvgSalary;

-- Query 10: CTE - Department-wise employee count
WITH DepartmentEmployees AS
(
    SELECT
        d.DepartmentName,
        COUNT(*) AS EmployeeCount
    FROM Employees e
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
)
SELECT *
FROM DepartmentEmployees;

-- Query 11: Employees with above-average Performance Rating
SELECT
    EmployeeNumber,
    PerformanceRating
FROM Performance
WHERE PerformanceRating >
(
    SELECT AVG(PerformanceRating)
    FROM Performance
);

-- Query 12: Departments with more employees than the average department size
SELECT
    DepartmentName,
    EmployeeCount
FROM
(
    SELECT
        d.DepartmentName,
        COUNT(*) AS EmployeeCount
    FROM Employees e
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    GROUP BY d.DepartmentName
) AS DepartmentCounts
WHERE EmployeeCount >
(
    SELECT AVG(EmployeeCount)
    FROM
    (
        SELECT COUNT(*) AS EmployeeCount
        FROM Employees
        GROUP BY DepartmentID
    ) AS AvgDeptSize
);