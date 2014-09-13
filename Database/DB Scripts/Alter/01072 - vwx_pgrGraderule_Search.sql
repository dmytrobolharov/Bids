
/****** Object:  View [dbo].[vwx_pgrGraderule_Search]    Script Date: 01/28/2011 16:55:12 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pgrGraderule_Search]'))
DROP VIEW [dbo].[vwx_pgrGraderule_Search]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_pgrGraderule_Search]

AS

SELECT     g.POMCompanyId, g.GradeRuleGuidID, c.RefCode, c.POMDesc
FROM       dbo.pGRGradeRule AS g INNER JOIN
dbo.pGRPOMCompany AS c ON g.POMCompanyId = c.POMCompanyId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01072', GetDate())
GO