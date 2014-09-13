IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_PlanningValues_Import_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_PlanningValues_Import_SeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_PlanningValues_Import_SeasonYear_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT * 
	FROM pPlanningSeasonYear psy
	INNER JOIN vwx_SeasonYear_SEL sy ON psy.SeasonYearID = sy.SeasonYearID
	WHERE psy.PlanningID = @PlanningID AND psy.SeasonYearID <> @SeasonYearID
	ORDER BY sy.Sort
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06428', GetDate())
GO
