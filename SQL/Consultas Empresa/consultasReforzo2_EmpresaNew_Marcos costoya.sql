/*Consultas Refuerzo2*/

use EmpresaNew

--1--
select NumDepartamento,COUNT(*) as numero
from EMPREGADO e inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
where NumDepartamento in (select NumDepartamento
							from DEPARTAMENTO d inner join PROXECTO p
								on p.NumDepartControla=d.NumDepartamento
							group by NumDepartamento
							having COUNT(*)>2)
group by NumDepartamento

--2--
select AVG (numero)
from DEPARTAMENTO d left join
	(select NumDepartamento,COUNT(*) as numero
	from EMPREGADO e inner join DEPARTAMENTO d
		on e.NumDepartamentoPertenece=d.NumDepartamento
	group by NumDepartamento) as numeros
on d.NumDepartamento=numeros.NumDepartamento

select *
from DEPARTAMENTO d inner join PROXECTO p
	on d.NumDepartamento=p.NumDepartControla

--3--
select NumDepartControla,COUNT(distinct p.NumProxecto)as numero
from DEPARTAMENTO d inner join PROXECTO p
	on p.NumDepartControla=d.NumDepartamento
	inner join EMPREGADO e
	on e.NumDepartamentoPertenece=d.NumDepartamento
where e.NSS in (select e.NSS
				from EMPREGADO e inner join FAMILIAR f
				on f.NSS_empregado=e.NSS
				group by e.NSS
				having COUNT(Parentesco)<3)and
NumDepartamento in (select NumDepartamento
					from DEPARTAMENTO d inner join EMPREGADO e
					on e.NumDepartamentoPertenece=d.NumDepartamento
					group by NumDepartamento
					having COUNT(NSS)>1)
group by NumDepartControla

--4--
select Sexo,COUNT(*)
from EMPREGADO e inner join 
		(select nss,YEAR (GETDATE()-DataNacemento-1)-1900 as año
		from EMPREGADO) as ano
		on e.NSS=ano.NSS
where año between 40 and 50
group by Sexo

--5--
select AVG (edad.años)
from DEPARTAMENTO d left join (select NSSDirector,YEAR (GETDATE()-DataNacemento-1)-1900 as años
								from DEPARTAMENTO d left join EMPREGADO e
									on e.NSS=d.NSSDirector) as edad
	on d.NSSDirector=edad.NSSDirector
where exists
			(select NumDepartamento,COUNT(*) as numero
				from EMPREGADO e
				where NumDepartamentoPertenece=d.NumDepartamento
				group by NumDepartamento
				having COUNT(*)>4)

--6--
select pr.NumProxecto,pr.NomeProxecto,d.NomeDepartamento,numero.empregados
from DEPARTAMENTO d inner join PROXECTO pr
	on d.NumDepartamento=pr.NumDepartControla
	inner join (select pr.NumProxecto , COUNT(*)as empregados
				from EMPREGADO_PROXECTO ep inner join PROXECTO pr
					on pr.NumProxecto=ep.NumProxecto
				group by pr.NumProxecto) as numero
	on pr.NumProxecto=numero.NumProxecto
where pr.NomeProxecto in (select top 1 p.numProxecto,COUNT(*) as problemas
				from PROXECTO pr inner join PROBLEMA p
					on pr.NumProxecto=p.numProxecto
				group by p.numProxecto
				order by problemas desc)

