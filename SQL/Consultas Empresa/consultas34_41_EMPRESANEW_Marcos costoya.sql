/*Empresa 34-41*/

use EmpresaNew

--34--
select E.Nome, Apelido1,Apelido2,E.NumDepartamentoPertenece,V.Matricula,
V.Modelo
from EMPREGADO e inner join VEHICULO v
	on e.NSS=v.NSS
where v.DataCompra

--35--
select Nome,Horas,SUM(alumnos_total) as alumnos,
	MAX(alumnos_total) as max_al,
	MIN(alumnos_total) as min_al
from (select c.Nome,c.Horas,e.Numero ,COUNT(*)as alumnos_total
	from CURSO c inner join EDICION e
		on c.Codigo=e.Codigo
		inner join EDICIONCURSO_EMPREGADO ed
		on ed.Codigo=e.Codigo and ed.Numero=e.Numero
	where e.Lugar in ('Pontevedra','Vigo')
	group by c.Nome,c.Horas,e.Numero) as x
group by Nome,Horas

--36--
select provincia=
		case 
			when LEFT(CP,2)=15 then 'A coruña'
			when LEFT(CP,2)=27 then 'Lugo'
			when LEFT(CP,2)=36 then 'Pontevedra'
			ELSE 'Desconocida'
			end
			, COUNT(*) AS num_emp
from EMPREGADO
group by LEFT(CP,2)

--37--
select e.Nome+' '+e.Apelido1+' '+ISNULL(e.Apelido2,' ')as 'Nome Completo',
isnull(f.Nome+' '+f.Apelido1+' '+ISNULL(f.Apelido2,' '),' ')as 'Nome parentesco'
,Parentesco
from EMPREGADO e left join (select *
							from FAMILIAR
							where Parentesco in ('Marido','Mujer')) as F
	on e.NSS=f.NSS_empregado

--38--
select e.Nome+' '+e.Apelido1+' '+ISNULL(e.Apelido2,' ')as 'Nome Completo'
from EMPREGADO e inner join EMPREGADO_PROXECTO ep
	on e.NSS=ep.NSSEmpregado
	inner join PROXECTO p
	on p.NumProxecto=ep.NumProxecto
group by Nome,Apelido1,Apelido2
having count (distinct LUGAR)>1

--39--
select nss,LEFT(Nome,2)+SUBSTRING(Apelido1,2,2)
+LEFT(Localidade,1)+right(Localidade,1)as mote,
NomeDepartamento
into tabla
from EMPREGADO e inner join DEPARTAMENTO d
	on e.NumDepartamentoPertenece=d.NumDepartamento
	
select *
from tabla

--40--
select p.NomeProxecto,LUGAR,NSS,
e.Nome+' '+e.Apelido1+' '+ISNULL(e.Apelido2,' ')as 'Nome Completo'
from EMPREGADO e inner join PROXECTO p
	on e.Localidade=p.Lugar
where NSS not in (select NSS
					from EMPREGADO_PROXECTO ep inner join EMPREGADO e
						on e.nss=ep.NSSEmpregado
						inner join PROXECTO p
						on p.NumProxecto=ep.NumProxecto
					where LUGAR=Localidade)

select p.NomeProxecto,LUGAR,NSS,
e.Nome+' '+e.Apelido1+' '+ISNULL(e.Apelido2,' ')as 'Nome Completo'
from EMPREGADO e inner join PROXECTO p
	on e.Localidade=p.Lugar
where not exists (select *
					from EMPREGADO_PROXECTO ep inner join PROXECTO p
						on p.NumProxecto=ep.NumProxecto
					where e.NSS=NSSEmpregado and p.Lugar=e.Localidade)

--41--
select p.NomeProxecto,LUGAR,NSS,Nome_Completo,e.horas
from (select e.Nome+' '+e.Apelido1+' '+ISNULL(e.Apelido2,' ')as 'Nome_Completo'
	,NSS,Localidade,SUM(Horas) as horas
	from EMPREGADO e inner join EMPREGADO_PROXECTO ep
		on e.nss=ep.NSSEmpregado
	group by NSS,Nome,Apelido1,Apelido2,Localidade) e inner join PROXECTO p
	on Localidade=p.Lugar
where (40-e.horas)>10 and
NSS not in (select NSS
					from EMPREGADO_PROXECTO ep inner join EMPREGADO e
						on e.nss=ep.NSSEmpregado
						inner join PROXECTO p
						on p.NumProxecto=ep.NumProxecto
					where LUGAR=Localidade)


