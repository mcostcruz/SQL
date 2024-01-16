/*Tarea 3*/
--1--
use ProyectosdeInvestigacion

create table ProyectosInv
	(CodigoProyecto tinyint identity NOT NULL,
	GuidProyecto uniqueidentifier NOT NULL
		constraint DF_Proyectos_GUID default newid(),
	NombreProyecto varchar (50) NOT NULL,
	Presupuesto money NOT NULL,
	FechaInicio smalldatetime NOT NULL
		constraint DF_Proyectos_FechaInicio default dateadd(dd,-15,getdate()),
	FechaFin smalldatetime NULL,
	Grupo smallint NULL,
	constraint PK_Proyectos_Codigo PRIMARY KEY (CodigoProyecto),
	constraint UQ_Proyectos_Nombre UNIQUE (NombreProyecto),
	constraint UQ_Proyectos_GuidProyecto UNIQUE (GuidProyecto),
	constraint CK_Proyectos_Nombre check (NombreProyecto NOT LIKE '[0-9]%'),
	constraint CK_Proyectos_Presupuesto check (Presupuesto>1000),
	constraint CK_Proyectos_Fechafin check (FechaInicio<FechaFin 
	AND YEAR(FechaFin)=YEAR (FechaInicio)
	AND MONTH(FechaFin)=MONTH(FechaInicio)),
	constraint FK_Proyectos_Grupo FOREIGN KEY (Grupo)
		REFERENCES Grupos(CodigoGrupo))
/*a*/
/*Insetar datos para sacar un GUID*/
INSERT INTO ProyectosdeInvestigacion
	(NombreProyecto,Presupuesto)
	Values
		('Pro',200000)
GO
Select * from ProyectosdeInvestigacion
/*Si permite tener el mismo valor asi que para 
que no nos deje metemos un inique en GUID*/
sp_help ProyectosInv
sp_rename ProyectosInv, Proyectos
drop table ProyectosInv
--2--
create table Participa
	(DNI char (9) NOT NULL,
	CodigoProyecto tinyint NOT NULL,
	FechaInicio smalldatetime NOT NULL,
	FechaCese smalldatetime NULL,
	Dedicacion tinyint NOT NULL,
	Observaciones varchar (100) NULL,
	constraint PK_Participa PRIMARY KEY (DNI,CodigoProyecto,FechaInicio),
	constraint FK_Participa_DNI FOREIGN KEY (DNI)
		REFERENCES Profesores(DNI),
	constraint FK_Participa_Codigo_Proyecto FOREIGN KEY (CodigoProyecto)
		REFERENCES Proyectos(CodigoProyecto))
		
--3--
create table Ubicacion
	(CodigoSede smallint NOT NULL,
	CodigoDepartamento tinyint NOT NULL,
	OrdenAntiguedad tinyint NOT NULL,
	constraint PK_Ubicacion PRIMARY KEY (CodigoSede,CodigoDepartamento),
	constraint FK_Ubicacion_CodigoSede FOREIGN KEY (CodigoSede)
		REFERENCES Sedes(CodigoSede),
	constraint FK_Ubicacion_CodigoDepartamento FOREIGN KEY (CodigoDepartamento)
		REFERENCES Departamento(CodigoDpto),
	constraint CK_Ubicacion_Orden check (OrdenAntiguedad>0)) 
on GrupoProfes

--4--
create table Programas
	(CodigoPrograma char(3) NOT NULL DEFAULT 'P00',
	NombrePrograma varchar(20) Unique NULL,
	PRIMARY KEY (CodigoPrograma),
	check (CodigoPrograma LIKE '[PR][0-9]_'))
	ON [PRIMARY]
	
create table Financiacion
	(CodigoPrograma char(3) NOT NULL 
		REFERENCES Programas
		ON DELETE CASCADE,
	CodigoProyecto tinyint NOT NULL
		REFERENCES Proyectos,
	Financiacion money NOT NULL,
	PRIMARY KEY (CodigoPrograma,CodigoProyecto))
