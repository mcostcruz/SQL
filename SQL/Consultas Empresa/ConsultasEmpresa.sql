/*Consultas Empresa*/

use EmpresaNew
--1--
select *
from EMPREGADO
where Sexo='M' and Localidade in ('Pontevedra',
'Vigo','Santiago')

--2--
select Nome,DataNacemento, 
--datediff (year,DataNacemento,GETDATE()) AS EDAD 
from FAMILIAR 
where Parentesco like 'hij_'
--order by SEXO, datediff (year,DataNacemento,GETDATE())
order by Parentesco desc, DataNacemento
--3--
select top 2 with ties Nome, Horas
from CURSO
order by Horas DESC

--4--
select distinct Lugar
from PROXECTO
order by LUGAR

--5--
select *
from TAREFA
where estado not like 'FINALIZADA'

--6--
select NOME+' '+APELIDO1+' '+ 
isnull (APELIDO2,' ' ) as Nombre_Completo,
NSS
from EMPREGADO
where NSSSupervisa is not null and 
Localidade in ('Lugo','Monforte') and
(datepart(yy,DataNacemento)>=1970 and 
datepart(yy,DataNacemento)<=1990)

--7--
select Localidade,
case
	when Localidade='Lugo' then 'lucense'
	when Localidade='Pontevedra' then 'pontevedrés'
	when Localidade='Vigo' then 'vigués'
	when Localidade='Santiago' then 'compostelano'
	when Localidade='Monforte' then 'monfortino'
	else 'Otro'
end as Gentilicio
from EMPREGADO

--8--
select *,
case
	when Localidade='Lugo'and sexo='H' then 'lucense'
	when Localidade='Lugo'and sexo='M' then 'lucense'
	when Localidade='Pontevedra' and sexo='H' then 'pontevedrés'
	when Localidade='Pontevedra' and sexo='M' then 'pontevedrésa'
	when Localidade='Vigo' and sexo='H' then 'vigués'
	when Localidade='Vigo' and sexo='M' then 'viguésa'
	when Localidade='Santiago' and sexo='H' then 'compostelano'
	when Localidade='Santiago' and sexo='M' then 'compostelana'
	when Localidade='Monforte' and sexo='H' then 'monfortino'
	when Localidade='Monforte' and sexo='M' then 'monfortina'
	else 'Otro'
end as Gentilicio
from EMPREGADO

--9--
select NOME+' '+APELIDO1+' '+ 
isnull (APELIDO2,' ' ) as Nombre_Completo,
DATENAME(dw,DataNacemento)+', '+
DATENAME(dd,DataNacemento)+' de '+DATENAME(mm,DataNacemento)+
' de '+DATENAME(YY,DataNacemento) as Datanacemento
from EMPREGADO

--10--
select NOME+' '+isnull (APELIDO1,' ' )+' '+ 
isnull (APELIDO2,' ' ) as Nombre_Completo
from FAMILIAR
where Apelido1 not like '____%' or Apelido2 not like '____%'
--len (Apelido1)<5 or len (Apelido2)<5
order by Apelido1, Apelido2

--Adicional--
