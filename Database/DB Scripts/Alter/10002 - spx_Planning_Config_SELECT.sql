IF OBJECT_ID(N'[dbo].[spx_Planning_Config_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_Planning_Config_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Config_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@WhereExp NVARCHAR(MAX) = '',
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL
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
								SubCategory NVARCHAR(200) COLLATE database_default
								)


	INSERT INTO #tmpAttributeList
	EXEC spx_Planning_LinePlanningAttribute_WithSubCategory_ALL_SELECT @PlanningID, @SeasonYearID
	
	SELECT attr.*, pc.PlanningConfigID, pc.Description, pc.WorkflowTemplateID, pc.SizeClassId, pc.SizeRangeId, 
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
	DECLARE @sqlString  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmpConfig',@PageNo,@PageSize,@SortOrder, @WhereExp)
	exec sp_executesql @sqlString
	DROP TABLE #tmpConfig
	DROP TABLE #tmpAttributeList

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10002', GetUTCDate())
GO
