IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_Planning_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_Planning_WhereUsed_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_ColorFolder_Planning_WhereUsed_SELECT]
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
	
		SELECT DISTINCT p.*
		INTO #tmp0
		FROM pPlanningColor pc		
		INNER JOIN vwx_Planning_SELECT p ON pc.PlanningID = p.PlanningID AND pc.SeasonYearID = p.SeasonYearID	
		INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 22) access ON access.ProductTypeId = p.PlanningTypeId
		INNER JOIN @SelColors SelColors ON pc.ColorPaletteID = SelColors.ColorPaletteID
		WHERE access.PermissionRoleId = 3 OR access.PermissionView = 1
		
		DECLARE @PagedSql NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql
		DROP TABLE #tmp0
		
	END
	ELSE
	BEGIN
	
		SELECT DISTINCT p.*
		INTO #tmp1
		FROM vwx_Planning_SELECT p
		INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 22) access ON access.ProductTypeId = p.PlanningTypeId
		WHERE NOT EXISTS(
			SELECT * 
			FROM @SelColors SelColors			
			LEFT JOIN pPlanningColor pc ON SelColors.ColorPaletteID = pc.ColorPaletteID AND p.PlanningID = pc.PlanningID AND p.SeasonYearID = pc.SeasonYearID
			WHERE pc.ColorPaletteID IS NULL)
		AND (access.PermissionRoleId = 3 OR access.PermissionView = 1)
		
		DECLARE @PagedSql2 NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp1', @PageNo, @PageSize, @SortOrder, @WhereClause)
		exec sp_executesql @PagedSql2
		DROP TABLE #tmp1
		
	END
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09921', GetDate())
GO
