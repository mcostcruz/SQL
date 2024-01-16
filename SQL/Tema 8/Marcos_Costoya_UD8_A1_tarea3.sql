/*Tarea 3 Bucles*/

use EmpresaNew

--1--
declare @departamento varchar (30),@numemp tinyint,@contador tinyint, @linea varchar (70)

set @departamento='Persoal'
set @numemp=(select COUNT(*) from EMPREGADO inner join DEPARTAMENTO
					on NumDepartamentoPertenece=NumDepartamento
					where NomeDepartamento=@departamento)
set @contador=0
set @linea=@departamento+': '
while (@contador<@numemp)
			begin
				set @linea=@linea+'*'
				set @contador=@contador+1
			end
Print @linea

--2--
go
declare @departamento varchar (30),@numempH tinyint,@numempM tinyint,
@contador tinyint, @linea varchar (70)
set @departamento='Técnico'
set @numempH=(select COUNT(*) from EMPREGADO inner join DEPARTAMENTO
					on NumDepartamentoPertenece=NumDepartamento
					where NomeDepartamento=@departamento and Sexo='H')
set @numempM=(select COUNT(*) from EMPREGADO inner join DEPARTAMENTO
					on NumDepartamentoPertenece=NumDepartamento
					where NomeDepartamento=@departamento and Sexo='M')
set @contador=0
set @linea=@departamento+': '

while @contador<@numempH
	begin
		set @linea=@linea+'H'
		set @contador=@contador+1
	end
set @contador=0
while @contador<@numempM
	begin
		set @linea=@linea+'M'
		set @contador=@contador+1
	end
Print @linea
	
--3--
declare @numero int, @numero2 int
set @numero=1
set @numero2=1

while (@numero<21)
	begin
		print @numero2
		set @numero2=@numero2+2
		set @numero=@numero+1		
	end