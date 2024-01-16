/*Tarea 2 Bucles*/

--0--
declare @num1 int, @num2 int
set @num1=0
set @num2=5
while (@num1<0)
	begin 
		set @num1=@num1+1
		set @num2=@num2+1
	end
print @num2

--1--
declare @numero int, @numero2 int
set @numero=1
set @numero2=2

while (@numero2<101)
	begin
		set @numero=@numero+@numero2
		set @numero2=@numero2+1
		print @numero
	end

declare @contador tinyint, @suma int
set @contador=1
set @suma=0
while (@contador<=100)
	begin
		set @suma=@suma+@contador
		set @contador=@contador+1
	end
print @suma

--2--
declare @numero int
set @numero=5

while (@numero<100)
	begin
		print @numero
		set @numero=@numero+5
	end

--3--
use EmpresaNew

declare @numdep int, @departamento varchar (40),@empleado varchar (40)
set @numdep=1

while @numdep<(select MAX(NumDepartamento)+1
					from DEPARTAMENTO)
		begin
			if exists (select * from DEPARTAMENTO
						where NumDepartamento=@numdep)
				begin
					set @departamento=(select NomeDepartamento from DEPARTAMENTO
										where NumDepartamento=@numdep)
					if exists (select * from EMPREGADO
								where NumDepartamentoPertenece=@numdep)
						begin
							set @empleado=(select nome from empregado
								where NumDepartamentoPertenece=@numdep
								and DataNacemento=(select MAX(DataNacemento) from EMPREGADO
												where NumDepartamentoPertenece=@numdep))
						Print 'El emplado mas joven del departamento '+@departamento+' es '+@empleado
						end
					Else 
						Print 'El departamento '+@departamento+' no tiene empleados'
				end
			set @numdep=@numdep+1
		end

declare @numdep int
set @numdep=1

while @numdep<(select MAX(NumDepartamento)+1
					from DEPARTAMENTO)
		begin
		select top 1 NumDepartamentoPertenece,Nome
			from EMPREGADO
			where NumDepartamentoPertenece=@numdep 
			order by DATEDIFF(DD,DataNacemento,GETDATE())/365.25
			set @numdep=@numdep+1
		end
--4--
create table TablaT2_4
(codigo tinyint,
cadena char (1))

declare @codigo tinyint,@cadena char (1)
set @codigo=0

while (@codigo<=57)
	begin
		insert into TablaT2_4
		values(@codigo,(CHAR(ascii('A')+@codigo)));
		set @codigo=@codigo+1
	end

select * from TablaT2_4
delete from TablaT2_4