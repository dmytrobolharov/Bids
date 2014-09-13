IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialCalTemplate_SEL]'))
DROP VIEW [dbo].[vwx_MaterialCalTemplate_SEL]
GO

CREATE VIEW [dbo].[vwx_MaterialCalTemplate_SEL]
AS

SELECT cal.TACalTemplateId
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
	, msy.MaterialID
FROM dbo.pMaterialSeasonYear AS msy
INNER JOIN dbo.pTACalTemplate AS cal ON msy.SeasonYearID = cal.SeasonYearId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08624', GetDate())
GO
