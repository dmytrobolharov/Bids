/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_Planning_WhereUsed_SELECT]    Script Date: 06/04/2014 15:56:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_Planning_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_Planning_WhereUsed_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_Planning_WhereUsed_SELECT]    Script Date: 06/04/2014 15:56:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_ColorFolder_Planning_WhereUsed_SELECT]
	@ColorFolderID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@WhereClause NVARCHAR(MAX),
	@SelectedColors NVARCHAR(MAX),
	@SelectMode INT = 0 /* 0 - has any, 1 - has all */
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
		
		EXEC('SELECT * FROM #tmp0 ' + @WhereClause)
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
		
		EXEC('SELECT * FROM #tmp1 ' + @WhereClause)
		DROP TABLE #tmp1
		
	END
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07859', GetDate())
GO