IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Planning_TACalendarAdd_SEL]'))
DROP VIEW [dbo].[vwx_Planning_TACalendarAdd_SEL]
GO

CREATE VIEW [dbo].[vwx_Planning_TACalendarAdd_SEL]
AS

SELECT DISTINCT cal.TACalTemplateId
	, cal.TACalTemplateName
	, cal.TACalTemplateDescription
	, cal.SeasonYearId
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
	, pd.PlanningID
FROM vwx_TACalTemplate_SEL AS cal
INNER JOIN pTACalTemplateDivision AS cald ON cal.TACalTemplateId = cald.TACalTemplateID
INNER JOIN pPlanningDivision AS pd ON cald.DivisionID = pd.DivisionID
LEFT JOIN pPlanningTACalendar pcal ON cal.TACalTemplateId = pcal.TACalTemplateID 
	AND pd.PlanningID = pcal.PlanningID
	AND cal.SeasonYearId = pcal.SeasonYearID
WHERE pcal.PlanningTACalendarID IS NULL AND cal.Active = 1


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08769', GetDate())
GO
