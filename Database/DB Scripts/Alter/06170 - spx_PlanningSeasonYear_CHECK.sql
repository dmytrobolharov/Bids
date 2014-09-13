IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSeasonYear_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSeasonYear_CHECK]
GO


CREATE PROCEDURE [dbo].[spx_PlanningSeasonYear_CHECK]
	@PlanningID UNIQUEIDENTIFIER,
	@CreatedDate DATETIME,
	@CreatedBy NVARCHAR(200)
AS 

IF (SELECT COUNT(*) FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID) = 0
BEGIN

	DECLARE @PlanningSeasonYearID UNIQUEIDENTIFIER = newid()

	INSERT INTO pPlanningSeasonYear (PlanningSeasonYearID, PlanningID, SeasonYearID, PlanningSeason, PlanningYear, CUser, CDate, MUser, MDate)
	SELECT @PlanningSeasonYearID, @PlanningId, SeasonYearID, Season, [Year], @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate 
	FROM pSeasonYear INNER JOIN
	  pPlanning ON pSeasonYear.SeasonYearID = pPlanning.IntroSeasonYearID
	WHERE PlanningID = @PlanningID
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06170', GetDate())
GO
