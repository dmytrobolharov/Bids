IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_Material_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_Material_WhereUsed_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_ColorFolder_Material_WhereUsed_SELECT]
	@ColorFolderID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@WhereClause NVARCHAR(MAX),
	@SelectedColors NVARCHAR(MAX),
	@SelectMode INT = 0, /* 0 - has any, 1 - has all */
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL
AS
BEGIN
	
	DECLARE @SelColors TABLE(ColorPaletteID UNIQUEIDENTIFIER)
	INSERT INTO @SelColors(ColorPaletteID)
	SELECT value FROM dbo.fnx_Split(@SelectedColors, ',') sc
	
	IF @SelectMode = 0
	BEGIN
	
		SELECT DISTINCT m.* 
		INTO #tmp0
		FROM pMaterialColor mc
		INNER JOIN pMaterial m ON mc.MaterialID = m.MaterialID
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) amf ON amf.ProductTypeId = m.MaterialType
		INNER JOIN @SelColors SelColors ON mc.ColorPaletteID = SelColors.ColorPaletteID
		WHERE amf.PermissionRoleId = 3 OR amf.PermissionView = 1
		
		DECLARE @PagedSql NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql
		DROP TABLE #tmp0
		
	END
	ELSE
	BEGIN
	
		SELECT m.* 
		INTO #tmp1
		FROM pMaterial m
		INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) amf ON amf.ProductTypeId = m.MaterialType
		WHERE NOT EXISTS(
			SELECT * 
			FROM @SelColors SelColors			
			LEFT JOIN pMaterialColor mc ON SelColors.ColorPaletteID = mc.ColorPaletteID AND mc.MaterialID = m.MaterialID
			WHERE mc.ColorPaletteID IS NULL)
		AND (amf.PermissionRoleId = 3 OR amf.PermissionView = 1)
		
		DECLARE @PagedSql2 NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp1', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql2
		DROP TABLE #tmp1
		
	END
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09920', GetDate())
GO
