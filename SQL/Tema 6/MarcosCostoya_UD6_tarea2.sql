/*Actualizacion BD EmpresaNew*/

use EmpresaNew

--1--
insert into HORASEXTRAS (Data,HorasExtras,NSS)
values (DATEADD (DD,-1,GETDATE()),3
,
(select e.nss
from EMPREGADO e inner join HORASEXTRAS h
	on e.NSS=h.NSS
where e.Nome in ('Eligio') 
and Apelido1 in ('Rodrigo')and Apelido2 is null));

insert into HORASEXTRAS (Data,HorasExtras,NSS)
values (DATEADD (DD,-1,GETDATE()),3
,
(select e.nss
from EMPREGADO e inner join HORASEXTRAS h
	on e.NSS=h.NSS
where e.Nome in ('Xiao') 
and Apelido1 in ('Vecino')and Apelido2 in ('Vecino')))


--2--
select *
from CURSO

insert into CURSO (Nome,Horas)
values ('Diseño web',30)

select *
from EDICION

insert into EDICION
values (
		(select codigo
		from CURSO
		where Nome like ('Diseño web'))
		,
		(select isnull (MAX(Numero),0)
		from EDICION
		where Codigo=9)+1
		,'2021-04-15','Pontevedra',
		(select NSSDirector
		from DEPARTAMENTO
		where NomeDepartamento like ('Técnico'))
		)

--3--
select *
from EDICIONCURSO_EMPREGADO

insert into EDICIONCURSO_EMPREGADO
select (select codigo
		from CURSO
		where Nome like ('Diseño web')),
		(select Numero
		from EDICION
		where DATA='2021-04-15'),NSS
from EMPREGADO e inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
where not exists (select *
				from DEPARTAMENTO
				where NSSDirector=NSS)
and NomeDepartamento like ('Técnico')

--4--
select ef.Salario
from EMPREGADO e inner join EMPREGADOFIXO ef
	on e.NSS=ef.NSS
	inner join DEPARTAMENTO d
	on d.NumDepartamento=e.NumDepartamentoPertenece
where d.NomeDepartamento like ('contabilidad')

update EMPREGADOFIXO
set Salario=Salario*1.02
where NSS in (select NSS
	from EMPREGADO e inner join DEPARTAMENTO d
	on d.NumDepartamento=e.NumDepartamentoPertenece
where d.NomeDepartamento like ('contabilidad'))

--5--
update EMPREGADO_PROXECTO
set NumProxecto=(select NumProxecto
					from PROXECTO p
					where p.NomeProxecto like ('Xestion da calidade'))
where NSSEmpregado=9900000

select *
from EMPREGADO_PROXECTO
where NSSEmpregado=9900000
--6--
select *
from PROXECTO

insert into proxecto
values ((select MAX(NumProxecto)from PROXECTO)+1,'Diseño nova web',
'Vigo',(select NumDepartamento
		from DEPARTAMENTO
		where NomeDepartamento='Técnico'))


select *
from TAREFA

insert into TAREFA
values(
		(select NumProxecto
		from PROXECTO
		where NomeProxecto like ('Diseño nova web'))
		,
		(select isnull (MAX(Numero),0)
		from TAREFA
		where NumProxecto=13)+1
		,
		'Definir o obxectivo da paxina',

		dateadd (dd,+15,getdate())
		,
		dateadd (dd,+22,getdate())
		,'Media','Pendiente')

insert into TAREFA
values(
		(select NumProxecto
		from PROXECTO
		where NomeProxecto like ('Diseño nova web'))
		,
		(select isnull (MAX(Numero),0)
		from TAREFA
		where NumProxecto=13)+1
		,
		'Elexir o estilo e crear o mapa do sitio',

		dateadd (dd,+20,getdate()),null
		,'Media','Pendiente')
		
select *
from EMPREGADO_PROXECTO

insert into EMPREGADO_PROXECTO
values (
(select NSSDirector
from DEPARTAMENTO
where NomeDepartamento='Técnico')
,
(select NumProxecto
from PROXECTO
where NomeProxecto like ('Diseño nova web'))
,
8)

insert into EMPREGADO_PROXECTO
values (
(select NSS
from EMPREGADO
where Nome='Felix' and Apelido1='Barreiro' and Apelido2='Valiña')
,
(select NumProxecto
from PROXECTO
where NomeProxecto like ('Diseño nova web'))
,
5)