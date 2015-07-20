IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningSeasonYearTrans_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningSeasonYearTrans_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningSeasonYearTrans_DELETE](
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
)
AS

IF(SELECT COUNT(*) FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID) > 0
BEGIN

	DECLARE @PlanningSeasonYearID UNIQUEIDENTIFIER = (SELECT PlanningSeasonYearID FROM pPlanningSeasonYear WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID)
	DELETE FROM pPlanningSeasonYear WHERE PlanningSeasonYearID = @PlanningSeasonYearID
	
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06420', GetDate())
GO
