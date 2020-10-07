---select CountryName, count(FilmID) as [numberoffilms]
---from [dbo].[tblCountry] as c inner join [dbo].[tblFilm] as f on c.CountryID=f.FilmCountryID
---group by CountryName

go

Declare @ColumnName nvarchar(max)=''
select @ColumnName += QUOTENAME(CountryName) + ',' from [tblCountry]
set @ColumnName=left(@ColumnName,len(@ColumnName)-1)
print @ColumnName

Declare @SQL nvarchar(max)=''
set @SQL=
'select * from
	(select c.CountryName, f.FilmID,year(FilmReleaseDate) as [film Year] 
		from [dbo].[tblCountry] as c inner join [dbo].[tblFilm] as f  on c.CountryID=f.FilmCountryID
	) as BasseDate
	Pivot(
			count(FilmID) 
			for CountryName in ('+@ColumnName+') --[China],[Japan],[France],[New Zealand],[Russia],[United Kingdom],[United States],[Germany]
			)as PivotTable order by [film Year]  DESC'

print @SQL
exec sp_executesql @SQL								