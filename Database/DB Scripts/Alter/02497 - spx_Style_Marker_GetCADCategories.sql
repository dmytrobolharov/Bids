IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_GetCADCategories]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Marker_GetCADCategories]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_Style_Marker_GetCADCategories]
	@CADDB varchar(50),
	@Catalog varchar(50)
AS

DECLARE @sql nvarchar(1000)

BEGIN

SELECT @sql = '
	WITH Sub_Cad_Cats ([CADCatId], [ParentId], [Name], [Level], [Sort]) AS ' +
	'(' +
		'SELECT A.CADCatId, NULL, A.Name, 0, ' +
		'CONVERT(nvarchar(max), right(REPLICATE(' + '''0''' + ',10 - LEN(cast(A.CADCatId as nvarchar(10)))) + cast(A.CADCatId as nvarchar(10)), 10)) ' +
		'FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Cats A ' +
		'WHERE A.Level1 = 1 ' +
	'UNION ALL ' +
		'SELECT B.CADCatId, B.ParentId, B.Name, C.[Level] + 1, ' +
		'CONVERT (nvarchar(max), RTRIM(Sort) + ' + '''| ''' + ' + right(REPLICATE(' + '''0''' + ',10 - LEN(cast(B.CADCatId as nvarchar(10)))) + cast(B.CADCatId as nvarchar(10)), 10)) ' +
		'FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Cats B ' +
		'INNER JOIN Sub_Cad_Cats C ON B.ParentId = C.CADCatId ' +
		'WHERE B.Level1 <> 1 ' +
	')' +

	'SELECT [CADCatId], [ParentId], REPLICATE('+ '''&nbsp;''' + ',8*[Level]) + [Name] as [Name], [Level], [Sort] FROM Sub_Cad_Cats ' +
	'ORDER BY [Sort]'
	
	exec(@sql)

END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02497'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02497', GetDate())
END
GO