IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_Allocation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_Allocation_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_Allocation_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER,
	@SearchCond NVARCHAR(MAX)
AS
BEGIN
	SELECT ppi.PlanningItemID, sh.*, dbo.fnx_GetStreamingImageSmallPath(DesignSketchID, DesignSketchVersion) as designImage
	INTO #tmpPlanningItem
	FROM pPlanningItem ppi		
	INNER JOIN pStyleHeader sh ON ppi.StyleID = sh.StyleID
	WHERE ppi.PlanningID = @PlanningID
		AND sh.StyleID NOT IN (
			SELECT StyleID FROM pLineFolder lf 
			INNER JOIN pLineFolderItem lfi ON lf.LineFolderID = lfi.LineFolderID
			WHERE lf.PlanningID = @PlanningID)
		AND sh.DivisionID = (SELECT LineFolderDivisionID FROM pLineFolder WHERE LineFolderID = @LineFolderID)
		AND sh.StyleType IN (SELECT StyleTypeID FROM pLineFolderStyleType WHERE LineFolderID = @LineFolderID)
		AND sh.StyleCategory IN (SELECT StyleCategoryID FROM pLineFolderStyleCategory WHERE LineFolderID = @LineFolderID)
	
	EXEC('SELECT * FROM #tmpPlanningItem ' + @SearchCond)
	
	DROP TABLE #tmpPlanningItem	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08998', GetDate())
GO

