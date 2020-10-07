use Movies
go
select d.DirectorName, OscNum.OscareCount
from [dbo].[tblDirector] as d
	cross apply
	
	( select count(*) as OscareCount from [dbo].[tblFilm] as f where f.[FilmOscarWins] >= 3 and f.[FilmDirectorID] = d.[DirectorID] ) OscNum
	where OscNum.OscareCount >1
	--Show the number of film N(in where clouse) per dirctor which that film has more than M(inner select) ocares!(ABOVE)

/*select d.DirectorName,f.FilmOscarWins  from [dbo].[tblFilm] as f 
	 inner join [dbo].[tblDirector] as d  
	on d.DirectorID =f.FilmDirectorID
	where f.[FilmOscarWins] > 4*/

select k.[FilmName],k.[FilmDirectorID], s.[DirectorName],k.[FilmOscarWins]
from [dbo].[tblFilm] as k inner join [dbo].[tblDirector] as s on s.[DirectorID]=k.[FilmDirectorID]
where s.[DirectorName] ='Steven Spielberg' and k.[FilmOscarWins] <> 0
order by k.[FilmOscarWins],s.[DirectorName] ASC