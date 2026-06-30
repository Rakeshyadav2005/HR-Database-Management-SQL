USE HRManagementDB;

-- =====================================================
-- INDEXES - HR DATABASE MANAGEMENT SYSTEM
-- =====================================================

-- =====================================================
-- Index 1: Employee Number
-- Improves employee lookups
-- =====================================================

CREATE INDEX idx_employee_number
ON Employees(EmployeeNumber);

-- =====================================================
-- Index 2: Department ID
-- Improves department-based filtering and joins
-- =====================================================

CREATE INDEX idx_department_id
ON Employees(DepartmentID);

-- =====================================================
-- Index 3: Job Role ID
-- Improves job role-based queries
-- =====================================================

CREATE INDEX idx_job_role_id
ON Employees(JobRoleID);

-- =====================================================
-- Index 4: Monthly Salary
-- Improves salary filtering and sorting
-- =====================================================

CREATE INDEX idx_monthly_income
ON Payroll(MonthlyIncome);

-- =====================================================
-- Index 5: Performance Rating
-- Improves performance analysis
-- =====================================================

CREATE INDEX idx_performance_rating
ON Performance(PerformanceRating);

-- =====================================================
-- Index 6: Attrition
-- Improves employee attrition analysis
-- =====================================================

CREATE INDEX idx_attrition
ON Experience(Attrition);

-- =====================================================
-- Index 7: Overtime
-- Improves overtime analysis
-- =====================================================

CREATE INDEX idx_overtime
ON Experience(OverTime);

-- =====================================================
-- Index 8: Composite Index
-- Improves department + salary queries
-- =====================================================

CREATE INDEX idx_department_salary
ON Employees(DepartmentID, JobRoleID);

-- =====================================================
-- View All Indexes
-- =====================================================

SHOW INDEXES FROM Employees;

SHOW INDEXES FROM Payroll;

SHOW INDEXES FROM Performance;

SHOW INDEXES FROM Experience;