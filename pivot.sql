select [Name],max([Name]) as bahbah from [dbo].[Occup] group by Name 


SELECT *
FROM
(
SELECT [Name], [Occupation] 
FROM [dbo].[Occup]
) AS source

PIVOT
(
    max([Name])
    FOR [occupation] IN ([eng],[nur], [lawyer]) 
) as pvt;