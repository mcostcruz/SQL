/*Tarea 4 */
--Tarea1--
create database Ventas_root
on
	PRIMARY
	(NAME=Ventas_root,
	FILENAME="C:\Bases\Ventas_root.mdf",
	SIZE=10MB,
	MAXSIZE=50MB,
	FILEGROWTH=15%),
	FILEGROUP grupo_clientes,
	(NAME=cliente_data1,
	FILENAME="C:\Bases\cliente_data1.ndf",
	SIZE=10MB,
	MAXSIZE=50MB,
	FILEGROWTH=15%),
	(NAME=cliente_data2,
	FILENAME="C:\Bases\cliente_data2.ndf",
	SIZE=10MB,
	MAXSIZE=50MB,
	FILEGROWTH=15%),
	(NAME=cliente_data3,
	FILENAME="C:\Bases\cliente_data3.ndf",
	SIZE=10MB,
	MAXSIZE=50MB,
	FILEGROWTH=15%),
	FILEGROUP grupo_productos
	(NAME=producto_data1,
	FILENAME="C:\Bases\producto_data1.ndf",
	SIZE=10MB,
	FILEGROWTH=0)
	(NAME=producto_data2,
	FILENAME="C:\Bases\producto_data2.ndf",
	SIZE=10MB,
	FILEGROWTH=0)
log on
(NAME=log_data1,
FILENAME="C:\Bases\log_data1.ldf",
SIZE=5MB,
MAXSIZE=25MB,
FILEGROWTH=5MB)

sp_helpdb Ventas_root

--Tarea2--
/*
Generar una lista de todas las bases de datos.

sp_helpdb

Mostrar informacición acerca de la utilización del espacio en la base de datos Adventure Works

USE Adventure Works
sp_spaceused 

Mostrar información acerca de la utilización del espacio para la tabla Product en la base de datos Adventure Works

USE Adventure Works
sp_spaceused Product

Visualizar una lista de todas las opciones de bases de datos que se pueden configurar.

sp_dboption

Visualiza una lista de opciones que están activas para la base de datos VENTAS.

sp_dboption VENTAS
*/