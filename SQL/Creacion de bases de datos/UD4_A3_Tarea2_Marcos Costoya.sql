/*Tarea 2*/
--1--
create database  ProyectosdeInvestigacion
on
	PRIMARY
	(NAME= ProyectosdeInvestigacion,
	FILENAME="C:\Bases\ ProyectosdeInvestigacion.mdf")

use ProyectosdeInvestigacion

create table Departamento
	(CodigoDpto tinyint identity NOT NULL,
	NombreDpto VARchar(20) NOT NULL,
	Telefono char(9) NOT NULL,
	Director char(9) NOT NULL,
	constraint CK_CODIGODpto_tope check (CodigoDpto<71),
	constraint PK_Codigo_Dpto PRIMARY KEY (CodigoDpto),
	constraint CK_telefono_Dpto check (Telefono LIKE '[5-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint CK_director_Dpto check (Director LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
--2--
create table Sedes
	(CodigoSede smallint identity NOT NULL,
	NombreSede VARchar(20) NOT NULL,
	Campus varchar(15) NOT NULL,
	constraint CK_CodigoSede_tope check (CodigoSede<1001),
	constraint PK_Codigo_Sede PRIMARY KEY (CodigoSede))

sp_help Sedes
--3--
EXEC sp_addtype 'TipoDNI','char(9)','NULL'
go
create table Grupos
	(CodigoGrupo smallint identity NOT NULL,
	NombreGrupo varchar(15) NOT NULL,
	CodigoDpto tinyint NOT NULL,
	AreaConocimiento varchar(15) NOT NULL,
	Lider TipoDNI,
	constraint PK_Codigo_Grupo PRIMARY KEY (CodigoGrupo),
	constraint FK_Codigo_Dpto FOREIGN KEY (CodigoDpto)
		REFERENCES Departamento(CodigoDpto),
	constraint CK_Lider_Grupo check (Lider LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'))
--4--
Alter database ProyectosdeInvestigacion
add filegroup GrupoProfes

Alter database ProyectosdeInvestigacion
add file
(NAME=ProyectosdeInvestigacion_data,
	FILENAME="C:\Bases\Profes_data.ndf")
to FILEGROUP GrupoProfes

create table Profesores
	(DNI char(9) NOT NULL,
	Nombre varchar(20) NOT NULL,
	Apellidos varchar(30) NOT NULL,
	Titulacion varchar(20) NOT NULL,
	FechaInicioInvestigacion smalldatetime NOT NULL 
		CONSTRAINT DF_Fechaini_profesores DEFAULT GETDATE(),
	FechaFinInvestigacion smalldatetime NULL,
	Grupo smallint NULL,
	Hombre bit NOT NULL,
	NumHijos tinyint NULL
		CONSTRAINT DF_NumHijos_profesores DEFAULT 0,
	EstadoCivil varchar(7) NOT NULL,
	timestamp,
	Suplemento AS 100*NumHijos,
	AñosDeInvestigacion AS datediff(year,FechaInicioInvestigacion,getdate()),
	Usuario as USER,
	constraint PK_DNI_Profesores PRIMARY KEY (DNI),
	constraint CK_DNI_Profesores check (DNI LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'),
	constraint FK_grupo FOREIGN KEY (Grupo)
		REFERENCES Grupos(CodigoGrupo),
	constraint CK_año_Profesores check (year(FechaFinInvestigacion)<>2004),
	constraint CK_Fecha_Profesores check (FechaInicioInvestigacion<FechaFinInvestigacion),
	constraint UQ_Nombrecompleto_Profesores UNIQUE NONCLUSTERED (Nombre,Apellidos))
on GrupoProfes
sp_help Profesores