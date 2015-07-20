IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSeasonYear_AVAILABLE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSeasonYear_AVAILABLE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningSeasonYear_AVAILABLE]
	@PlanningID UNIQUEIDENTIFIER
AS 

BEGIN

	SELECT  SeasonYearID , [Season] + ' ' + [Year] AS SeasonYear FROM  pSeasonYear 
	WHERE SeasonYearID NOT IN (SELECT SeasonYearID FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID) AND Active = 1
	ORDER BY Sort

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06419', GetDate())
GO
