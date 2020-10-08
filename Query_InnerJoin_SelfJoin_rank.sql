/*use Movies

Select
	f.FilmName
	,d.DirectorName
	,s.StudioName
	,c.CountryName
from
	[dbo].[tblFilm] as f
	inner join [dbo].[tblDirector] as d
		on f.FilmDirectorID =d.DirectorID
	inner join [dbo].[tblStudio] as s
		on f.FilmStudioID = s.StudioID
	inner join [dbo].[tblCountry] as c
		on f.FilmCountryID=c.CountryID
-----------------------------------------------
use Movies
select
	d.DirectorID
	,d.DirectorName
	,f.FilmName
	,f.FilmDirectorID
from 
	[dbo].[tblDirector] as d
	left outer join [dbo].[tblFilm] as f
		on d.DirectorID=f.FilmDirectorID

where 
	f.FilmID is null
-----------------------------------------------------------
Use Movies
select	
	[FilmName]
	,[FilmOscarWins]
	,[FilmName] + 'won ' + CONVERT(char,[FilmOscarWins]) 
	
from
	[dbo].[tblFilm]
-----------------------------------------------------------
Use Movies
select
		ActorName
		,Left([ActorName],Charindex(' ',[ActorName])-1) as a
		,RIGHT([ActorName],len([ActorName])-Charindex(' ',[ActorName])) as b
		
from
		[dbo].[tblActor]

------------------------------------------------------------------
Use Movies
select	
	[FilmName]
	,[FilmReleaseDate]
	,CONVERT(char(8),[FilmReleaseDate],1)
	,Datename(dw,[FilmReleaseDate]) as k
	
from
	[dbo].[tblFilm]
where 
			Datename(dw,[FilmReleaseDate])='Monday'

---------------------------------------------------------------	
Use Movies
select	
	
	isnull(CountryName,'TOTAL'),
	AVG(FilmRunTimeMinutes) as AVG,
	sum(FilmRunTimeMinutes)as SUM ,
	min(FilmRunTimeMinutes) as MIN,
	max(FilmRunTimeMinutes) as MAX,
	count(CountryName) as 'Count'	
from
	[dbo].[tblFilm]	as f
	inner join [dbo].[tblCountry] as c
	on f.FilmCountryID=c.CountryID

GROUP BY 
	CountryName with rollup
having 
	min(FilmRunTimeMinutes) >= 100
order by
	[CountryName] ASC*/
-------------------------------------------------------

Use Movies
select	
	[FilmName]
	,[FilmRunTimeMinutes]
	,avg([FilmRunTimeMinutes]) over() AVERAGE  --Create a column named Average that shows the avarage value
from
	[dbo].[tblFilm] as f 

--------------------------------------------------------------
Use Movies
select	
	[FilmName]
	,[FilmRunTimeMinutes]
	,year(f.FilmReleaseDate) as ReleaseYear
from
	[dbo].[tblFilm] as f 
where
	[FilmRunTimeMinutes] >=
	(
		select avg(FilmRunTimeMinutes)
		from [dbo].[tblFilm] as g
		where year(g.FilmReleaseDate) = year(f.FilmReleaseDate)
	)
order by ReleaseYear
--------------------------------------------------------------
use Movies
	select
	c.CountryName
	,f.FilmName
	,f.FilmRunTimeMinutes
	,f.FilmCountryID as ID

	from [dbo].[tblFilm] as f inner join [dbo].[tblCountry] as c
		 on f.FilmCountryID =c.CountryID
	where
		f.FilmRunTimeMinutes = ( select	MAX([FilmRunTimeMinutes])	
								 from tblFilm as g
								 where g.FilmCountryID=f.FilmCountryID)
---------------------------------------------------------------
use Movies
	select
	c.CountryName
	,f.FilmCountryID
	,max(f.FilmRunTimeMinutes) as FilmRunTimeMinutes	

	from [dbo].[tblFilm] as f inner join [dbo].[tblCountry] as c
		 on f.FilmCountryID =c.CountryID	
	
	group by c.CountryName,f.FilmCountryID;
-------------------------------------------------------------	
use Movies
	select * 
	from(
	select
		c.CountryName
		,f.FilmName
		,f.FilmRunTimeMinutes
		,f.FilmCountryID as ID
		,rank() over( ORDER BY f.FilmCountryID DESC) rank  --The RANK() function is a window function that assigns a rank to each row within a partition of a result set.

	from [dbo].[tblFilm] as f inner join [dbo].[tblCountry] as c
		 on f.FilmCountryID =c.CountryID ) kkk	
where rank = 2
---------------------------------------------------------------
	