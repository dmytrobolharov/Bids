IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningTACalendar_SEL]'))
DROP VIEW [dbo].[vwx_PlanningTACalendar_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningTACalendar_SEL]
AS

SELECT pcal.PlanningTACalendarID
	, pcal.PlanningID
	, pcal.SeasonYearID
	, pcal.TACalTemplateID
	, pcal.Sort
	, pcal.CUser
	, pcal.CDate
	, cal.TACalTemplateName
	, cal.TACalTemplateDescription
	, cal.MUser
	, cal.MDate
FROM dbo.pPlanningTACalendar AS pcal
INNER JOIN dbo.pTACalTemplate AS cal ON pcal.TACalTemplateID = cal.TACalTemplateId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08765', GetDate())
GO
