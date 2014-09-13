IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSeasonYear_COMPARE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSeasonYear_COMPARE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningSeasonYear_COMPARE]  (
	@PlanningID UNIQUEIDENTIFIER, 
	@SeasonYearID UNIQUEIDENTIFIER
)
AS 

SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear 
FROM pPlanningSeasonYear a
	INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
WHERE PlanningID = @PlanningID AND a.SeasonYearID <> @SeasonYearID
ORDER BY a.Sort
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07155', GetDate())
GO
