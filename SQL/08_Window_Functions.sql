USE HRManagementDB;

-- =====================================================
-- WINDOW FUNCTIONS - HR DATABASE MANAGEMENT SYSTEM
-- =====================================================

-- Query 1: Assign a row number based on Monthly Salary
SELECT
    EmployeeNumber,
    MonthlyIncome,
    ROW_NUMBER() OVER(ORDER BY MonthlyIncome DESC) AS RowNum
FROM Payroll;

-- Query 2: Rank employees by Monthly Salary
SELECT
    EmployeeNumber,
    MonthlyIncome,
    RANK() OVER(ORDER BY MonthlyIncome DESC) AS SalaryRank
FROM Payroll;

-- Query 3: Dense Rank employees by Monthly Salary
SELECT
    EmployeeNumber,
    MonthlyIncome,
    DENSE_RANK() OVER(ORDER BY MonthlyIncome DESC) AS DenseSalaryRank
FROM Payroll;

-- Query 4: Rank employees within each department by salary
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    p.MonthlyIncome,
    RANK() OVER(
        PARTITION BY d.DepartmentName
        ORDER BY p.MonthlyIncome DESC
    ) AS DepartmentSalaryRank
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

-- Query 5: Top 3 highest-paid employees in each department
SELECT *
FROM
(
    SELECT
        e.EmployeeNumber,
        d.DepartmentName,
        p.MonthlyIncome,
        ROW_NUMBER() OVER(
            PARTITION BY d.DepartmentName
            ORDER BY p.MonthlyIncome DESC
        ) AS RowNum
    FROM Employees e
    JOIN Payroll p
        ON e.EmployeeNumber = p.EmployeeNumber
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
) RankedEmployees
WHERE RowNum <= 3;

-- Query 6: Previous employee salary using LAG()
SELECT
    EmployeeNumber,
    MonthlyIncome,
    LAG(MonthlyIncome) OVER(ORDER BY MonthlyIncome) AS PreviousSalary
FROM Payroll;

-- Query 7: Next employee salary using LEAD()
SELECT
    EmployeeNumber,
    MonthlyIncome,
    LEAD(MonthlyIncome) OVER(ORDER BY MonthlyIncome) AS NextSalary
FROM Payroll;

-- Query 8: Salary Difference from Previous Employee
SELECT
    EmployeeNumber,
    MonthlyIncome,
    MonthlyIncome -
    LAG(MonthlyIncome) OVER(ORDER BY MonthlyIncome)
    AS SalaryDifference
FROM Payroll;

-- Query 9: Running Total of Monthly Salaries
SELECT
    EmployeeNumber,
    MonthlyIncome,
    SUM(MonthlyIncome)
    OVER(
        ORDER BY EmployeeNumber
    ) AS RunningTotalSalary
FROM Payroll;

-- Query 10: Running Average Salary
SELECT
    EmployeeNumber,
    MonthlyIncome,
    ROUND(
        AVG(MonthlyIncome)
        OVER(
            ORDER BY EmployeeNumber
        ),2
    ) AS RunningAverageSalary
FROM Payroll;

-- Query 11: Divide employees into 4 salary quartiles
SELECT
    EmployeeNumber,
    MonthlyIncome,
    NTILE(4)
    OVER(
        ORDER BY MonthlyIncome DESC
    ) AS SalaryQuartile
FROM Payroll;

-- Query 12: Highest salary in each department
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    p.MonthlyIncome,
    MAX(p.MonthlyIncome)
    OVER(
        PARTITION BY d.DepartmentName
    ) AS HighestDepartmentSalary
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

-- Query 13: Department Average Salary
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    p.MonthlyIncome,
    ROUND(
        AVG(p.MonthlyIncome)
        OVER(
            PARTITION BY d.DepartmentName
        ),2
    ) AS DepartmentAverageSalary
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

-- Query 14: Department-wise Salary Percentage
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    p.MonthlyIncome,
    ROUND(
        100 * p.MonthlyIncome /
        SUM(p.MonthlyIncome)
        OVER(PARTITION BY d.DepartmentName),
        2
    ) AS SalaryContributionPercent
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

-- Query 15: Cumulative Employee Count by Salary
SELECT
    EmployeeNumber,
    MonthlyIncome,
    COUNT(*)
    OVER(
        ORDER BY MonthlyIncome
    ) AS CumulativeEmployeeCount
FROM Payroll;