IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_TACalTemplateActive_SEL]'))
DROP VIEW [dbo].[vwx_TACalTemplateActive_SEL]
GO

CREATE VIEW [dbo].[vwx_TACalTemplateActive_SEL]
AS
SELECT     tpl.*,(select CASE  WHEN COUNT(*) = 0 THEN 0 ELSE 1 END from pTACalReference where TACalTemplateId= tpl.TACalTemplateId and TACalReferenceTypeId in (2,5,8,24)) as refCount, STUFF
                          ((SELECT     ', ' + CAST(cd.DivisionID AS NVARCHAR(50))
                              FROM         pTACalTemplateDivision cd
                              WHERE     cd.TACalTemplateID = tpl.TACalTemplateID FOR XML PATH('')), 1, 2, '') AS DivisionIDs, STUFF
                          ((SELECT     ', ' + d .Custom
                              FROM         iCustom1 d INNER JOIN
                                                    pTACalTemplateDivision cd ON d .CustomID = cd.DivisionID
                              WHERE     cd.TACalTemplateID = tpl.TACalTemplateID FOR XML PATH('')), 1, 2, '') AS Divisions
FROM         dbo.pTACalTemplate AS tpl WHERE Active = 1



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08807', GetDate())
GO
