IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_TACalendar_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_TACalendar_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_TACalendar_INSERT]
	@TACalTemplateID UNIQUEIDENTIFIER,
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS


IF NOT EXISTS(
	SELECT * FROM pPlanningTACalendar 
	WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID 
		AND TACalTemplateID = @TACalTemplateID)
BEGIN

	DECLARE @Sort NVARCHAR(5)
	SELECT @Sort = RIGHT('00000' + CAST(ISNULL(MAX(CAST(Sort AS INT)), 1) AS NVARCHAR(5)), 5)
	FROM pPlanningTACalendar 
	WHERE PlanningID = @PlanningID AND SeasonYearID = @SeasonYearID
		AND ISNUMERIC(Sort) = 1

	INSERT INTO pPlanningTACalendar(PlanningID, SeasonYearID, TACalTemplateID, Sort, CUser, CDate)
	VALUES (@PlanningID, @SeasonYearID, @TACalTemplateID, @Sort, @CUser, @CDate)

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08771', GetDate())
GO
