--selct the student information, in case who has LandLine(L) and cellphone(M) number, only cellphone num shows up
use Students

select s.Name,s.DOB,C.ConType,C.ContactNo,C.id
  into #tmtaa
from Stu s inner join Countact c on s.id=C.Stuid


select x.* from #tmtaa as x

select distinct t.Name,t.DOB,t.ContactNo,t.id,t.ConType
from #tmtaa as t
join(
	select Name
	from #tmtaa
	group by Name
	having  (count(distinct ConType) >1)
	)as y
	on t.name = y.name where t.ConType='M'
	
	union
	
	select distinct t.Name,t.DOB,t.ContactNo,t.id,t.ConType
	from #tmtaa as t
	join(
	select Name
	from #tmtaa
	group by Name
	having  (count(distinct ConType) =1)
	)as y
	on t.name = y.name 
	








