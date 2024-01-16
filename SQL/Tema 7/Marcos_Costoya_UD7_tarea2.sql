/*Transacciones Tarea 2 */

use CATASTRO

--1--
select * from PISO
select * from BLOQUEPISOS
select * from VIVIENDA

set implicit_transactions on
Begin try

update VIVIENDA
set TIPOVIVIENDA='Bloque'
where CALLE='Pasión' and NUMERO=3;

insert into BLOQUEPISOS
values ('Pasión',3,3,'N');

insert into PISO
values ('Pasión',3,1,'A',1,50,55,(select DNIPROPIETARIO
							from CASAPARTICULAR
							where CALLE='Pasión' and NUMERO=3));
insert into PISO
values ('Pasión',3,2,'A',1,50,55,(select DNIPROPIETARIO
							from CASAPARTICULAR
							where CALLE='Pasión' and NUMERO=3));
insert into PISO
values ('Pasión',3,3,'A',1,46,50,(select DNIPROPIETARIO
							from CASAPARTICULAR
							where CALLE='Pasión' and NUMERO=3));
delete from CASAPARTICULAR
where CALLE='Pasión' and NUMERO=3
				
Commit
end try
begin catch
	rollback
	print 'ERROR'
end catch

set implicit_transactions off

--2--
use EmpresaNew

set implicit_transactions on
Begin try

update EMPREGADO
set NSSSupervisa=(select NSSDirector
					from DEPARTAMENTO
					where NomeDepartamento='Estadística')
from EMPREGADO e inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
where NomeDepartamento='Estadística' and NSS<>NSSDirector

update EMPREGADO
set NSSSupervisa=(select NSSDirector
					from DEPARTAMENTO
					where NomeDepartamento='innovación')
where nss in (select NSSDirector
					from DEPARTAMENTO
					where NomeDepartamento='Estadística')

update EMPREGADO
set NumDepartamentoPertenece=(select NumDepartamento
								from DEPARTAMENTO
								where NomeDepartamento='innovación')
where NumDepartamentoPertenece in (select NumDepartamento
									from DEPARTAMENTO
									where NomeDepartamento='Estadística')

update PROXECTO
set NumDepartControla=(select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='innovación')
where NumDepartControla in (select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='Estadística')

update LUGAR
set Num_departamento=(select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='innovación')
where Num_departamento in (select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='Estadística'
						and LUGAR not IN (select LUGAR
											from LUGAR l inner join DEPARTAMENTO p
											on l.Num_departamento=p.NumDepartamento
										    where NomeDepartamento='innovación'))
delete from LUGAR
where Num_departamento=(select NumDepartamento
						from DEPARTAMENTO
						where NomeDepartamento='Estadística')
Commit
end try
begin catch
	rollback
	print 'ERROR'
end catch

set implicit_transactions off

--3--
update EMPREGADO_PROXECTO
set HORAS=case 
			when Horas IS null then 15
			when Horas+15<=25 then Horas+15
			else 25
			end
from EMPREGADO_PROXECTO ep
where NSSEmpregado in (select NSS
						from EMPREGADO e inner join DEPARTAMENTO d
						on d.NumDepartamento=e.NumDepartamentoPertenece
						where NomeDepartamento='Persoal' ) and
NumProxecto=(select NumProxecto from PROXECTO
			where NomeProxecto='Portal')

--4--
alter table proxecto
alter column nomeproxecto varchar (60)

set implicit_transactions on
Begin try

/*Crear Proxecto*/
insert into PROXECTO
values ((
select MAX(NumProxecto)+1
			from PROXECTO),
'Informatizacion de permisos','Vigo',
(select NumDepartamento
from DEPARTAMENTO
where NomeDepartamento='Persoal'));

/*Horas al director*/
insert into EMPREGADO_PROXECTO
values (
(select NSSDirector
from DEPARTAMENTO d inner join EMPREGADO e
	on e.NSS=d.NSSDirector
where NomeDepartamento='Persoal')
,
(select NumProxecto
from PROXECTO
where NomeProxecto='Informatizacion de permisos')
,8)

insert into EMPREGADO_PROXECTO
select NSSEmpregado, (select NumDepartamento
					from DEPARTAMENTO
					where NomeDepartamento='Persoal'),
case
	when isnull (SUM(Horas),0)+5<=42 then 5
	else 42-SUM(Horas)
end
from EMPREGADO_PROXECTO
where NSSEmpregado in (select NSS
						from  EMPREGADO e
						where NumDepartamentoPertenece=1)
and NSSEmpregado<> (select NSSDirector
					from DEPARTAMENTO d inner join EMPREGADO e
						on e.NSS=d.NSSDirector
					where NomeDepartamento='Persoal')
group by NSSEmpregado
having SUM(Horas)<42

update EMPREGADOFIXO
set Salario=Salario+12*4*(select SUM(HORAS)-40
					from EMPREGADO_PROXECTO
					where ef1.NSS=NSSEmpregado)
from EMPREGADOFIXO ef1
where NSS in (select NSSEmpregado
				from EMPREGADO_PROXECTO ep inner join EMPREGADOFIXO ef
				on ep.NSSEmpregado=ef.NSS
				group by NSSEmpregado
				having SUM(Horas)>40)

Commit
end try
begin catch
	rollback
	print 'ERROR'
end catch

set implicit_transactions off


