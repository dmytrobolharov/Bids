/****** Object:  View [dbo].[vwx_TACalTemplate_SEL]    Script Date: 07/22/2014 11:44:14 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplate_SEL]'))
DROP VIEW [dbo].[vwx_TACalTemplate_SEL]
GO

/****** Object:  View [dbo].[vwx_TACalTemplate_SEL]    Script Date: 07/22/2014 11:44:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_TACalTemplate_SEL]
AS
SELECT     tpl.*,  STUFF
                          ((SELECT     ', ' + CAST(cd.DivisionID AS NVARCHAR(50))
                              FROM         pTACalTemplateDivision cd
                              WHERE     cd.TACalTemplateID = tpl.TACalTemplateID FOR XML PATH('')), 1, 2, '') AS DivisionIDs, STUFF
                          ((SELECT     ', ' + d .Custom
                              FROM         iCustom1 d INNER JOIN
                                                     pTACalTemplateDivision cd  ON d .CustomID = cd.DivisionID
                              WHERE     cd.TACalTemplateID = tpl.TACalTemplateID FOR XML PATH('')), 1, 2, '') AS Divisions
FROM         dbo.pTACalTemplate AS tpl

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08386', GetDate())
GO
