/*EmpresaNEW Group by*/

use EmpresaNew

--17--
select SUM(Salario) as Suma , AVG(Salario) as Media
from EMPREGADOFIXO

--18--
select d.NomeDepartamento, COUNT(*) as numero, AVG(salario)as media
from EMPREGADOFIXO ef inner join EMPREGADO e
	on ef.NSS=e.NSS
	inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
group by d.NomeDepartamento

--19--
select year (DataNacemento) as año,COUNT(*) as Numero
from EMPREGADO
where year (DataNacemento)>1969
group by year (DataNacemento)

--20--
select case sexo
	when 'H' then 'O número de homes é'
	when 'M' then 'O número de mulleres é'
	end as Sexo
	, COUNT(distinct NSS) Empregados
from EMPREGADO
group by SEXO

--21--
select case sexo
	when 'H' then 'O número de empregados fixos de sexo masculino son'
	when 'M' then 'O número de empregados fixos de sexo femenino son'
	end as Sexo
	, COUNT(distinct ef.NSS) Empregados
from EMPREGADOFIXO ef inner join EMPREGADO e
	on ef.NSS=e.NSS
group by SEXO
union
select case sexo
	when 'H' then 'O número de empregados temporais de sexo masculino son'
	when 'M' then 'O número de empregados temporais de sexo femenino son'
	end as Sexo
	, COUNT(distinct et.NSS) Empregados
from EMPREGADOTEMPORAL et inner join EMPREGADO e
	on et.NSS=e.NSS
group by SEXO

--22--
select e.NOME+' '+e.APELIDO1+' '+ isnull (e.APELIDO2,' ') as Nombre_Completo
from EMPREGADO e inner join FAMILIAR f
	on e.NSS=f.NSS_empregado
where f.Parentesco like 'hij%' 
group by e.Nome,e.Apelido1,e.Apelido2
having count(*)>1

--23--
select distinct e.NOME+' '+e.APELIDO1+' '+ isnull (e.APELIDO2,' ') as Nombre_Completo,
SUM(p.Horas) as horas
from EMPREGADO e inner join EMPREGADO_PROXECTO p
	on e.NSS=p.NSSEmpregado
group by e.Nome,e.Apelido1,e.Apelido2

--24--
select distinct e.NOME+' '+e.APELIDO1+' '+ isnull (e.APELIDO2,' ') as Nombre_Completo,
SUM(p.Horas) as horas,
case
	when SUM(p.Horas)>40 then SUM(p.Horas)-40
	else SUM(p.Horas) 
	end AS Sobrecarga
from EMPREGADO e inner join EMPREGADO_PROXECTO p
	on e.NSS=p.NSSEmpregado
group by e.Nome,e.Apelido1,e.Apelido2
having SUM(p.Horas)>40