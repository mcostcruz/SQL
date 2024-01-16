/*Procedimientos Tarea 1b*/

use EmpresaNew

--1--
if OBJECT_ID('sp_MayorDeDosEnteros') is not null
drop proc sp_MayorDeDosEnteros

go
create proc sp_MayorDeDosEnteros
	@num1 tinyint,
	@num2 tinyint,
	@resultado varchar (50) output
as
begin
	if (@num1>@num2)
		set @resultado=cast(@num1 as varchar)+' es mayor que '+cast(@num2 as varchar)
	else if (@num1=@num2)
		set @resultado=cast(@num2 as varchar)+' es igual que '+cast(@num1 as varchar)
	else
		set @resultado=cast(@num2 as varchar)+' es mayor que '+cast(@num1 as varchar)
end

declare @resultado varchar (50)
exec sp_MayorDeDosEnteros 3,2,@resultado output
select 'El resultado es: '+@resultado

--2--
go
drop proc sp_Suma
go
create proc sp_Suma
	@numero smallint,
	@suma tinyint output
as
begin
	declare @contador smallint
	set @contador=1
	if(@numero<=0)
		return -1
	else
		set @suma=0	
		while (@contador<=@numero)
			begin 
				set @suma=@suma+@contador
				set @contador=@contador+1
			end
end

declare @suma smallint
declare @salida int
exec @salida=sp_Suma -4,@suma output
Print @suma
Print @salida

--3--
go
create proc sp_DatosDepartamento
	@nombre varchar (50),
	@empleados tinyint output,
	@empfixos tinyint output,
	@salario int output,
	@director varchar (50) output
as
begin
	if not exists (select * from DEPARTAMENTO where NomeDepartamento=@nombre)
		Return -1
	else
		set @empleados = (select COUNT(*)
							from EMPREGADO inner join DEPARTAMENTO
							on NumDepartamentoPertenece=NumDepartamento
							where NomeDepartamento=@nombre)
		set @empfixos=(select COUNT(*)
							from EMPREGADO inner join DEPARTAMENTO
							on NumDepartamentoPertenece=NumDepartamento
							inner join EMPREGADOFIXO
							on EMPREGADO.NSS=EMPREGADOFIXO.NSS
							where NomeDepartamento=@nombre)
		set @salario=(select SUM(Salario)
							from EMPREGADO inner join DEPARTAMENTO
							on NumDepartamentoPertenece=NumDepartamento
							inner join EMPREGADOFIXO
							on EMPREGADO.NSS=EMPREGADOFIXO.NSS
							where NomeDepartamento=@nombre)
		set @director = (select Nome+' '+Apelido1+' '+ISNULL(Apelido2,'') as Nome_completo
							from EMPREGADO inner join DEPARTAMENTO
							on NSS=NSSDirector
							where NomeDepartamento=@nombre)
		Return 0
end

declare @empleados tinyint
declare @empfixos tinyint
declare @salario int
declare @director varchar
declare @var int
exec @var=sp_DatosDepartamento 'contabilidad',@empleados output,@empfixos output,
@salario output,@director output
Print @var
Print 'El numero de empleados es '+cast(@empleados as varchar)
Print 'El numero de empleados fijos es '+cast(@empfixos as varchar)
Print 'El salario es '+cast(@salario as varchar)
Print 'El nombre del director es '+@director

select * from DEPARTAMENTO

--4--
go
create proc sp_Visualizardatosdepartamento
	@nombre varchar (50)='Técnico'
as
begin
	declare @empleados tinyint
	declare @empfixos tinyint
	declare @salario int
	declare @director varchar (50)
	
	exec sp_DatosDepartamento @nombre,@empleados output,@empfixos output,
	@salario output,@director output

	Print 'Departamento: '+@nombre
	Print 'Director: '+@director
	Print 'Total salario: '+cast(@salario as varchar)
	Print 'El numero de empleados fijos es '+cast(@empfixos as varchar)+ ' en un total de '+cast(@empleados as varchar)

end

exec sp_Visualizardatosdepartamento 'contabilidad'

--5--
go
create proc InicialEmpleados
	@inicial char (1)='C'
as
begin
	if @inicial not like '[A-Z]'
		Return -1
		
	else 
		select NSS,e.Nome+' '+Apelido1+' '+ISNULL(Apelido2,'') as Nome_completo,
		NomeDepartamento,isnull (x.Nome,'Sin Supervisor')as Supervisor
		from EMPREGADO e inner join DEPARTAMENTO d
			on e.NumDepartamentoPertenece=d.NumDepartamento
			inner join (select Nome+' '+Apelido1+' '+ISNULL(Apelido2,'') as Nome,NumDepartamento
						from EMPREGADO e inner join DEPARTAMENTO d
						on e.NSS=d.NSSDirector)as x
			on x.NumDepartamento=d.NumDepartamento
		where e.Nome like @inicial+'%'
end

declare @salida int
exec @salida=InicialEmpleados 'C'
Print @salida

--6--
go
create proc InsertarEmpleados
	@inicial varchar (1)
as
begin
	if @inicial not like '[A-Z]'
		Print 'Paramentro incorrecto, no se insertara ningun registro'
	else if exists (select * from EMPREGADO where Nome like @inicial+'%') 
		insert into EmpregadoDepartamento
		exec InicialEmpleados @inicial
	else
		Print 'No hay ningun empleado que empiece por la letra '+@inicial
end

exec InsertarEmpleados 'C'

drop proc InsertarEmpleados

--7--
