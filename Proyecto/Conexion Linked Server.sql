EXEC sp_addlinkedserver
@server = '192.168.1.181',
@srvproduct = 'SQL SERVER';
GO

exec sp_addlinkedsrvlogin
@rmtsrvname = N'192.168.1.181',
@useself = 'false',
@rmtuser = N'sa',
@rmtpassword = N'0528';
GO

select * from [192.168.1.181].SchoolServicesMarisol.dbo.Student where status = 1
select * from [192.168.1.181].SchoolServicesMarisol.dbo.Career where status = 1

select COUNT(C.idCareer) As Carrera,
s.registrationNumber As Matricula,
(s.name+ ' ' + s.lastName) As [Nombre Estudiante],
l.insuranceCompany As [Compañia de Seguros],
l.beneficiary As Beneficiario
from [192.168.1.181].SchoolServicesMarisol.dbo.Student s
inner join [192.168.1.181].SchoolServicesMarisol.dbo.StudyPlan sp ON s.idStudyPlan = sp.idStudyPlan
inner join [192.168.1.181].SchoolServicesMarisol.dbo.Career c ON sp.idCareer = c.idCareer
inner join LifeInsurance l ON s.idLifeInsurance = l.idLifeInsurance
where s.status = 1
GROUP BY s.registrationNumber, s.name, s.lastName, l.insuranceCompany, l.beneficiary
GO

insert into [192.168.1.181].SchoolServicesMarisol.dbo.Student (idStudyPlan, registrationNumber, name, lastName, phoneNumber, email, address, curp, rfc, nss, idLifeInsurance, idUserCreate, creationDate)
Values (2, 'M20050058', 'Evelin Serajasub', 'Barrera Torres', '8661437076', 'searthehedgehog@gmail.com', 'Flores Borja', 'BATE020109MCLVBPC3', 'BATE020109MCL', '45387453886', 1, 2, '2023-12-12')

INSERT INTO LifeInsurance (policyNumber, insuranceCompany, startDate, endDate, beneficiary, deathCoverage, disabilityCoverage, insurancePayment, paymentPeriod, idUserCreate, creationDate)
VALUES ('LI-006', '123 Insure', '2023-08-10', '2028-12-10', 'Esmeralda Torres', 750000.00, 300000.00, 200.00, 12, 2, '2023-12-12');

UPDATE [192.168.1.181].SchoolServicesMarisol.dbo.Student
SET address = 'calle Emiliano Zapata #452, Flores Borja, Monclova Coahuila', idLifeInsurance = 4, idUserModify = 2, modifiedDate = '2023-12-12'
where idStudent = 4;
select * from [192.168.1.181].SchoolServicesMarisol.dbo.Student  where status = 1;


UPDATE [192.168.1.181].SchoolServicesMarisol.dbo.Student
SET status = 0
where idStudent = 4;
select * from [192.168.1.181].SchoolServicesMarisol.dbo.Student  where status = 1;
