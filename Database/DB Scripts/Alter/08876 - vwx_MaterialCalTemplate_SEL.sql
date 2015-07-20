/****** Object:  View [dbo].[vwx_MaterialCalTemplate_SEL]    Script Date: 08/17/2014 18:04:24 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialCalTemplate_SEL]'))
DROP VIEW [dbo].[vwx_MaterialCalTemplate_SEL]
GO

/****** Object:  View [dbo].[vwx_MaterialCalTemplate_SEL]    Script Date: 08/17/2014 18:04:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_MaterialCalTemplate_SEL]
AS
SELECT     cal.TACalTemplateId, cal.TACalTemplateName, cal.TACalTemplateDescription, cal.SeasonYearId, cal.TACalTemplatePlanStart, cal.TACalTemplatePlanEnd, cal.CUser, 
                      cal.CDate, cal.MUser, cal.MDate, cal.Active, cal.TACalTemplateDuration, msy.MaterialID
FROM         dbo.pMaterialSeasonYear AS msy INNER JOIN
                      dbo.pTACalTemplate AS cal ON msy.SeasonYearID = cal.SeasonYearId
WHERE     (cal.Active = 1)

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08876', GetDate())
GO

