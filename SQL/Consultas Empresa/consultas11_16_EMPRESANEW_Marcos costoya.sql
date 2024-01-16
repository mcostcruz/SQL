/*Empresa*/

use EmpresaNew

--11--
select d.NomeDepartamento, e.NOME+' '+e.APELIDO1+' '+ 
isnull (e.APELIDO2,' ') as Nombre_Completo
from DEPARTAMENTO d, EMPREGADO e
where d.NumDepartamento=e.NumDepartamentoPertenece
order by NomeDepartamento, e.Nome

--12--
select *
from EMPREGADO e, EMPREGADOFIXO em
where e.NSS=em.NSS and 
(e.Sexo='m' and e.Localidade in ('Pontevedra','Santiago','Vigo'))
or
(sexo='H' and em.Salario>3000)

--13--
select distinct e.NSS, e.Nome, e.Apelido1
from EMPREGADO e, FAMILIAR f
where e.NSS=f.NSS_empregado and
e.Localidade in ('Pontevedra','Vigo')
and e.Sexo='m'

--14--
select d.NomeDepartamento, e.NOME+' '+e.APELIDO1+' '+ 
isnull (e.APELIDO2,' ') as Nombre_Completo
from DEPARTAMENTO d,EMPREGADO e, FAMILIAR f
where d.NumDepartamento=e.NumDepartamentoPertenece and
e.NSS=f.NSS_empregado and Parentesco like 'hij_' and
d.NomeDepartamento in ('técnico','informática')

--from empregado e inner join departamento d
--	on d.NumDepartamento=e.NumDepartamentoPertenece
--inner join familiar f
-- on nss_empregado= e.nss

--15--
select top 20 percent e.*
from DEPARTAMENTO d, EMPREGADO e
where d.NumDepartamento=e.NumDepartamentoPertenece
and e.Sexo='H' and 
d.NomeDepartamento in ('informática','innovacion','estadística')

--16--
select e.*, ep.Horas, p.NomeProxecto
from EMPREGADO e, EMPREGADO_PROXECTO ep,
EMPREGADOFIXO ef, DEPARTAMENTO d, PROXECTO p
where e.NSS=ep.NSSEmpregado and e.NSS=ef.NSS
and e.NumDepartamentoPertenece= d.NomeDepartamento and
p.NumProxecto=ep.NumProxecto
and d.NomeDepartamento in ('Informática','Técnico')
and ef.Salario between 1500 and 3000 and
year(e.DataNacemento)<1980

select e.*, ep.Horas, p.NomeProxecto, ef.Salario
from EMPREGADO e inner join DEPARTAMENTO d 
	on e.NumDepartamentoPertenece= d.NumDepartamento
inner join EMPREGADOFIXO ef
on e.NSS=ef.NSS 
inner join EMPREGADO_PROXECTO ep
on e.NSS=ep.NSSEmpregado
inner join PROXECTO p
on p.NumProxecto=ep.NumProxecto
where d.NomeDepartamento in ('Informática','Técnico')
and ef.Salario between 1500 and 3000 and
year(e.DataNacemento)<1980
