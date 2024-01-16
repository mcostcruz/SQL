/*EmpresaNEW */

use EmpresaNew

--calculo de edad

--1
select DataNacemento, FLOOR(DATEDIFF(dd,datanacemento,getdate())/365.25) as edad
from EMPREGADO

--2
select DataNacemento,DATEDIFF(yy,datanacemento,getdate())-
(case 
when DATEADD(yy,DATEDIFF(yy,datanacemento,getdate()),DataNacemento)
>GETDATE() then 1
else 0 end)
from EMPREGADO

--3
select DataNacemento,DATEDIFF(yy,datanacemento,getdate())-
(case 
when MONTH(datanacemento)> MONTH(GETDATE()) then 1
when MONTH(datanacemento)> MONTH(GETDATE())
		and day(datanacemento)> day(GETDATE()) then 1
	else 0
	end)

from EMPREGADO

--4
select DataNacemento, YEAR(GETDATE()-datanacemento-1)-1900
from EMPREGADO

--25--
select Nome,Apelido1,Apelido2,d.NomeDepartamento
from EMPREGADO e inner join EMPREGADOFIXO ef
	on e.NSS=ef.NSS
	inner join DEPARTAMENTO d
	on d.NumDepartamento=e.NumDepartamentoPertenece
where Salario=(select MIN(salario)
				from EMPREGADOFIXO)

--26--
select e.NSS, e.Nome,e.Apelido1,e.Apelido2,COUNT(*) as num_hijos
from EMPREGADO e inner join FAMILIAR f
	on e.NSS=f.NSS_empregado
where Parentesco like 'hij_'
group by e.NSS,e.Nome,e.Apelido1,e.Apelido2
having SUM(YEAR(GETDATE()-f.DataNacemento-1)-1900)>40

--27--
select d.NomeDepartamento,Nome,Apelido1,Apelido2
from DEPARTAMENTO d inner join EMPREGADO e
	on d.NumDepartamento=e.NumDepartamentoPertenece
where (e.Nome like '[MJR]a%') or 
NSSSupervisa in (select NSSSupervisa
				from EMPREGADO e
	where Apelido1 like 'V_____' or Apelido2 like 'V_____' )
	
--28--
select LUGAR
from PROXECTO
where NumProxecto in ( select distinct NumProxecto
from EMPREGADO_PROXECTO ep inner join EMPREGADO e
	on ep.NSSEmpregado=e.NSS
where NumDepartamentoPertenece=1 )

--29--
select SUM(Salario)*12 as salario
from EMPREGADO  e inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
	inner join EMPREGADOFIXO ef
	on e.NSS=ef.NSS
where d.NumDepartamento=2

--30 no se puede --

--31--
select sexo, max(Salario) as maximo, AVG(Salario) as media , MIN(Salario) as minimo
from EMPREGADO  e inner join EMPREGADOFIXO ef
	on e.NSS=ef.NSS
where e.NSS not in (select NSSDirector
					from DEPARTAMENTO )
group by Sexo

--32--
select distinct p.NomeProxecto
from PROXECTO p inner join EMPREGADO_PROXECTO ep
	on p.NumProxecto=ep.NumProxecto
where exists (select Nome
			from EMPREGADO e inner join EMPREGADOFIXO ef
	on e.NSS=ef.NSS
			where Salario is null)
			
--33--
select top 1 with ties e.Nome,e.Apelido1,e.Apelido2, COUNT(Parentesco) as numero
from EMPREGADO e inner join FAMILIAR f 
	on e.NSS=f.NSS_empregado
group by e.Nome,e.Apelido1,e.Apelido2
order by numero desc

