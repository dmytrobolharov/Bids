IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_DELETE]
	@PlanningItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pLineFolderItemColor
	WHERE LineFolderItemID IN (
		SELECT lfi.LineFolderItemID FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pLineFolder lf ON pli.PlanningID = lf.PlanningID AND ssy.SeasonYearID = lf.SeasonYearID
		INNER JOIN pLineFolderItem lfi ON lf.LineFolderID = lfi.LineFolderID
		WHERE lfi.StyleID = pli.StyleID AND pli.PlanningItemID = @PlanningItemID)
		
	DELETE FROM pLineFolderItem
	WHERE LineFolderItemID IN (
		SELECT lfi.LineFolderItemID FROM pPlanningItem pli
		INNER JOIN pStyleSeasonYear ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pLineFolder lf ON pli.PlanningID = lf.PlanningID AND ssy.SeasonYearID = lf.SeasonYearID
		INNER JOIN pLineFolderItem lfi ON lf.LineFolderID = lfi.LineFolderID
		WHERE lfi.StyleID = pli.StyleID AND pli.PlanningItemID = @PlanningItemID)
	
	DELETE FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID	
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07636', GetDate())
GO
