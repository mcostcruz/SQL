/*Tarea individual*/

use EmpresaNew

--1--
select  e.Nome+' '+e.Apelido1+' '+ISNULL(e.Apelido2,' ')as 'Nome Completo',
d.NomeDepartamento as Departamento, DataInicio as desde, DataFin as hasta,
(CosteHora*NumHoras) as coste 
from EMPREGADOTEMPORAL et inner join EMPREGADO e
	on et.NSS=e.NSS
	inner join DEPARTAMENTO d
	on d.NumDepartamento=e.NumDepartamentoPertenece
where et.DataFin>GETDATE() or et.DataFin is null
order by DEPARTAMENTO, coste

--2--
select isnull (LEft(Provincia,2),'XX')+SUBSTRING(d.NomeDepartamento,2,1)+
REVERSE(isnull (e.CP,'')) as Codigo, e.Nome,d.NomeDepartamento,CP,
Provincia=case
			when Provincia='27' then 'Lugo'
			when Provincia='36' then 'Pontevedra'
			when Provincia='27' then 'A Coruña'
			ELSE 'XX'
			END
from EMPREGADO e inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
order by Nome desc,Provincia asc

select e.Nome+' '+e.Apelido1+' '+ISNULL(e.Apelido2,' ')as 'Nome Completo',
d.NomeDepartamento,CP,Provincia=case
									when Provincia='27' then 'Lugo'
									when Provincia='36' then 'Pontevedra'
									when Provincia='27' then 'A Coruña'
									ELSE 'XX'
									END,

isnull (LEft(Provincia,2),'XX')+SUBSTRING(d.NomeDepartamento,2,1)+
REVERSE(isnull (e.CP,'')) as Codigo
from EMPREGADO e inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
order by Nome desc,Provincia asc

--3--
select Localidade,isnull (Provincia,'sin provincia')as Provincia
from EMPREGADO
order by RIGHT(Localidade,2)

--4--
select top 1 with ties e.Nome+' '+e.Apelido1+' '+ISNULL(e.Apelido2,' ')as 'Nome Completo',
YEAR(GETDATE()-datanacemento-1)-1900 as edad
from EMPREGADO e
where DataNacemento is not null
order by edad

--5--
select p.NomeProxecto, p.numProxecto
from PROXECTO p inner join PROBLEMA pr
	on p.NumProxecto=pr.numProxecto
group by p.NomeProxecto, p.numProxecto
having COUNT(solucion)>1

--6--
select NomeProxecto
from PROXECTO
where NumProxecto not in(select pr.numProxecto
							from PROXECTO p inner join PROBLEMA pr
							on p.NumProxecto=pr.numProxecto) or
NumProxecto in (select p.NumProxecto
				from TAREFA t inner join PROXECTO p
					on t.NumProxecto=p.NumProxecto
				where estado ='En Progreso' and LUGAR in ('Pontevedra','Ribadeo','Santiago')
				)
--7--
select p.NomeProxecto, COUNT(*) as num_empregados
from PROXECTO p inner join EMPREGADO_PROXECTO ep
	on p.NumProxecto=ep.NumProxecto
group by p.NomeProxecto
having COUNT(*)>(select COUNT(*)
					from PROXECTO p inner join EMPREGADO_PROXECTO ep
						on p.NumProxecto=ep.NumProxecto
					where NumDepartControla=(select numdepartamento
												from DEPARTAMENTO
												where NomeDepartamento='técnico'))

--8--
select Sum(YEAR(GETDATE()-datanacemento-1)-1900)/COUNT (*) as media
from EMPREGADO e
where Sexo='M'

select avg(YEAR(GETDATE()-datanacemento-1)-1900) as media
from EMPREGADO e
where Sexo='M'

--9--
select NomeProxecto,count (distinct d.NomeDepartamento) as departamentos
from EMPREGADO_PROXECTO ep inner join EMPREGADO e
	on ep.NSSEmpregado=e.NSS
	inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
	inner join PROXECTO p
	on p.NumProxecto=ep.NumProxecto
group by NomeProxecto
--10--
select e.Nome,x.Nome
from EMPREGADO e left join EMPREGADO x
	on e.NSSSupervisa=x.NSS