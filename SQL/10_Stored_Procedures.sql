USE HRManagementDB;

-- =====================================================
-- STORED PROCEDURES - HR DATABASE MANAGEMENT SYSTEM
-- =====================================================

-- =====================================================
-- Procedure 1: Get Employee Details by Employee Number
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetEmployeeDetails(IN EmpID INT)
BEGIN
    SELECT
        e.EmployeeNumber,
        e.Age,
        e.Gender,
        e.MaritalStatus,
        d.DepartmentName,
        j.JobRoleName,
        p.MonthlyIncome
    FROM Employees e
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    JOIN JobRoles j
        ON e.JobRoleID = j.JobRoleID
    JOIN Payroll p
        ON e.EmployeeNumber = p.EmployeeNumber
    WHERE e.EmployeeNumber = EmpID;
END$$

DELIMITER ;

CALL GetEmployeeDetails(1);

-- =====================================================
-- Procedure 2: Get Employees by Department
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetEmployeesByDepartment(IN DeptName VARCHAR(100))
BEGIN
    SELECT
        e.EmployeeNumber,
        j.JobRoleName,
        p.MonthlyIncome
    FROM Employees e
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    JOIN JobRoles j
        ON e.JobRoleID = j.JobRoleID
    JOIN Payroll p
        ON e.EmployeeNumber = p.EmployeeNumber
    WHERE d.DepartmentName = DeptName
    ORDER BY p.MonthlyIncome DESC;
END$$

DELIMITER ;

CALL GetEmployeesByDepartment('Sales');

-- =====================================================
-- Procedure 3: Department Salary Report
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetDepartmentSalaryReport()
BEGIN
    SELECT
        d.DepartmentName,
        COUNT(*) AS TotalEmployees,
        ROUND(AVG(p.MonthlyIncome),2) AS AverageSalary,
        SUM(p.MonthlyIncome) AS TotalSalaryExpense
    FROM Employees e
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    JOIN Payroll p
        ON e.EmployeeNumber = p.EmployeeNumber
    GROUP BY d.DepartmentName
    ORDER BY TotalSalaryExpense DESC;
END$$

DELIMITER ;

CALL GetDepartmentSalaryReport();

-- =====================================================
-- Procedure 4: Top Paid Employees
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetTopPaidEmployees(IN TopN INT)
BEGIN
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
    LIMIT TopN;
END$$

DELIMITER ;

CALL GetTopPaidEmployees(10);

-- =====================================================
-- Procedure 5: Update Employee Salary
-- =====================================================

DELIMITER $$

CREATE PROCEDURE UpdateEmployeeSalary
(
    IN EmpID INT,
    IN NewSalary INT
)
BEGIN
    UPDATE Payroll
    SET MonthlyIncome = NewSalary
    WHERE EmployeeNumber = EmpID;
END$$

DELIMITER ;

CALL UpdateEmployeeSalary(1,25000);

-- =====================================================
-- Procedure 6: Employees by Performance Rating
-- =====================================================

DELIMITER $$

CREATE PROCEDURE GetEmployeesByPerformanceRating(IN Rating INT)
BEGIN
    SELECT
        e.EmployeeNumber,
        d.DepartmentName,
        j.JobRoleName,
        pf.PerformanceRating
    FROM Employees e
    JOIN Performance pf
        ON e.EmployeeNumber = pf.EmployeeNumber
    JOIN Departments d
        ON e.DepartmentID = d.DepartmentID
    JOIN JobRoles j
        ON e.JobRoleID = j.JobRoleID
    WHERE pf.PerformanceRating = Rating;
END$$

DELIMITER ;

CALL GetEmployeesByPerformanceRating(4);