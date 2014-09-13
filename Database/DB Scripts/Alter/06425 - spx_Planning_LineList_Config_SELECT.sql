IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_LineList_Config_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_LineList_Config_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_LineList_Config_SELECT]
	@PlanningID UNIQUEIDENTIFIER
	, @AttributeLevel INT
	, @WhereExp NVARCHAR(MAX) = ''
AS
BEGIN

	CREATE TABLE #tmpAttributeList (DivisionID UNIQUEIDENTIFIER, 
								DivisionName NVARCHAR(200) COLLATE database_default, 
								StyleTypeID INT, 
								StyleTypeDescription NVARCHAR(200) COLLATE database_default,
								StyleCategoryID UNIQUEIDENTIFIER,
								StyleCategory NVARCHAR(200) COLLATE database_default,
								AttributeLevel INT, 
								IsVisible INT)


	INSERT INTO #tmpAttributeList
	EXEC spx_Planning_LinePlanningAttribute_SELECT @PlanningID
	
	SELECT attr.*, pc.PlanningConfigID, pc.LineFolderDescription, pc.LineListTypeID, pc.Days, pc.CUser, pc.CDate, pc.MUser, pc.MDate
	INTO #tmpConfig
	FROM #tmpAttributeList attr
		LEFT JOIN pPlanningLineListConfig pc ON attr.DivisionID = pc.DivisionID 
			AND (attr.StyleTypeID = pc.StyleTypeID OR attr.StyleTypeID IS NULL)
			AND (attr.StyleCategoryID = pc.StyleCategoryID OR attr.StyleTypeID IS NULL)
			AND pc.PlanningID = @PlanningID
	WHERE attr.AttributeLevel = @AttributeLevel
	ORDER BY DivisionName, StyleTypeDescription, StyleCategory

	EXEC ('SELECT * FROM #tmpConfig ' + @WhereExp)
	
	DROP TABLE #tmpConfig
	DROP TABLE #tmpAttributeList
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06425', GetDate())
GO
