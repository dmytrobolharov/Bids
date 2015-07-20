IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_DevelopmentTracker_MismatchingBOM_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_DevelopmentTracker_MismatchingBOM_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_DevelopmentTracker_MismatchingBOM_SELECT]
(
	@PlanningID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @TeamID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT DISTINCT pli.PlanningItemID
	FROM vwx_PlanningItem_SELECT pli
		INNER JOIN pLineFolder lf ON pli.PlanningID = lf.PlanningID AND pli.SeasonYearID = lf.SeasonYearID
		INNER JOIN pLineFolderItem lfi ON lf.LineFolderID = lfi.LineFolderID AND pli.StyleSeasonYearID = lfi.StyleSeasonYearID
	WHERE
		pli.TeamId = @TeamID
		AND pli.PlanningID = @PlanningID
		AND pli.SeasonYearID = @SeasonYearID
		AND pli.PlanningItemDrop = 'No'
		AND pli.StyleBOMDimensionID != lfi.StyleBOMDimensionID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08361', GetDate())
GO
