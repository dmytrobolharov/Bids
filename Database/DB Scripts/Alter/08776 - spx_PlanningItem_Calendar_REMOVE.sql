IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningItem_Calendar_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningItem_Calendar_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_PlanningItem_Calendar_REMOVE]
	@PlanningItemID UNIQUEIDENTIFIER,
	@PlanningTACalendarID UNIQUEIDENTIFIER
AS

DECLARE @StyleID UNIQUEIDENTIFIER,
		@TaCalTemplateID UNIQUEIDENTIFIER
		
SELECT @StyleID = StyleID FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID
SELECT @TaCalTemplateID = TACalTemplateID 
FROM pPlanningTACalendar WHERE PlanningTACalendarID = @PlanningTACalendarID

EXEC spx_TACalReferenceFromStyle_DELETE 
	@TACalTemplateID = @TaCalTemplateID,
	@StyleID = @StyleID
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08776', GetDate())
GO
