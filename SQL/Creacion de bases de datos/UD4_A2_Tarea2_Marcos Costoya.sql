/*Tarea 2 */
--Tarea1--
create database DBCreateDB2
on
	PRIMARY
	(NAME=BDCreateDB2_Data,
	FILENAME="C:\Bases\BDCreateDB2_Data.mdf",
	SIZE=3MB,
	FILEGROWTH=15%)
log on
(NAME=DBCreateDB2_Log,
FILENAME="C:\Bases\BDCreateDB2_Data.ldf",
SIZE=2MB,
MAXSIZE=5MB,
FILEGROWTH=15%)

/*Tarea 2 */
--Tarea2--
create database DBCreateDB3
on
	PRIMARY
	(NAME=BDCreateDB3_root,
	FILENAME="C:\Bases\BDCreateDB3_root.mdf",
	SIZE=8MB,
	MAXSIZE=9MB,
	FILEGROWTH=100KB),
	(NAME=BDCreateDB3_data1,
	FILENAME="C:\Bases\BDCreateDB3_data1.ndf",
	SIZE=10MB,
	MAXSIZE=15MB,
	FILEGROWTH=1MB)
	
log on
(NAME=DBCreateDB3_Log,
FILENAME="C:\Bases\BDCreateDB3_Log.ldf",
SIZE=10MB,
MAXSIZE=15MB,
FILEGROWTH=1MB)

/*Tarea 2 */
--Tarea3--
CREATE DATABASE Products2
sp_helpdb Products2
/*
Products2
Archivo principal
Tamaño minimo de 2.81MB
Filegroup Primary
Tamaño maximo ilimitado
Crecimiento de 1MB
Data only
Ruta C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Products2.mdf

Products2-log
Archivo de registro
Tamaño minimo de 500kB
Filegroup NULL
Tamaño maximo 2147483648 kB
Crecimiento de 10%
log only
Ruta C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\Products2_log.LDF
*/