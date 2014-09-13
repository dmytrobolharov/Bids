IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSeasonYear_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSeasonYear_SELECTED]
GO

CREATE PROCEDURE [dbo].[spx_PlanningSeasonYear_SELECTED]  (
	@PlanningID UNIQUEIDENTIFIER
)
AS 

SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear 
FROM pPlanningSeasonYear a
	INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
WHERE PlanningID = @PlanningID
ORDER BY a.Sort --b.CurrentSeason DESC, b.Year DESC, b.Season
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06177', GetDate())
GO
