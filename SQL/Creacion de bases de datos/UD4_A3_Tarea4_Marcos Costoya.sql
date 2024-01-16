/*Tarea 4*/

--1--
/*a*/
Alter table Proyectos
	Drop constraint DF_Proyectos_GUID
Alter table Proyectos
	Drop column GuidProyecto

/*b*/
Alter table Programas
	add FechaFin smalldatetime NOT NULL
		Default getdate() 
		
/*c*/
sp_helpconstraint Profesores

Alter table Profesores
	 nocheck constraint CK_año_Profesores
	 
/*d*/
Alter table Profesores
	 check constraint CK_año_Profesores
	
/*e*/
Alter table Financiacion
	WITH NOCHECK	
	add constraint CK_financiacion check (Financiacion>2500)

/*f*/
Alter table Profesores
	add constraint CK_Tiltulacion check
	(Titulacion in ('Arquitecto','Diplomado','Doctor','Ingeniero','Ingeniero Técnico','Licenciado'))

--2--
/*a*/
use ProyectosdeInvestigacion
INSERT INTO Programas
	(NombrePrograma)
	Values ('Programa1')

/*b*/
Alter table Programas
	add FechaInicio smalldatetime NULL
		Default getdate()
Select * from Programas

/*c*/
Alter table Programas
	drop constraint DF__Programas__Fecha__5165187F

Alter table Programas
	drop column FechaInicio

Alter table Programas
	add FechaInicio smalldatetime NULL
		Default getdate()
		with values

--3--
/*a*/
sp_help Grupos
Drop table Grupos
/*No se puede eliminar porque hay una referencia
hasta esta tabla de una clave foranea*/

/*b*/
Alter table Financiacion
	drop constraint FK__Financiac__Codig__4BAC3F29

sp_help financiacion

/*c*/
Alter table Financiacion
	add constraint DF_Financiacion_Codigo 
	Default 'P00' for CodigoPrograma

/*d*/
Alter table Financiacion
	add constraint FK_Finaciacion_CodigoPrograma 
	FOREIGN KEY (CodigoPrograma)
	REFERENCES Programas (CodigoPrograma)
	on delete set default
	
/*e*/
sp_helpconstraint Proyectos
Alter table Proyectos
	 nocheck constraint CK_Proyectos_Nombre

Alter table Proyectos
	 check constraint CK_Proyectos_Nombre

--4--
/*a*/
Alter table Profesores
	add SueldoBase money Not null
	
Alter table Profesores	
	add Complementos varchar(50) not null

/*b*/
Alter table Profesores
	 drop constraint UQ_Nombrecompleto_Profesores
	 
Alter table Profesores	
	alter column Nombre nvarchar(35)
Alter table Profesores	
	alter column Apellidos nvarchar(35)

Alter table Profesores
	 add constraint UQ_Nombrecompleto_Profesores 
	 UNIQUE (Nombre,Apellidos)
	 