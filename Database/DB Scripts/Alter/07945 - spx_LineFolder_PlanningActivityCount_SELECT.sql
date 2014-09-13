IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_PlanningActivityCount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_PlanningActivityCount_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolder_PlanningActivityCount_SELECT]
(
	@LineFolderID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
)
AS
BEGIN

	DECLARE @PlanningID UNIQUEIDENTIFIER,
			@SeasonYearID UNIQUEIDENTIFIER

	SELECT @PlanningID = PlanningID, @SeasonYearID = SeasonYearID
	FROM pLineFolder WHERE LineFolderID = @LineFolderID
	
	SELECT COUNT(*)
	FROM pPlanningActivity pa
		INNER JOIN pPlanningActivityType pat ON pa.PlanningActivityTypeID = pat.PlanningActivityTypeID
		LEFT JOIN pPlanningActivityView pav ON pa.PlanningActivityID = pav.PlanningActivityID AND pav.TeamID = @TeamID
	WHERE pa.PlanningID = @PlanningID AND pa.SeasonYearID = @SeasonYearID AND pav.TeamID IS NULL
		AND (pa.StyleID IN (SELECT StyleID FROM pLineFolderItem WHERE LineFolderID = @LineFolderID) OR pa.StyleID = '00000000-0000-0000-0000-000000000000')

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07945', GetDate())
GO
