IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningTACalendar_Info_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningTACalendar_Info_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningTACalendar_Info_SELECT]
	@PlanningTACalendarID UNIQUEIDENTIFIER
AS

SELECT * FROM pPlanningTACalendar pcal
INNER JOIN pPlanning p ON pcal.PlanningID = p.PlanningID
INNER JOIN pTACalTemplate ct ON pcal.TACalTemplateID = ct.TACalTemplateId
WHERE pcal.PlanningTACalendarID = @PlanningTACalendarID


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08778', GetDate())
GO
