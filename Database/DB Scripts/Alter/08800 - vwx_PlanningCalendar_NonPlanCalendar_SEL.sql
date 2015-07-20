IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_PlanningCalendar_NonPlanCalendar_SEL]'))
DROP VIEW [dbo].[vwx_PlanningCalendar_NonPlanCalendar_SEL]
GO

CREATE VIEW [dbo].[vwx_PlanningCalendar_NonPlanCalendar_SEL]
AS

WITH PlanningCalendars AS (
	SELECT DISTINCT pli.PlanningID
		, ssy.SeasonYearID
		, cr.TACalTemplateId
	FROM dbo.pPlanningItem AS pli
	INNER JOIN dbo.pStyleSeasonYear AS ssy ON pli.StyleSeasonYearID = ssy.StyleSeasonYearID
	INNER JOIN dbo.pTACalReference AS cr ON pli.StyleID = cr.ReferenceId)
SELECT pc.PlanningID
	, pc.SeasonYearID
	, cal.TACalTemplateId
	, cal.TACalTemplateName
	, cal.TACalTemplateDescription
	, cal.TACalTemplatePlanStart
	, cal.TACalTemplatePlanEnd
	, cal.CUser
	, cal.CDate
	, cal.MUser
	, cal.MDate
	, cal.Active
	, cal.TACalTemplateDuration
	, cal.refCount
	, cal.DivisionIDs
	, cal.Divisions
FROM PlanningCalendars AS pc
INNER JOIN dbo.vwx_TACalTemplate_SEL AS cal ON pc.TACalTemplateId = cal.TACalTemplateId
LEFT OUTER JOIN dbo.pPlanningTACalendar AS pcal ON pc.PlanningID = pcal.PlanningID
	AND pc.SeasonYearID = pcal.SeasonYearID
	AND pc.TACalTemplateId = pcal.TACalTemplateID
WHERE pcal.PlanningTACalendarID IS NULL


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08800', GetDate())
GO
