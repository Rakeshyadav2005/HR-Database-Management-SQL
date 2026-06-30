USE HRManagementDB;

-- =====================================================
-- TRIGGERS - HR DATABASE MANAGEMENT SYSTEM
-- =====================================================

-- =====================================================
-- Cleanup (Allows the script to be executed multiple times)
-- =====================================================

DROP TRIGGER IF EXISTS trg_AuditSalaryUpdate;
DROP TRIGGER IF EXISTS trg_LogEmployeeInsert;
DROP TRIGGER IF EXISTS trg_ValidateSalaryUpdate;
DROP TRIGGER IF EXISTS trg_LogEmployeeDelete;

DROP TABLE IF EXISTS SalaryAudit;
DROP TABLE IF EXISTS EmployeeAudit;

-- =====================================================
-- Create Salary Audit Table
-- =====================================================

CREATE TABLE SalaryAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeNumber INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    UpdatedOn DATETIME
);

-- =====================================================
-- Trigger 1: Audit Salary Updates
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_AuditSalaryUpdate
AFTER UPDATE ON Payroll
FOR EACH ROW
BEGIN
    IF OLD.MonthlyIncome <> NEW.MonthlyIncome THEN
        INSERT INTO SalaryAudit
        (
            EmployeeNumber,
            OldSalary,
            NewSalary,
            UpdatedOn
        )
        VALUES
        (
            NEW.EmployeeNumber,
            OLD.MonthlyIncome,
            NEW.MonthlyIncome,
            NOW()
        );
    END IF;
END$$

DELIMITER ;

-- Test Trigger
UPDATE Payroll
SET MonthlyIncome = MonthlyIncome + 1000
WHERE EmployeeNumber = 1;

SELECT * FROM SalaryAudit;

-- =====================================================
-- Create Employee Audit Table
-- =====================================================

CREATE TABLE EmployeeAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeNumber INT,
    ActionPerformed VARCHAR(20),
    ActionDate DATETIME
);

-- =====================================================
-- Trigger 2: Log New Employee Insert
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_LogEmployeeInsert
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAudit
    (
        EmployeeNumber,
        ActionPerformed,
        ActionDate
    )
    VALUES
    (
        NEW.EmployeeNumber,
        'INSERT',
        NOW()
    );
END$$

DELIMITER ;

-- =====================================================
-- Trigger 3: Prevent Negative Salary Updates
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_ValidateSalaryUpdate
BEFORE UPDATE ON Payroll
FOR EACH ROW
BEGIN
    IF NEW.MonthlyIncome < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be negative.';
    END IF;
END$$

DELIMITER ;

-- Test Trigger (Should Throw an Error)
UPDATE Payroll
SET MonthlyIncome = -5000
WHERE EmployeeNumber = 2;

-- =====================================================
-- Trigger 4: Log Employee Deletion
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_LogEmployeeDelete
AFTER DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO EmployeeAudit
    (
        EmployeeNumber,
        ActionPerformed,
        ActionDate
    )
    VALUES
    (
        OLD.EmployeeNumber,
        'DELETE',
        NOW()
    );
END$$

DELIMITER ;

-- =====================================================
-- View Audit Logs
-- =====================================================

SELECT * FROM SalaryAudit;

SELECT * FROM EmployeeAudit;