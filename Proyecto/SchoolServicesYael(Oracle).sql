-- Tables
-- User
CREATE TABLE "User" (
    idUser NUMBER PRIMARY KEY,
    userName VARCHAR2(50) UNIQUE NOT NULL,
    name VARCHAR2(50) NOT NULL,
    password VARCHAR2(10) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    status NUMBER DEFAULT 1 NOT NULL,
    idUserCreate NUMBER,
    creationDate DATE,
    idUserModify NUMBER,
    modifiedDate DATE
);

-- FamilyData
CREATE TABLE FamilyData (
    idFamilyData NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    lastName VARCHAR2(50) NOT NULL,
    relationship VARCHAR2(10) NOT NULL,
    phoneNumber VARCHAR2(15) NOT NULL,
    email VARCHAR2(100) NOT NULL,
    address VARCHAR2(300) NOT NULL,
    idStudent NUMBER NOT NULL,
    status NUMBER DEFAULT 1 NOT NULL,
    idUserCreate NUMBER NOT NULL,
    creationDate DATE NOT NULL,
    idUserModify NUMBER,
    modifiedDate DATE
);

-- Enrollment
CREATE TABLE Enrollment (
    idEnrollment NUMBER PRIMARY KEY,
    numericalReference NUMBER NOT NULL,
    totalPayment NUMBER(10, 2) NOT NULL,
    matriculation VARCHAR2(50) NOT NULL,
    dueDate DATE NOT NULL,
    semester NUMBER NOT NULL,
    idStudent NUMBER NOT NULL,
    idPeriod NUMBER NOT NULL,
    status NUMBER DEFAULT 1 NOT NULL,
    idUserCreate NUMBER NOT NULL,
    creationDate DATE NOT NULL,
    idUserModify NUMBER,
    modifiedDate DATE
);

-- LifeInsurance
CREATE TABLE LifeInsurance (
    idLifeInsurance NUMBER PRIMARY KEY,
    policyNumber VARCHAR2(20) NOT NULL,
    insuranceCompany VARCHAR2(50) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    beneficiary VARCHAR2(50) NOT NULL,
    deathCoverage NUMBER(10, 2) NOT NULL,
    disabilityCoverage NUMBER(10, 2) NOT NULL,
    insurancePayment NUMBER(10, 2) NOT NULL,
    paymentPeriod NUMBER NOT NULL,
    status NUMBER DEFAULT 1 NOT NULL,
    idUserCreate NUMBER NOT NULL,
    creationDate DATE NOT NULL,
    idUserModify NUMBER,
    modifiedDate DATE
);

-- Period
CREATE TABLE Period (
    idPeriod NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    duration NUMBER NOT NULL,
    status NUMBER DEFAULT 1 NOT NULL,
    idUserCreate NUMBER NOT NULL,
    creationDate DATE NOT NULL,
    idUserModify NUMBER,
    modifiedDate DATE
);

-- Education
CREATE TABLE Education (
    idEducation NUMBER PRIMARY KEY,
    educationLevel VARCHAR2(50) NOT NULL,
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    idStudent NUMBER NOT NULL,
    status NUMBER DEFAULT 1 NOT NULL,
    idUserCreate NUMBER NOT NULL,
    creationDate DATE NOT NULL,
    idUserModify NUMBER,
    modifiedDate DATE
);

-- Crear índices
CREATE INDEX IX_User ON "User" (idUser);
CREATE INDEX IX_FamilyData ON FamilyData (idFamilyData);
CREATE INDEX IX_Enrollment ON Enrollment (idEnrollment);
CREATE INDEX IX_LifeInsurance ON LifeInsurance (idLifeInsurance);
CREATE INDEX IX_Period ON Period (idPeriod);
CREATE INDEX IX_Education ON Education (idEducation);

-- Crear restricciones de clave externa
-- User
ALTER TABLE "User"
ADD CONSTRAINT FK_UserUserCreate FOREIGN KEY (idUserCreate) REFERENCES "User" (idUser);

ALTER TABLE "User"
ADD CONSTRAINT FK_UserUserModified FOREIGN KEY (idUserModify) REFERENCES "User" (idUser);

-- FamilyData
ALTER TABLE FamilyData
ADD CONSTRAINT FK_FamilyDataUserCreate FOREIGN KEY (idUserCreate) REFERENCES "User" (idUser);

ALTER TABLE FamilyData
ADD CONSTRAINT FK_FamilyDataUserModified FOREIGN KEY (idUserModify) REFERENCES "User" (idUser);

-- Enrollment
ALTER TABLE Enrollment
ADD CONSTRAINT FK_EnrollmentUserCreate FOREIGN KEY (idUserCreate) REFERENCES "User" (idUser);

ALTER TABLE Enrollment
ADD CONSTRAINT FK_EnrollmentUserModified FOREIGN KEY (idUserModify) REFERENCES "User" (idUser);

ALTER TABLE Enrollment
ADD CONSTRAINT FK_EnrollmentPeriod FOREIGN KEY (idPeriod) REFERENCES Period (idPeriod);

-- LifeInsurance
ALTER TABLE LifeInsurance
ADD CONSTRAINT FK_LifeInsuranceUserCreate FOREIGN KEY (idUserCreate) REFERENCES "User" (idUser);

ALTER TABLE LifeInsurance
ADD CONSTRAINT FK_LifeInsuranceUserModified FOREIGN KEY (idUserModify) REFERENCES "User" (idUser);

-- Period
ALTER TABLE Period
ADD CONSTRAINT FK_PeriodUserCreate FOREIGN KEY (idUserCreate) REFERENCES "User" (idUser);

ALTER TABLE Period
ADD CONSTRAINT FK_PeriodUserModified FOREIGN KEY (idUserModify) REFERENCES "User" (idUser);

-- Education
ALTER TABLE Education
ADD CONSTRAINT FK_EducationUserCreate FOREIGN KEY (idUserCreate) REFERENCES "User" (idUser);

ALTER TABLE Education
ADD CONSTRAINT FK_EducationUserModified FOREIGN KEY (idUserModify) REFERENCES "User" (idUser);

-- Insertar datos
INSERT INTO "User" (idUser, UserName, name, password, email, idUserCreate, creationDate)
VALUES (1, 'sa', 'Super Admin', 'AdM1nPaSsW', 'superadmin@example.com', null, null);

INSERT INTO "User" (idUser, UserName, name, password, email, idUserCreate, creationDate)
VALUES (2, 'Yael', 'Yael Reyes', 'Us3rPwd!23', 'yael_r3y@example.com', 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'));

INSERT INTO FamilyData (idFamilyData, name, lastName, relationship, phoneNumber, email, address, idStudent, idUserCreate, creationDate)
VALUES (1, 'Maria', 'Ortiz', 'Madre', '123-456-7890', 'maria@example.com', '123 Main St', 2, 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'));

INSERT INTO FamilyData (idFamilyData, name, lastName, relationship, phoneNumber, email, address, idStudent, idUserCreate, creationDate)
VALUES (2, 'Juana', 'Martinez', 'Madre', '987-654-3210', 'juana@example.com', '456 Elm St', 3, 2, TO_DATE('2023-10-23', 'YYYY-MM-DD'));

INSERT INTO FamilyData (idFamilyData, name, lastName, relationship, phoneNumber, email, address, idStudent, idUserCreate, creationDate)
VALUES (3, 'Enrique', 'Ramos', 'Padre', '555-123-4567', 'enrique@example.com', '789 Oak St', 1, 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'));

INSERT INTO LifeInsurance (idLifeInsurance, policyNumber, insuranceCompany, startDate, endDate, beneficiary, deathCoverage, disabilityCoverage, insurancePayment, paymentPeriod, idUserCreate, creationDate)
VALUES (1, 'LI-003', '123 Insure', TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_DATE('2028-03-09', 'YYYY-MM-DD'), 'Enrique Ramos', 750000.00, 300000.00, 200.00, 12, 2, TO_DATE('2023-10-23', 'YYYY-MM-DD'));
       
INSERT INTO LifeInsurance (idLifeInsurance, policyNumber, insuranceCompany, startDate, endDate, beneficiary, deathCoverage, disabilityCoverage, insurancePayment, paymentPeriod, idUserCreate, creationDate)
VALUES (2, 'LI-002', 'ABC Insurance', TO_DATE('2023-02-20', 'YYYY-MM-DD'), TO_DATE('2027-02-19', 'YYYY-MM-DD'), 'Juana Martinez', 300000.00, 150000.00, 100.00, 6, 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'));
       
INSERT INTO LifeInsurance (idLifeInsurance, policyNumber, insuranceCompany, startDate, endDate, beneficiary, deathCoverage, disabilityCoverage, insurancePayment, paymentPeriod, idUserCreate, creationDate)
VALUES (3, 'LI-005', 'ABC Insurance', TO_DATE('2023-02-21', 'YYYY-MM-DD'), TO_DATE('2027-02-19', 'YYYY-MM-DD'), 'Maria Ortiz', 300000.00, 150000.00, 100.00, 6, 2, TO_DATE('2023-10-23', 'YYYY-MM-DD'));

INSERT INTO Period (idPeriod, name, startDate, endDate, duration, idUserCreate, creationDate)
VALUES (1, 'Fall 2023', TO_DATE('2023-09-01', 'YYYY-MM-DD'), TO_DATE('2023-12-15', 'YYYY-MM-DD'), 106, 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'));

INSERT INTO Period (idPeriod, name, startDate, endDate, duration, idUserCreate, creationDate)
VALUES (2, 'Spring 2024', TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-05-30', 'YYYY-MM-DD'), 137, 2, TO_DATE('2023-10-23', 'YYYY-MM-DD'));

INSERT INTO Period (idPeriod, name, startDate, endDate, duration, idUserCreate, creationDate)
VALUES (3, 'Summer 2024', TO_DATE('2024-06-15', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), 78, 2, TO_DATE('2023-10-23', 'YYYY-MM-DD'));

INSERT INTO Education (idEducation, educationLevel, startDate, endDate, idStudent, idUserCreate, creationDate)
VALUES (1, 'High School', TO_DATE('2018-09-01', 'YYYY-MM-DD'), TO_DATE('2021-06-30', 'YYYY-MM-DD'), 3, 2, TO_DATE('2023-10-23', 'YYYY-MM-DD'));
       
INSERT INTO Education (idEducation, educationLevel, startDate, endDate, idStudent, idUserCreate, creationDate)
VALUES (2, 'Bachelor Degree', TO_DATE('2021-09-01', 'YYYY-MM-DD'), TO_DATE('2025-06-30', 'YYYY-MM-DD'), 4, 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'));
       
INSERT INTO Education (idEducation, educationLevel, startDate, endDate, idStudent, idUserCreate, creationDate)
VALUES (3, 'High School', TO_DATE('2020-09-01', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), 2, 1, TO_DATE('2023-10-23', 'YYYY-MM-DD'));
