IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_Marker_GetPathCADCategories]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_Marker_GetPathCADCategories]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Style_Marker_GetPathCADCategories]
	@CADDB varchar(50),
	@Catalog varchar(50),
	@CADCatId int
AS

DECLARE @sql nvarchar(1000)

BEGIN

SELECT @sql = '
	WITH Paths ([CADCatId], [Name], [ParentId], [Level], [FullPath]) AS ' +
	'(' +
		'SELECT ' +
		'A.CADCatId, A.Name, A.ParentId, ' +
		'1 AS [Level], ' +
		'CAST (A.Name AS VARCHAR(500)) AS [FullPath] ' +
		'FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Cats A ' +
		'WHERE A.Level1 = 1 AND A.ParentId = 1 ' +
	'UNION ALL ' +
		'SELECT ' +
		'B.CADCatId, B.Name, B.ParentId, ' +
		'P.[Level] + 1 AS [Level], ' +
		'CASE RIGHT(P.[FullPath], 1) ' +
		'WHEN ''\'' THEN CAST(P.[FullPath] + B.[Name] AS VARCHAR(500)) ' +
		'ELSE CAST(P.[FullPath] + ''\'' + B.[Name] AS VARCHAR(500)) ' +
		'END AS [FullPath] ' +
		'FROM ' + @CADDB + '.' + @Catalog + '.dbo.Cad_Cats B ' +
		'INNER JOIN Paths P ON P.CADCatId = B.ParentId ' +
		'WHERE B.Level1 <> 1 ' +
	') ' +
	
	'SELECT [FullPath] FROM Paths WHERE CADCatId = ' + CAST(@CADCatId AS varchar(5))

	exec(@sql)

END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02584'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02584', GetDate())
END
GO