USE master
GO
IF DB_ID (N'AssistControl') IS NOT NULL
DROP DATABASE AssistControl;
GO
CREATE DATABASE AssistControl
GO
USE AssistControl
GO
-------------------TABLAS---------------------
CREATE TABLE Alumno
(
	idAlumno INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(20) NOT NULL,
	apellidoPaterno VARCHAR(50) NOT NULL,
	apellidoMAterno VARCHAR(50) NOT NULL,
	matricula VARCHAR(20) NOT NULL,
	estatus BIT DEFAULT 1,
	CONSTRAINT PK_Alumno PRIMARY KEY (idAlumno)
);
GO
CREATE TABLE Maestro
(
	idMaestro INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(20) NOT NULL,
	apellidoPaterno VARCHAR(50) NOT NULL,
	apellidoMAterno VARCHAR(50) NOT NULL,
	estatus BIT DEFAULT 1,
	CONSTRAINT PK_Maestro PRIMARY KEY (idMaestro)
);
GO
CREATE TABLE Materia
(
	idMateria INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	idMaestro INT NOT NULL,
	estatus BIT DEFAULT 1,
	CONSTRAINT PK_Materia PRIMARY KEY (idMateria)
);
GO
-------------------INICE---------------------
CREATE INDEX IX_Alumno ON Alumno(idAlumno);
CREATE INDEX IX_Maestro ON Maestro(idMaestro);
CREATE INDEX IX_Materia ON Materia(idMateria);
GO
------------------INSERTAR-------------------
INSERT INTO Alumno(nombre, apellidoPaterno, apellidoMAterno, matricula)
VALUES  ('Pablo Acalli', 'Reyes', 'Martinez', 'G23812796'),
		('Evelin Searjasub', 'Barrera', 'Torres', 'I20050096'),
		('Marisol', 'Ramos', 'Reyes', 'I20050051'),
		('Yael Jesus', 'Reyes', 'Martinez', 'I18050485')
INSERT INTO Maestro(nombre, apellidoPaterno, apellidoMAterno)
VALUES  ('Ruben', 'Riojas', 'Algo'),
		('Hector', 'Aguilera', 'Torres'),
		('Alan', 'Botello', 'Suarez')
INSERT INTO Materia(nombre, idMaestro)
VALUES	('Gestion laboral', 3),
		('Programacion', 1),
		('Redes', 2),
		('Bases de Datos', 1)