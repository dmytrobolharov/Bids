IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Image_Color_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Image_Color_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Image_Color_WhereUsed_SELECT]
(
	@ImageID UNIQUEIDENTIFIER
	, @TeamID UNIQUEIDENTIFIER
	, @WhereClause NVARCHAR(MAX)
)
AS
BEGIN
	SELECT cpg.*, cp.ImageID, cp.ImageVersion
	INTO #tmp0
	FROM vwx_ColorPalette_Grid_SEL cpg
	INNER JOIN pColorPalette cp on cp.ColorPaletteID = cpg.ColorPaletteID
	INNER JOIN pColorFolder cf ON cp.ColorFolderID = cf.ColorFolderID
	INNER JOIN dbo.fnx_Permissions_GetIntProductTypePermissions(@TeamID, 7) PERM ON 
		cf.ColorTypeID = PERM.ProductTypeId
	WHERE (PermissionRoleID = 3 OR PermissionView = 1)
		AND cp.ImageID = @ImageID

	EXEC ('SELECT * FROM #tmp0 ' + @WhereClause)

	DROP TABLE #tmp0
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09346', GetDate())
GO
