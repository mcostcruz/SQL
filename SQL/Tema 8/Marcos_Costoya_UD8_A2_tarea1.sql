/*Procedimientos Tarea 1*/

use EmpresaNew

--1--
if exists (select *
			from sysobjects
			where xtype='P' and name='UsoDeVariables')
		drop proc sp_UsoDeVariables	
go
create proc sp_UsoDeVariables
as
begin
	declare @Nombre varchar (20);
	declare @Edad tinyint;
	declare @Altura decimal
	set @Nombre='Juan'
	set @Edad=14
	set @Altura=1.68
	print @nombre+' tiene '+cast(@edad as varchar)+' años y mide '+
	cast(@altura as varchar)
end

exec sp_UsoDeVariables
--2--
if OBJECT_ID('MayorDeDosEnteros') is not null
drop proc MayorDeDosEnteros

go
create proc sp_MayorDeDosEnteros
	@num1 tinyint,
	@num2 tinyint
as
begin
	if (@num1>@num2)
		Print cast(@num1 as varchar)+' es mayor que '+cast(@num2 as varchar)
	else if (@num1=@num2)
		Print cast(@num2 as varchar)+' es igual que '+cast(@num1 as varchar)
	else
		Print cast(@num2 as varchar)+' es mayor que '+cast(@num1 as varchar)
end

exec sp_MayorDeDosEnteros 3,2

--3--
if OBJECT_ID('MayorQueSueldoMin') is not null
drop proc MayorQueSueldoMin

go
create proc sp_MayorQueSueldoMin
	@sueldo int
as
begin
	declare @sueldomin int 
	set @sueldomin =(select MIN(Salario)
					from EMPREGADOFIXO)

	if (@sueldo>@sueldomin)
		Print cast(@sueldo as varchar)+' es mayor que el salario mas bajo'
	else
		Print cast(@sueldo as varchar)+' es menor que el salario mas bajo'
end	

exec sp_MayorQueSueldoMin 1000

--4--
go
create proc sp_Listado_proyectos
	@nom varchar (15)
as
begin
	if exists (select * from DEPARTAMENTO
				where NomeDepartamento like '%'+@nom+'%')
		select NomeDepartamento,NomeProxecto,
		e.Nome+' '+Apelido1+' '+ISNULL(Apelido2,'') as Nome_completo
		from PROXECTO p inner join DEPARTAMENTO d
			on d.NumDepartamento=p.NumDepartControla
			inner join EMPREGADO_PROXECTO ep
			on ep.NumProxecto=p.NumProxecto
			inner join EMPREGADO e
			on e.NSS=ep.NSSEmpregado
		where NomeDepartamento like '%'+@nom+'%'
	else
		print 'No hay ningun departamento que contenga '+@nom
end

exec sp_Listado_proyectos 'in'