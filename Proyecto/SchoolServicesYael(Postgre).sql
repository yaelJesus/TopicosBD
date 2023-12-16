CREATE DATABASE SHOOLSERVICES;
------------------------TABLES------------------------------
--User
CREATE TABLE [User] (
    idUser serial PRIMARY KEY,
    userName VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    idUserCreate INT,
    creationDate TIMESTAMP,
    idUserModify INT,
    modifiedDate TIMESTAMP
);

-- FamilyData
CREATE TABLE FamilyData (
    idFamilyData serial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    relationship VARCHAR(10) NOT NULL,
    phoneNumber VARCHAR(15) NOT NULL,
    email VARCHAR(100) NOT NULL,
    address VARCHAR(300) NOT NULL,
    idStudent INT NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    idUserCreate INT NOT NULL,
    creationDate Timestamp NOT NULL,
    idUserModify INT,
    modifiedDate Timestamp
);

-- Enrollment
CREATE TABLE Enrollment (
    idEnrollment serial PRIMARY KEY,
    numericalReference INT NOT NULL,
    totalPayment DECIMAL(10, 2) NOT NULL,
    matriculation VARCHAR(50) NOT NULL,
    dueDate Timestamp NOT NULL,
    semester INT NOT NULL,
    idStudent INT NOT NULL,
    idPeriod INT NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    idUserCreate INT NOT NULL,
    creationDate Timestamp NOT NULL,
    idUserModify INT,
    modifiedDate Timestamp
);

-- LifeInsurance
CREATE TABLE LifeInsurance (
    idLifeInsurance serial PRIMARY KEY,
    policyNumber VARCHAR(20) NOT NULL,
    insuranceCompany VARCHAR(50) NOT NULL,
    startDate Timestamp NOT NULL,
    endDate Timestamp NOT NULL,
    beneficiary VARCHAR(50) NOT NULL,
    deathCoverage DECIMAL(10, 2) NOT NULL,
    disabilityCoverage DECIMAL(10, 2) NOT NULL,
    insurancePayment DECIMAL(10, 2) NOT NULL,
    paymentPeriod INT NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    idUserCreate INT NOT NULL,
    creationDate Timestamp NOT NULL,
    idUserModify INT,
    modifiedDate Timestamp
);

-- Period
CREATE TABLE Period (
    idPeriod serial PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    startDate Timestamp NOT NULL,
    endDate Timestamp NOT NULL,
    duration INT NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    idUserCreate INT NOT NULL,
    creationDate Timestamp NOT NULL,
    idUserModify INT,
    modifiedDate Timestamp
);

-- Education
CREATE TABLE Education (
    idEducation serial PRIMARY KEY,
    educationLevel VARCHAR(50) NOT NULL,
    startDate Timestamp NOT NULL,
    endDate Timestamp NOT NULL,
    idStudent INT NOT NULL,
    status BOOLEAN NOT NULL DEFAULT TRUE,
    idUserCreate INT NOT NULL,
    creationDate Timestamp NOT NULL,
    idUserModify INT,
    modifiedDate Timestamp
);

------------------------INDEX------------------------------
CREATE INDEX IX_FamilyData ON FamilyData (idFamilyData);
CREATE INDEX IX_Enrollment ON Enrollment (idEnrollment);
CREATE INDEX IX_LifeInsurance ON LifeInsurance (idLifeInsurance);
CREATE INDEX IX_Period ON Period (idPeriod);
CREATE INDEX IX_Education ON Education (idEducation);

------------------------ALTER------------------------------
--User
ALTER TABLE [User]
ADD CONSTRAINT FK_UserUserCreate FOREIGN KEY (idUserCreate) REFERENCES [User] (idUser);
ALTER TABLE [USER]
ADD CONSTRAINT FK_UserUserModified FOREIGN KEY (idUserModify) REFERENCES [User] (idUser);
--FamilyData
ALTER TABLE FamilyData
ADD CONSTRAINT FK_FamilyDataUserCreate FOREIGN KEY (idUserCreate) REFERENCES [User] (idUser);
ALTER TABLE FamilyData
ADD CONSTRAINT FK_FamilyDataUserModified FOREIGN KEY (idUserModify) REFERENCES [User] (idUser);
--Enrollment
ALTER TABLE Enrollment
ADD CONSTRAINT FK_EnrollmentUserCreate FOREIGN KEY (idUserCreate) REFERENCES [User] (idUser);
ALTER TABLE Enrollment
ADD CONSTRAINT FK_EnrollmentUserModified FOREIGN KEY (idUserModify) REFERENCES [User] (idUser);
ALTER TABLE Enrollment
ADD CONSTRAINT FK_EnrollmentPeriod FOREIGN KEY (idPeriod) REFERENCES Period (idPeriod);
--ALTER TABLE Enrollment
--ADD CONSTRAINT FK_EnrollmentStudent FOREIGN KEY (idStudent) REFERENCES Student (idStudent);
--LifeInsurance
ALTER TABLE LifeInsurance
ADD CONSTRAINT FK_LifeInsuranceUserCreate FOREIGN KEY (idUserCreate) REFERENCES [User] (idUser);
ALTER TABLE LifeInsurance
ADD CONSTRAINT FK_LifeInsuranceUserModified FOREIGN KEY (idUserModify) REFERENCES [User] (idUser);
--Period
ALTER TABLE Period
ADD CONSTRAINT FK_PeriodUserCreate FOREIGN KEY (idUserCreate) REFERENCES [User] (idUser);
ALTER TABLE Period
ADD CONSTRAINT FK_PeriodUserModified FOREIGN KEY (idUserModify) REFERENCES [User] (idUser);
--Education
ALTER TABLE Education
ADD CONSTRAINT FK_EducationUserCreate FOREIGN KEY (idUserCreate) REFERENCES [User] (idUser);
ALTER TABLE Education
ADD CONSTRAINT FK_EducationUserModified FOREIGN KEY (idUserModify) REFERENCES [User] (idUser);
GO
------------------------INSERT------------------------------
INSERT INTO [User] (UserName, name, password, email, idUserCreate, creationDate)
VALUES ('sa', 'Super Admin', 'AdM1nPaSsW', 'superadmin@example.com', null, null),
       ('Yael', 'Yael Reyes', 'Us3rPwd!23', 'yael_r3y@example.com', 1, '2023-12-08');
INSERT INTO FamilyData (name, lastName, relationship, phoneNumber, email, address, idStudent, idUserCreate, creationDate)
VALUES ('Maria', 'Ortiz', 'Madre', '123-456-7890', 'maria@example.com', '123 Main St', 2, 1, '2023-10-23'),
       ('Juana', 'Martinez', 'Madre', '987-654-3210', 'juana@example.com', '456 Elm St', 3, 2, '2023-10-23'),
       ('Enrique', 'Ramos', 'Padre', '555-123-4567', 'enrique@example.com', '789 Oak St', 1, 1, '2023-10-23');
INSERT INTO LifeInsurance (policyNumber, insuranceCompany, startDate, endDate, beneficiary, deathCoverage, disabilityCoverage, insurancePayment, paymentPeriod, idUserCreate, creationDate)
VALUES ('LI-003', '123 Insure', '2023-03-10', '2028-03-09', 'Enrique Ramos', 750000.00, 300000.00, 200.00, 12, 2, '2023-10-23'),
	   ('LI-002', 'ABC Insurance', '2023-02-20', '2027-02-19', 'Juana Martinez', 300000.00, 150000.00, 100.00, 6, 1, '2023-10-23'),
       ('LI-005', 'ABC Insurance', '2023-02-21', '2027-02-19', 'Maria Ortiz', 300000.00, 150000.00, 100.00, 6, 2, '2023-10-23');
INSERT INTO Period (name, startDate, endDate, duration, idUserCreate, creationDate)
VALUES ('Fall 2023', '2023-09-01', '2023-12-15', 106, 1, '2023-10-23'),
       ('Spring 2024', '2024-01-15', '2024-05-30', 137, 2, '2023-10-23'),
	   ('Summer 2024', '2024-06-15', '2024-08-31', 78, 2, '2023-10-23');
INSERT INTO Education (educationLevel, startDate, endDate, idStudent, idUserCreate, creationDate)
VALUES ('High School', '2018-09-01', '2021-06-30', 3, 2, '2023-10-23'),
       ('Bachelor Degree', '2021-09-01', '2025-06-30', 4, 1, '2023-10-23'),
	   ('High School', '2020-09-01', '2024-06-30', 2, 1, '2023-10-23');

