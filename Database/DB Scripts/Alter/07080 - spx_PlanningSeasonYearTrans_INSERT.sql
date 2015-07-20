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
	
	IF NOT EXISTS (SELECT * FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID)
	BEGIN
		DECLARE @PlanningSeasonYearID UNIQUEIDENTIFIER = NEWID()
	
		INSERT INTO pPlanningSeasonYear(PlanningSeasonYearID, SeasonYearID, PlanningID, PlanningSeason, PlanningYear, CUser, CDate, MUser, MDate, Sort)
		SELECT @PlanningSeasonYearID, @SeasonYearID, @PlanningID, Season, [Year], @CUser, @CDate, @CUser, @CDate, @Sort
		FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID 
		
		DECLARE @PrevSeasonOrder INT
		SELECT TOP 1 @PrevSeasonOrder = Sort FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID AND SeasonYearID <> @SeasonYearID ORDER BY Sort DESC
		
		DECLARE @PrevSeasonYearID UNIQUEIDENTIFIER
		SELECT @PrevSeasonYearID = SeasonYearID FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID AND Sort = @PrevSeasonOrder
		
		IF EXISTS (SELECT * FROM pPlanningLineListConfig WHERE PlanningID = @PlanningID AND SeasonYearID = @PrevSeasonYearID)
		BEGIN
			INSERT INTO pPlanningLineListConfig (PlanningConfigID, PlanningID, DivisionID, StyleTypeID, StyleCategoryID, 
				LineFolderDescription, LineListTypeID, Days, CUser, CDate, MUser, MDate, SeasonYearID)
			SELECT NEWID(), @PlanningID, DivisionID, StyleTypeID, StyleCategoryID,
				LineFolderDescription, LineListTypeID, Days, @CUser, @CDate, @CUser, @CDate, @SeasonYearID
			FROM pPlanningLineListConfig 
			WHERE PlanningID = @PlanningID AND SeasonYearID = @PrevSeasonYearID
		END
	END
	ELSE
	BEGIN
		UPDATE pPlanningSeasonYear SET Sort = @Sort WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
	END
	
END	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07080', GetDate())
GO
