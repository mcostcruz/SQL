/*Tarea 5*/

create database BDVideoclub
on
	PRIMARY
	(NAME=ArchivoPrincipal,
	FILENAME="C:\Bases\ArchivoPrincipal.mdf",
	SIZE=5MB,
	FILEGROWTH=2MB),
	FILEGROUP Datos_peliculas
	(NAME=datosPeliculas1,
	FILENAME="C:\Bases\datosPeliculas1.ndf",
	SIZE=20MB,
	MAXSIZE=60MB,
	FILEGROWTH=10%),
	(NAME=datosPeliculas2,
	FILENAME="C:\Bases\datosPeliculas2.ndf",
	SIZE=20MB,
	MAXSIZE=60MB,
	FILEGROWTH=10%)

Alter Database BDVideoclub
Modify filegroup Datos_peliculas default

use BDVideoclub
EXEC sp_addtype 'TipoNacionalidad','varchar(15)','NOT NULL'
EXEC sp_addtype 'TipoFecha','smalldatetime','NOT NULL'
go
create table Pelicula
	(IdPelicula varchar(7) NOT NULL,
	Titulo varchar(20) NOT NULL,
	AñoProduccion smallint NOT NULL,
	Duracion smallint NOT NULL,
	Nacionalidad TipoNacionalidad,
	CodCategoria tinyint NOT NULL,
	constraint PK_Pelicula_IdPelicula PRIMARY KEY (IdPelicula),
	check (IdPelicula LIKE '[PF][AEIOU][-][0-9][0-9][0-9][0-9]'))
	

create table Ejemplar
	(IdPelicula varchar(7) NOT NULL,
	IdEjemplar tinyint NOT NULL,
	Estado char(1) NOT NULL
		CONSTRAINT DF_Ejemplar_Estado DEFAULT 'B',
	Fechadecompra smalldatetime 
		constraint DF_Ejemplar_Fecha default dateadd(day,-2,getdate()),
	constraint CK_Ejemplar_Estado check (Estado in ('B','R','M')),
	constraint PK_Ejemplar_IdEjemplar PRIMARY KEY (IdEjemplar,IdPelicula),
	constraint FK_Ejemplar_IdPelicula FOREIGN KEY (IdPelicula)
		REFERENCES Pelicula(IdPelicula)
		on delete cascade on update cascade)
	
create table Socio
	(Numero smallint identity Not null,
	DNI varchar(9)Not null,
	Nombre varchar(20)Not null,
	Apellidos varchar (20)Not null,
	Direccion varchar(30)Not null,
	Telefono char (9)Not null,
	Fechadealta TipoFecha,
	constraint PK_Socio_Numero PRIMARY KEY (Numero),
	constraint CK_Socio_DNI check (DNI LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][A-Z]'),
	constraint CK_Socio_Telefono check (Telefono LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint UQ_Socio_DNI UNIQUE (DNI)
	) ON [PRYMARY]

create table Alquiler
	(IdEjemplar tinyint not null,
	IdPelicula varchar(7) not null,
	FechaAlq TipoFecha,
	NumeroSocio smallint,
	FechaEstimadaDev TipoFecha 
		constraint DF_Alquiler_FechaEst default dateadd(day,+15,getdate()),
	FechaDev TipoFecha,
	constraint FK_Alquiler_IdEjemplar FOREIGN KEY (IdEjemplar, IdPelicula)
		REFERENCES Ejemplar(IdEjemplar, IdPelicula)
		ON Delete Cascade
		On Update Cascade,
	constraint PK_Alquiler_FechaAlq PRIMARY KEY (IdEjemplar,IdPelicula,FechaAlq),
	constraint FK_Alquiler_NumeroSocio FOREIGN KEY (NumeroSocio)
		REFERENCES Socio(Numero)
		ON Delete Cascade
		On Update Cascade,
	constraint CK_Alquiler_Fechas check (FechaDev>FechaAlq),
	)


create table Actor
	(Nombre varchar(20),
	Nacionalidad TipoNacionalidad,
	Sexo char(1)
		CONSTRAINT DF_Actor_Sexo Default 'M',
	constraint PK_Actor_Nombre PRIMARY KEY (Nombre),
	constraint CK_Actor_Sexo check (Sexo LIKE '[HM]')
	)

create table Actua
	(NombreActor varchar(20),
	IdPelicula varchar(7),
	PrincSec char(1)
		CONSTRAINT DF_Actua_PrincSec Default 'P',
	constraint PK_Actua_Clave PRIMARY KEY (NombreActor,IdPelicula),
	constraint FK_Actua_NombreActor FOREIGN KEY (NombreActor)
		REFERENCES Actor (Nombre),
	constraint FK_Actua_IdPelicula FOREIGN KEY (IdPelicula)
		REFERENCES Pelicula (IdPelicula)
		ON Delete Cascade
		On Update Cascade,
	constraint CK_Actua_PrincSec check (PrincSec LIKE '[PS]')
	)
	
create table Director
	(Nombre varchar(25),
	Nacionalidad TipoNacionalidad,
	constraint PK_Director_Nombre PRIMARY KEY (Nombre)
	)
	 
create table Dirige
	(IdPelicula varchar(7),
	NombreDirector varchar(25),
	constraint FK_Dirige_IdPelicula FOREIGN KEY (IdPelicula)
		REFERENCES Pelicula (IdPelicula)
		ON Delete Cascade
		On Update Cascade,
	constraint FK_Dirige_NombreDirector FOREIGN KEY (NombreDirector)
		REFERENCES Director (Nombre),
	constraint PK_Dirige_Nombre PRIMARY KEY (NombreDirector,IdPelicula)
	)

create table Familiar
	(DNI varchar(9),
	Nombre varchar(50),
	Parentesco varchar(15),
	FechaNacimento TipoFecha,
	NumeroSocio smallint,
	constraint PK_Familiar_DNI PRIMARY KEY (DNI),
	constraint FK_Familiar_NumeroSocio FOREIGN KEY (NumeroSocio)
		REFERENCES Socio (Numero)
		ON Delete Cascade
		On Update Cascade
	) ON [PRYMARY]
	
create table categoria
	(CodCategoria tinyint identity (1,5)Not null,
	Precio money not null,
	Descripcion varchar(30) null,
	constraint PK_Categoria_CodCategoria PRIMARY KEY (CodCategoria))

Alter table Pelicula
	add constraint FK_Pelicula_CodCategoria FOREIGN KEY (CodCategoria)
	REFERENCES categoria (CodCategoria)
	On Update Cascade

/*Modificaciones*/

--1--
Alter table Alquiler
	add PrecioAlquiler money Not null
		constraint DF_Alquiler_Precio 
		DEFAULT '4'
		with values
--2--
Alter table Alquiler
	add constraint DF_Aquiler_FechaAlq 
	Default getdate() for FechaAlq

Alter table Socio
	add constraint DF_Socio_Fechaalta 
	Default getdate() for Fechadealta

--3--
alter table categoria
	With check
	add constraint CK_categoria_Precio
	check (Precio BETWEEN 1 AND 300) 

--4--
Alter table Alquiler
	DROP CONSTRAINT DF_Alquiler_Precio

Alter table Alquiler
	DROP COLUMN PrecioAlquiler

--5--
create table Distibuidora
	(IdDistibuidora tinyint Identity not null,
	Nombre varchar (20),
	Direccion varchar (50),
	Fax char (9),
	Email varchar (60),
	constraint PK_Distibuidora_IdDistibuidora PRIMARY KEY (IdDistibuidora),
	constraint UQ_Distibuidora_Nombre UNIQUE (Nombre)
	)

Alter table Pelicula
	add Distibuidora tinyint not null
	constraint FK_Pelicula_Distibuidora FOREIGN KEY (Distibuidora)
	REFERENCES Distibuidora (IdDistibuidora)
	
alter table Socio
	add Recomendado smallint null

alter table Socio
	add constraint FK_Socio_Peliculas
	Foreign key (Recomendado)
	References Socio (Numero)
	
--6--
Alter table Alquiler
nocheck constraint all

Alter table Peliculas
nocheck constraint all

Alter table Alquiler
check constraint all

Alter table Peliculas
check constraint all

	