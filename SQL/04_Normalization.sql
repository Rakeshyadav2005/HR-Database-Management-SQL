-- CREATE LOOKUP TABLES

-- 1.Departments
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) UNIQUE NOT NULL
);
INSERT INTO Departments (DepartmentName)
SELECT DISTINCT Department
FROM HR_Employee_Clean;

-- 2.JobRoles
CREATE TABLE JobRoles (
    JobRoleID INT AUTO_INCREMENT PRIMARY KEY,
    JobRoleName VARCHAR(100) NOT NULL,
    DepartmentID INT,
    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
INSERT INTO JobRoles (JobRoleName)
SELECT DISTINCT JobRole
FROM HR_Employee_Clean;

-- 3.Employees Table
CREATE TABLE Employees (
    EmployeeNumber INT PRIMARY KEY,
    Age INT NOT NULL,
    Gender VARCHAR(10),
    MaritalStatus VARCHAR(20),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    DepartmentID INT,
    JobRoleID INT,

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID),

    FOREIGN KEY (JobRoleID)
        REFERENCES JobRoles(JobRoleID)
);

-- 4.Payroll Table
CREATE TABLE Payroll (
    PayrollID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeNumber INT,
    DailyRate INT,
    HourlyRate INT,
    MonthlyIncome INT,
    MonthlyRate INT,
    PercentSalaryHike INT,
    StockOptionLevel INT,

    FOREIGN KEY(EmployeeNumber)
        REFERENCES Employees(EmployeeNumber)
);

-- 5.Performance Table
CREATE TABLE Performance (
    PerformanceID INT AUTO_INCREMENT PRIMARY KEY,

    EmployeeNumber INT,

    EnvironmentSatisfaction INT,
    JobInvolvement INT,
    JobSatisfaction INT,
    RelationshipSatisfaction INT,
    PerformanceRating INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,

    FOREIGN KEY(EmployeeNumber)
        REFERENCES Employees(EmployeeNumber)
);

-- 6.Experience Table

CREATE TABLE Experience (
    ExperienceID INT AUTO_INCREMENT PRIMARY KEY,

    EmployeeNumber INT,

    NumCompaniesWorked INT,
    TotalWorkingYears INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT,

    BusinessTravel VARCHAR(30),
    OverTime VARCHAR(5),
    Attrition VARCHAR(5),

    FOREIGN KEY(EmployeeNumber)
        REFERENCES Employees(EmployeeNumber)
);

-- Populating the above tables one by one

-- Employees
INSERT INTO Employees
(
EmployeeNumber,
Age,
Gender,
MaritalStatus,
DistanceFromHome,
Education,
EducationField,
DepartmentID,
JobRoleID
)

SELECT

h.EmployeeNumber,
h.Age,
h.Gender,
h.MaritalStatus,
h.DistanceFromHome,
h.Education,
h.EducationField,

d.DepartmentID,

j.JobRoleID

FROM HR_Employee_Clean h

JOIN Departments d
ON h.Department=d.DepartmentName

JOIN JobRoles j
ON h.JobRole=j.JobRoleName;

-- Pay roll
INSERT INTO Payroll
(
EmployeeNumber,
DailyRate,
HourlyRate,
MonthlyIncome,
MonthlyRate,
PercentSalaryHike,
StockOptionLevel
)

SELECT

EmployeeNumber,
DailyRate,
HourlyRate,
MonthlyIncome,
MonthlyRate,
PercentSalaryHike,
StockOptionLevel

FROM HR_Employee_Clean;

-- Performance
INSERT INTO Performance
(
EmployeeNumber,
EnvironmentSatisfaction,
JobInvolvement,
JobSatisfaction,
RelationshipSatisfaction,
PerformanceRating,
TrainingTimesLastYear,
WorkLifeBalance
)

SELECT

EmployeeNumber,
EnvironmentSatisfaction,
JobInvolvement,
JobSatisfaction,
RelationshipSatisfaction,
PerformanceRating,
TrainingTimesLastYear,
WorkLifeBalance

FROM HR_Employee_Clean;

-- Experience
INSERT INTO Experience
(
EmployeeNumber,
NumCompaniesWorked,
TotalWorkingYears,
YearsAtCompany,
YearsInCurrentRole,
YearsSinceLastPromotion,
YearsWithCurrManager,
BusinessTravel,
OverTime,
Attrition
)

SELECT

EmployeeNumber,
NumCompaniesWorked,
TotalWorkingYears,
YearsAtCompany,
YearsInCurrentRole,
YearsSinceLastPromotion,
YearsWithCurrManager,
BusinessTravel,
OverTime,
Attrition

FROM HR_Employee_Clean;

-- Verify Data
SELECT COUNT(*) FROM Employees;
SELECT COUNT(*) FROM Payroll;
SELECT COUNT(*) FROM Performance;
SELECT COUNT(*) FROM Experience;
SELECT COUNT(*) FROM Departments;
SELECT COUNT(*) FROM JobRoles;

-- Relationship Test
SELECT
e.EmployeeNumber,
d.DepartmentName,
j.JobRoleName,
p.MonthlyIncome
FROM Employees e
JOIN Departments d
ON e.DepartmentID=d.DepartmentID
JOIN JobRoles j
ON e.JobRoleID=j.JobRoleID
JOIN Payroll p
ON e.EmployeeNumber=p.EmployeeNumber
LIMIT 5;