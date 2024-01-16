/*EmpresaNew 48-55*/

use EmpresaNew

--48--
select *
from EMPREGADO as Empleado
for xml auto,type

--49--
select *
from EMPREGADO
for xml raw('Persona'),type

--50--
select NumProxecto as num_proyecto,NomeProxecto as nombre_proxecto
,NomeDepartamento as nombre_departamento
from PROXECTO p inner join DEPARTAMENTO d
	on p.NumDepartControla=d.NumDepartamento
for xml auto,type

--51--
select NumProxecto as num_proyecto,NomeProxecto as nombre_proxecto
,NomeDepartamento as nombre_departamento
from PROXECTO p inner join DEPARTAMENTO d
	on p.NumDepartControla=d.NumDepartamento
for xml raw,elements

--52--
select NumProxecto as num_proyecto,NomeProxecto as nombre_proxecto
,NomeDepartamento as nombre_departamento
from PROXECTO p inner join DEPARTAMENTO d
	on p.NumDepartControla=d.NumDepartamento
for xml raw(''),elements

--53--
select NomeDepartamento as nombre_departamento,
NSS,Nome+' '+Apelido1+' '+ISNULL(Apelido2,' ')as 'Nome'
from DEPARTAMENTO d inner join EMPREGADO Director
	on d.NSSDirector=NSS
for xml auto,elements

--54--
select d.NomeDepartamento as departamento_nombre, COUNT(*) as num_empregados
from DEPARTAMENTO d inner join EMPREGADO e
	on d.NumDepartamento=e.NumDepartamentoPertenece
group by d.NomeDepartamento
for xml auto,type

--55--
select NomeDepartamento as nombre, COUNT(*) as num_empregados
from DEPARTAMENTO Contador inner join EMPREGADO e
	on NumDepartamento=e.NumDepartamentoPertenece
group by NomeDepartamento
for xml auto,elements