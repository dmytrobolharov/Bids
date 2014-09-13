IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSeasonYearTrans_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSeasonYearTrans_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningSeasonYearTrans_INSERT](
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@Sort INT
)
AS

BEGIN
	DELETE FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID	
	DECLARE @PlanningSeasonYearID UNIQUEIDENTIFIER = NEWID()

	INSERT INTO pPlanningSeasonYear(PlanningSeasonYearID, SeasonYearID, PlanningID, PlanningSeason, PlanningYear, CUser, CDate, MUser, MDate, Sort)
	SELECT @PlanningSeasonYearID, @SeasonYearID, @PlanningID, Season, [Year], @CUser, @CDate, @CUser, @CDate, @Sort
	FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID 
	
END	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06980', GetDate())
GO
