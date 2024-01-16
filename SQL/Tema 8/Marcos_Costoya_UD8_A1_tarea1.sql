/*Tarea 1*/

use EmpresaNew

--1--
declare @numEmpleados int

set @numEmpleados=(select COUNT(*) from EMPREGADO)
print @numEmpleados

--2--
declare @edadmax tinyint, @edadmin tinyint, @edadmed decimal(4,2)

select @edadmax=floor (MAX(edad)),@edadmin=floor (Min(edad)), 
@edadmed=avg(edad)
from (select NSS,DATEDIFF(DD,DataNacemento,GETDATE())/365.25 as edad
		from EMPREGADO) as x

print @edadmax
print @edadmin
print @edadmed

--3--
select distinct Nome
from EMPREGADO
where Sexo='M'

select @@rowcount

--4--
select @@SERVERNAME,@@LANGUAGE

--5--
declare @nombre varchar (20)
set @nombre='Ana'

if exists (select Nome
			from EMPREGADO
			where Sexo='M' and Nome like '%'+@nombre+'%')
	begin
		print 'EUREKA'
	end
else
	begin
		print 'Otra vez sera'
	end

--6--
declare @nombre2 varchar (20)
set @nombre2='Ana'

if exists(select Nome
			from EMPREGADO
			where Sexo='M' and Nome like '%'+@nombre2+'%')
	begin
		print 'EUREKA'
		if exists (select distinct Nome
					from EMPREGADO
					where Sexo='M' and Nome=@nombre2)
				print 'Lo has clavado'
	end	
else
	begin
		print 'Otra vez sera'
	end