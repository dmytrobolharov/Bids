IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_MismatchingBOM_List_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_MismatchingBOM_List_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_MismatchingBOM_List_SELECT]
	  @PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
AS

SELECT DISTINCT pli.PlanningItemID, lfi.StyleBOMDimensionID 
FROM pLineFolderItem lfi
INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID
INNER JOIN pPlanningItem pli ON lf.PlanningID = pli.PlanningID
		AND lfi.StyleSeasonYearID = pli.StyleSeasonYearID
INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
WHERE lfi.StyleBOMDimensionID <> pli.StyleBOMDimensionID
	AND pli.PlanningID = @PlanningID AND ssy.SeasonYearID = @SeasonYearID
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08466', GetDate())
GO
