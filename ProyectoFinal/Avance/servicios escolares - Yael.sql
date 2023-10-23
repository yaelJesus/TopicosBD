USE master;
GO
IF DB_ID(N'School services')IS NOT NULL
DROP DATABASE SchoolServices;
GO
CREATE DATABASE SchoolServices
ON
(NAME = SchoolServices_dat,
FILENAME= 'C:\BaseDatos\School services.mdf',
SIZE = 10,
MAXSIZE = 50,
FILEGROWTH = 5)
LOG ON 
(NAME =SchoolServices_log,
FILENAME = 'C:\BaseDatos\School services.ldf',
SIZE = 5MB,
MAXSIZE = 25MB,
FILEGROWTH = 5MB);
GO
USE SchoolServices;
GO
-- FamilyData
CREATE TABLE FamilyData (
    FamilyDataID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50) NOT NULL,
    Relationship VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Status BIT DEFAULT 1 NOT NULL
);

-- Enrollment
CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY IDENTITY(1,1),
    StudentID INT NOT NULL,
    PeriodID INT NOT NULL,
    NumericalReference INT NOT NULL,
    TotalPayment DECIMAL(10, 2) NOT NULL,
    Matriculation VARCHAR(50) NOT NULL,
    DueDate DATE NOT NULL,
    Semester INT NOT NULL,
    Status BIT DEFAULT 1 NOT NULL
);

-- LifeInsurance
CREATE TABLE LifeInsurance (
    LifeInsuranceID INT PRIMARY KEY IDENTITY(1,1),
    PolicyNumber VARCHAR(20) NOT NULL,
    InsuranceCompany VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Beneficiary VARCHAR(50) NOT NULL,
    DeathCoverage DECIMAL(10, 2) NOT NULL,
    DisabilityCoverage DECIMAL(10, 2) NOT NULL,
    InsurancePayment DECIMAL(10, 2) NOT NULL,
    PaymentPeriod INT NOT NULL,
    Status BIT DEFAULT 1 NOT NULL
);

-- Period
CREATE TABLE Period (
    PeriodID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Duration INT NOT NULL,
    Status BIT DEFAULT 1 NOT NULL
);

-- Education
CREATE TABLE Education (
    EducationID INT PRIMARY KEY IDENTITY(1,1),
    EducationLevel VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Status BIT DEFAULT 1 NOT NULL
);

CREATE INDEX IX_FamilyData ON FamilyData (FamilyDataID);
CREATE INDEX IX_Enrollment ON Enrollment (EnrollmentID);
CREATE INDEX IX_LifeInsurance ON LifeInsurance (LifeInsuranceID);
CREATE INDEX IX_Period ON Period (PeriodID);
CREATE INDEX IX_Education ON Education (EducationID);

ALTER TABLE Enrollment
ADD CONSTRAINT FK_EnrollmentStudent FOREIGN KEY (StudentID) REFERENCES Student (StudentID);

ALTER TABLE Enrollment
ADD CONSTRAINT FK_EnrollmentPeriod FOREIGN KEY (PeriodID) REFERENCES Period (PeriodID);

INSERT INTO FamilyData (FirstName, LastName, MiddleName, Relationship, PhoneNumber, Email, Address)
VALUES ('Mauricio', 'Reyes', 'Sr.', 'Padre', '123-456-7890', 'mauricion@example.com', '123 Main St');

INSERT INTO FamilyData (FirstName, LastName, MiddleName, Relationship, PhoneNumber, Email, Address)
VALUES ('Juana', 'Martinez', 'Jr.', 'Madre', '987-654-3210', 'juana@example.com', '456 Elm St');

INSERT INTO FamilyData (FirstName, LastName, MiddleName, Relationship, PhoneNumber, Email, Address)
VALUES ('David', 'Sanchez', 'Sr.', 'Padre', '555-123-4567', 'pablo@example.com', '789 Oak St');

INSERT INTO LifeInsurance (PolicyNumber, InsuranceCompany, StartDate, EndDate, Beneficiary, DeathCoverage, DisabilityCoverage, InsurancePayment, PaymentPeriod)
VALUES ('LI-002', 'ABC Insurance', '2023-02-20', '2027-02-19', 'Juana Martinez', 300000.00, 150000.00, 100.00, 6);

INSERT INTO LifeInsurance (PolicyNumber, InsuranceCompany, StartDate, EndDate, Beneficiary, DeathCoverage, DisabilityCoverage, InsurancePayment, PaymentPeriod)
VALUES ('LI-003', '123 Insure', '2023-03-10', '2028-03-09', 'David Sanchez', 750000.00, 300000.00, 200.00, 12);

INSERT INTO Period (Name, StartDate, EndDate, Duration)
VALUES ('Fall 2023', '2023-09-01', '2023-12-15', 106);

INSERT INTO Period (Name, StartDate, EndDate, Duration)
VALUES ('Spring 2024', '2024-01-15', '2024-05-30', 137);

INSERT INTO Period (Name, StartDate, EndDate, Duration)
VALUES ('Summer 2024', '2024-06-15', '2024-08-31', 78);

INSERT INTO Education (EducationLevel, StartDate, EndDate)
VALUES ('High School', '2018-09-01', '2021-06-30');

INSERT INTO Education (EducationLevel, StartDate, EndDate)
VALUES ('Bachelor Degree', '2021-09-01', '2025-06-30');

INSERT INTO Education (EducationLevel, StartDate, EndDate)
VALUES ('Licenciature Degree', '2025-09-01', '2027-06-30');
