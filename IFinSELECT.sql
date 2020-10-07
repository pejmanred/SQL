use Movies
go
alter proc spIF(@nf int)
as 
begin
	print @nf 
	--Select statement will run onlt 110 enter!
	if @nf > 110
		begin	
		print 'It is grater then 110'
		print 'Pejman'
		end
	if @nf = 110	
		begin
			exec(N'
				with mye as
				(
					select [FilmName],[FilmLanguageID],[FilmRunTimeMinutes] from [dbo].[tblFilm]
					where [FilmOscarNominations]>3
				)
				select  top 10 * from mye where [FilmRunTimeMinutes] >120 ')
		end
	if @nf < 110	
		print'It is short'
end

--exec spIF 110