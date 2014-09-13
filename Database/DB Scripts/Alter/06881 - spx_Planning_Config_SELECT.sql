IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Config_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Config_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Planning_Config_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
	, @WhereExp NVARCHAR(MAX) = ''
AS
BEGIN

	CREATE TABLE #tmpAttributeList (BrandID UNIQUEIDENTIFIER, 
								Brand NVARCHAR(200) COLLATE database_default, 
								DivisionID UNIQUEIDENTIFIER, 
								DivisionName NVARCHAR(200) COLLATE database_default, 
								StyleTypeID INT, 
								StyleTypeDescription NVARCHAR(200) COLLATE database_default,
								StyleCategoryID UNIQUEIDENTIFIER,
								StyleCategory NVARCHAR(200) COLLATE database_default,
								AttributeLevel INT, 
								IsVisible INT,
								SubCategoryID UNIQUEIDENTIFIER,
								SubCategory NVARCHAR(200) COLLATE database_default,
								SubCategoriesCount INT
								)


	INSERT INTO #tmpAttributeList
	EXEC spx_Planning_LinePlanningAttribute_WithSubCategory_SELECT @PlanningID, @SeasonYearID
	
	SELECT attr.*, pc.PlanningConfigID, pc.Description, pc.WorkflowTemplateID, pc.SizeClass, pc.SizeRange, 
		pc.Status, pc.StyleThemeID, pc.CUser, pc.CDate, pc.MUser, pc.MDate
	INTO #tmpConfig
	FROM #tmpAttributeList attr
		LEFT JOIN pPlanningConfig pc ON attr.DivisionID = pc.DivisionID 
			AND attr.StyleTypeID = pc.StyleTypeID
			AND attr.StyleCategoryID = pc.StyleCategoryID
			AND ISNULL(attr.SubCategoryID,'00000000-0000-0000-0000-000000000000') = ISNULL(pc.SubCategoryID, '00000000-0000-0000-0000-000000000000')
			AND pc.PlanningID = @PlanningID
			AND pc.SeasonYearID = @SeasonYearID
	WHERE attr.DivisionID IS NOT NULL AND attr.StyleTypeID IS NOT NULL AND attr.StyleCategoryID IS NOT NULL
	ORDER BY DivisionName, StyleTypeDescription, StyleCategory

	EXEC ('SELECT * FROM #tmpConfig ' + @WhereExp)
	
	DROP TABLE #tmpConfig
	DROP TABLE #tmpAttributeList
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06881', GetDate())
GO
