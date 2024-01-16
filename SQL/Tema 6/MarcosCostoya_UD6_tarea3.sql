/*Actualizacion Empresa 3*/

use EmpresaNew

--1--
insert into EMPREGADO_PROXECTO
values (1122331,
(select NumProxecto
from PROXECTO
where NomeProxecto='Melloras sociais')
,3)

insert into EMPREGADO_PROXECTO
select '1122331',NumProxecto,3
from PROXECTO
where NomeProxecto='Melloras sociais'

--2--
update EMPREGADOFIXO
set Salario=null
where NSS in (select ef.NSS
				from EMPREGADO e inner join DEPARTAMENTO d
					on e.NumDepartamentoPertenece=d.NumDepartamento
					inner join EMPREGADOFIXO ef
					on e.NSS=ef.NSS
				where NomeDepartamento='innovaci�n')

--3--Revisar
update EMPREGADOFIXO
set Salario=1900
where NSS in (select ef.NSS
				from EMPREGADOFIXO ef	
				where NSS not IN (select NSS 
									from EMPREGADO e inner join DEPARTAMENTO d
									on e.NumDepartamentoPertenece=d.NumDepartamento
									where nss=NSSDirector and Sexo='M')
and Salario=null

select *
from EMPREGADOFIXO

--4--
/*Empleados de estaditica que no son jefes tienen como jefe el direcctor de estadistica*/
update EMPREGADO
set NSSSupervisa=(select NSSDirector
					from DEPARTAMENTO
					where NomeDepartamento='Estad�stica')
from EMPREGADO e inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
where NomeDepartamento='Estad�stica' and NSS<>NSSDirector

/*Mover el director*/
update EMPREGADO
set NSSSupervisa=(select NSSDirector
					from DEPARTAMENTO
					where NomeDepartamento='innovaci�n')
where nss in (select NSSDirector
					from DEPARTAMENTO
					where NomeDepartamento='Estad�stica')

/*Movemos empleados*/
update EMPREGADO
set NumDepartamentoPertenece=(select NumDepartamento
								from DEPARTAMENTO
								where NomeDepartamento='innovaci�n')
where NumDepartamentoPertenece in (select NumDepartamento
									from DEPARTAMENTO
									where NomeDepartamento='Estad�stica')

/*Mover los proxectos*/	
update PROXECTO
set NumDepartControla=(select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='innovaci�n')
where NumDepartControla in (select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='Estad�stica')

/*Mover los lugares que no estaban en innovacion*/
update LUGAR
set Num_departamento=(select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='innovaci�n')
where Num_departamento in (select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='Estad�stica'
						and LUGAR not IN (select LUGAR
											from LUGAR l inner join DEPARTAMENTO p
											on l.Num_departamento=p.NumDepartamento

/*Eliminamos los lugares de estadistica*/											where NomeDepartamento='innovaci�n'))
delete from LUGAR
where Num_departamento=(select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='Estad�stica')

/*Borramos el departamento Estadistica*/
delete DEPARTAMENTO
where NomeDepartamento ='Estad�stica'

--Variables--
Declare @dptoestad tinyint;
Declare @dptoinno tinyint;

set @dptoestad=(select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='Estad�stica');

set @dptoinno=(select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='innovaci�n');

--5--
update EMPREGADOFIXO
set Salario=3900
where NSS in (select NSSDirector
				from DEPARTAMENTO
				where NomeDepartamento='innovaci�n')

--6--
select Nome,Apelido1,Apelido2,p.NomeProxecto
into DPTO_CONTA
from EMPREGADO e inner join EMPREGADO_PROXECTO ep
	on e.NSS=ep.NSSEmpregado
	inner join PROXECTO p
	on p.NumProxecto=ep.NumProxecto
	inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
where d.NomeDepartamento='contabilidad'

--7--
delete DPTO_CONTA

--8--
update EMPREGADOFIXO
set Salario=(select AVG(Salario)
			from DEPARTAMENTO d inner join EMPREGADO e
				on e.NumDepartamentoPertenece=d.NumDepartamento
				inner join EMPREGADOFIXO ef
				on e.NSS=ef.NSS
			where NomeDepartamento='t�cnico')
where nss in (select e.NSS
				from DEPARTAMENTO d inner join EMPREGADO e
					on e.NumDepartamentoPertenece=d.NumDepartamento
					inner join EMPREGADOFIXO ef
					on e.NSS=ef.NSS
				where NomeDepartamento='t�cnico'
				and salario<(select AVG(Salario)
							from DEPARTAMENTO d inner join EMPREGADO e
								on e.NumDepartamentoPertenece=d.NumDepartamento
								inner join EMPREGADOFIXO ef
								on e.NSS=ef.NSS
							where NomeDepartamento='t�cnico'))

--9--
insert into DPTO_CONTA
select e.Nome,e.Apelido1,e.Apelido2,null
from DEPARTAMENTO d inner join EMPREGADO e
	on e.NumDepartamentoPertenece=d.NumDepartamento
	inner join FAMILIAR f
	on f.NSS_empregado=e.NSS
	inner join EMPREGADOFIXO ef
	on e.NSS=ef.NSS
where Salario<(select AVG(Salario)
			from EMPREGADOFIXO ef)
and f.Parentesco='hij%' and d.NomeDepartamento='contabilidad' and
e.Localidade='Vigo'
