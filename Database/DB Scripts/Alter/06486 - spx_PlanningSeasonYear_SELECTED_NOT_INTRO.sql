/****** Object:  StoredProcedure [dbo].[spx_PlanningSeasonYear_SELECTED_NOT_INTRO]    Script Date: 10/24/2013 13:22:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSeasonYear_SELECTED_NOT_INTRO]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSeasonYear_SELECTED_NOT_INTRO]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_PlanningSeasonYear_SELECTED_NOT_INTRO]  (
	@PlanningID UNIQUEIDENTIFIER
)
AS

SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear 
FROM pPlanningSeasonYear a
	INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
WHERE PlanningID = @PlanningID and b.SeasonYearID NOT IN (SELECT IntroSeasonYearID FROM pPlanning WHERE PlanningID = @PlanningID)
ORDER BY a.Sort


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06486', GetDate())
GO