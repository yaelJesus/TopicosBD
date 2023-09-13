USE master
GO
IF DB_ID (N'AssistControl') IS NOT NULL
DROP DATABASE AssistControl;
GO
CREATE DATABASE AssistControl
ON
( NAME = AssistControl_dat,
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AssistControl.mdf',  
    SIZE = 10,  
    MAXSIZE = 50,  
    FILEGROWTH = 5 )
LOG ON  
( NAME = AssistControl_log,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AssistControl.ldf',  
    SIZE = 5MB,  
    MAXSIZE = 25MB,  
    FILEGROWTH = 5MB ) ;
GO
USE AssistControl
GO
-------------------TABLAS---------------------
CREATE TABLE Asistencia
(
	idAsistencia INT IDENTITY(1,1) NOT NULL,
	fecha DATE DEFAULT GETDATE(),
	presente BIT DEFAULT 0 NOT NULL,
	idAlumno INT NOT NULL,
	idMaestro INT NOT NULL,
	estatus BIT DEFAULT 1,
	CONSTRAINT PK_Asistencia PRIMARY KEY (idAsistencia)
);
GO
CREATE TABLE AlumnoMaestro
(
	idAlumnoMaestro INT IDENTITY(1,1) NOT NULL,
    idAlumno INT NOT NULL,
    idMaestro INT NOT NULL,
    estatus BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_AlumnoMaestro PRIMARY KEY (idAlumnoMaestro)
);
GO
CREATE TABLE AlumnoMateria
(
	idAlumnoMateria INT IDENTITY(1,1) NOT NULL,
    idAlumno INT NOT NULL,
    idMateria INT NOT NULL,
    estatus BIT DEFAULT 1 NOT NULL,
    CONSTRAINT PK_AlumnoMateria PRIMARY KEY (idAlumnoMateria)
);
GO
-------------------INICE---------------------
CREATE INDEX IX_Asistencia ON Asistencia(idAsistencia);
CREATE INDEX IX_AlumnoMaestro ON AlumnoMaestro(idAlumnoMaestro);
CREATE INDEX IX_AlumnoMateria ON AlumnoMateria(idAlumnoMateria);
GO
------------------INSERTAR-------------------
INSERT INTO Asistencia(fecha, presente, idAlumno, idMaestro)
VALUES	('2023-08-24', 1, 4, 2),
		('2023-08-25', 0, 3, 1),
		('2023-08-25', 1, 2, 1),
		('2023-08-28', 1, 1, 3),
		('2023-08-28', 0, 3, 3),
		('2023-08-28', 1, 2, 3),
		('2023-08-29', 0, 1, 1),
		('2023-08-29', 1, 2, 1),
		('2023-08-29', 1, 3, 1),
		('2023-08-29', 0, 4, 1)
INSERT INTO AlumnoMaestro(idAlumno, idMaestro)
VALUES	(1, 1),
		(1, 3),
		(2, 1),
		(2, 3),
		(3, 1),
		(3, 3),
		(4, 1),
		(4, 2)
INSERT INTO AlumnoMateria(idAlumno, idMateria)
VALUES	(1, 1),
		(1, 4),
		(2, 1),
		(2, 2),
		(2, 4),
		(3, 1),
		(3, 2),
		(3, 4),
		(4, 3),
		(4, 4)