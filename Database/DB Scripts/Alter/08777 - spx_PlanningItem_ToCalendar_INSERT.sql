IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_ToCalendar_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_ToCalendar_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_ToCalendar_INSERT]
	@PlanningItemID UNIQUEIDENTIFIER,
	@PlanningTACalendarID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS

DECLARE @StyleID UNIQUEIDENTIFIER,
		@TaCalTemplateID UNIQUEIDENTIFIER
		
SELECT @StyleID = StyleID FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID
SELECT @TaCalTemplateID = TACalTemplateID 
FROM pPlanningTACalendar WHERE PlanningTACalendarID = @PlanningTACalendarID

EXEC spx_TACalReferenceFromStyle_CREATE 
	@StyleID = @StyleID,
	@TaCalTemplateID = @TaCalTemplateID,
	@CUser = @CUser,
	@CDate = @CDate
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08777', GetDate())
GO
