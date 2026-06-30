USE HRManagementDB;

-- =====================================================
-- VIEWS - HR DATABASE MANAGEMENT SYSTEM
-- =====================================================

-- View 1: Employee Summary
CREATE VIEW EmployeeSummary AS
SELECT
    e.EmployeeNumber,
    e.Age,
    e.Gender,
    e.MaritalStatus,
    d.DepartmentName,
    j.JobRoleName
FROM Employees e
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID;

-- View 2: Payroll Summary
CREATE VIEW PayrollSummary AS
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    p.MonthlyIncome,
    p.DailyRate,
    p.HourlyRate,
    p.PercentSalaryHike
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID;

-- View 3: Department Salary Summary
CREATE VIEW DepartmentSalarySummary AS
SELECT
    d.DepartmentName,
    COUNT(*) AS TotalEmployees,
    ROUND(AVG(p.MonthlyIncome),2) AS AverageSalary,
    MAX(p.MonthlyIncome) AS HighestSalary,
    MIN(p.MonthlyIncome) AS LowestSalary,
    SUM(p.MonthlyIncome) AS TotalSalaryExpense
FROM Employees e
JOIN Payroll p
    ON e.EmployeeNumber = p.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

-- View 4: Performance Summary
CREATE VIEW PerformanceSummary AS
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    pf.PerformanceRating,
    pf.JobSatisfaction,
    pf.EnvironmentSatisfaction,
    pf.WorkLifeBalance
FROM Employees e
JOIN Performance pf
    ON e.EmployeeNumber = pf.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID;

-- View 5: Attrition Report
CREATE VIEW AttritionReport AS
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    j.JobRoleName,
    ex.TotalWorkingYears,
    ex.YearsAtCompany,
    ex.OverTime,
    ex.Attrition
FROM Employees e
JOIN Experience ex
    ON e.EmployeeNumber = ex.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID
JOIN JobRoles j
    ON e.JobRoleID = j.JobRoleID
WHERE ex.Attrition = 'Yes';

-- View 6: Employee Experience Summary
CREATE VIEW EmployeeExperienceSummary AS
SELECT
    e.EmployeeNumber,
    d.DepartmentName,
    ex.TotalWorkingYears,
    ex.YearsAtCompany,
    ex.YearsInCurrentRole,
    ex.YearsSinceLastPromotion,
    ex.YearsWithCurrManager
FROM Employees e
JOIN Experience ex
    ON e.EmployeeNumber = ex.EmployeeNumber
JOIN Departments d
    ON e.DepartmentID = d.DepartmentID;

-- =====================================================
-- TEST THE VIEWS
-- =====================================================

SELECT * FROM EmployeeSummary;
SELECT * FROM PayrollSummary;
SELECT * FROM DepartmentSalarySummary;
SELECT * FROM PerformanceSummary;
SELECT * FROM AttritionReport;
SELECT * FROM EmployeeExperienceSummary;