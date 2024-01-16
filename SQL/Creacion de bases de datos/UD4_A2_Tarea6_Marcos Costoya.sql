/* Tarea 6 */
--Tarea 1--
/*a*/Create database BD_AlterDB1

/*b*/Alter database BD_AlterDB1
add file
(NAME=BD_AlterDB1_Data,
Filename="C:\Bases\D_AlterDB1_Data.ndf",
SIZE=3MB,
FILEGROWTH=2MB)

/*c*/Alter database BD_AlterDB1
MODIFY file
(NAME=BD_AlterDB1_Data,
Filename="C:\Bases\D_AlterDB1_Data.ndf",
SIZE=5MB)

Alter database BD_AlterDB1
MODIFY file
(NAME=BD_AlterDB1_Data,
Filename="C:\Bases\D_AlterDB1_Data.ndf",
SIZE=3MB)
/* No me deja podificarlo porque el tamaño es menor al actual */

--Tarea 2--
/*a*/
create database BD_AlterDB2
on
	PRIMARY
	(NAME=BD_AlterDB2,
	FILENAME="C:\Bases\BD_AlterDB2.mdf",
	SIZE=3MB,
	MAXSIZE=4MB,
	FILEGROWTH=0)
/*b*/
alter database BD_AlterDB2
modify file
(NAME=BD_AlterDB2,
	FILENAME="C:\Bases\BD_AlterDB2.mdf",
	SIZE=6MB)
/* Que el max size se pone en el mismo tamaño que el size*/

--Tarea3--
/*a*/
create database BD_AlterDB3
on
	PRIMARY
	(NAME=BD_AlterDB3,
	FILENAME="C:\Bases\BD_AlterDB3.mdf"),
	(NAME=BD_AlterDB3_Data1,
	FILENAME="C:\Bases\BD_AlterDB3_Data1.ndf",
	SIZE=3MB,
	MAXSIZE=10MB,
	FILEGROWTH=1MB)
/*b*/
Alter database BD_AlterDB3
add file
(NAME=BD_AlterDB3_Data,
Filename="C:\Bases\BD_AlterDB3_Data2.ndf",
SIZE=5MB,
MAXSIZE=15MB,
FILEGROWTH=2MB)
/*c*/
Alter database BD_AlterDB3
add filegroup Grupo1
Alter database BD_AlterDB3
add file
(NAME=BD_AlterDB3_Data3,
	FILENAME="C:\Bases\BD_AlterDB3_Data3.ndf",
	SIZE=1MB,
	FILEGROWTH=10%),
(NAME=BD_AlterDB3_Data4,
	FILENAME="C:\Bases\BD_AlterDB3_Data4.ndf",
	SIZE=1MB,
	FILEGROWTH=10%)
to FILEGROUP Grupo1
Alter database BD_AlterDB3
modify filegroup Grupo1 default

--Tarea 4--
Alter database BD_AlterDB3
remove file BD_AlterDB3_Data3

--Tarea 5--
Alter database BD_AlterDB3
modify file
(NAME=BD_AlterDB3_Data1,
	FILENAME="C:\Bases\BD_AlterDB3_Data1.ndf",
	SIZE=4MB,
	FILEGROWTH=3MB)

--Tarea 6--
Alter database BD_AlterDB3
modify filegroup Grupo1 readonly

--Tarea 7--
Alter database BD_AlterDB3
modify filegroup Grupo1 readwrite

Alter database BD_AlterDB3
modify filegroup [PRIMARY] DEFAULT

Alter database BD_AlterDB3
remove file BD_AlterDB3_Data4

Alter database BD_AlterDB3
remove filegroup Grupo1