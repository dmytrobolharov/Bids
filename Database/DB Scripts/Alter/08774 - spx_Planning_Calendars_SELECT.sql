IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Planning_Calendars_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Planning_Calendars_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Planning_Calendars_SELECT]
	@PlanningID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
AS

SELECT *
FROM pPlanningTACalendar pcal
INNER JOIN vwx_TACalTemplate_SEL ct ON pcal.TACalTemplateID = ct.TACalTemplateId
WHERE pcal.PlanningID = @PlanningID AND pcal.SeasonYearID = @SeasonYearID
ORDER BY pcal.Sort


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08774', GetDate())
GO
