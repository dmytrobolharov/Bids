IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_Header2_SEL]'))
	DROP VIEW [dbo].[vwx_Sourcing_Header2_SEL]
GO

CREATE VIEW [dbo].[vwx_Sourcing_Header2_SEL]
AS
SELECT     dbo.pSourcingHeader.SourcingHeaderID, dbo.pSourcingHeader.SourcingName, dbo.pSourcingHeader.SourcingType, 
                      dbo.pSourcingHeader.Season + ' ' + dbo.pSourcingHeader.Year AS SeasonYear, dbo.iCustom1.Custom AS Division, 
                      dbo.pStyleCategory.StyleCategory AS StyleCategoryID, dbo.pSourcingWorkflowTemplate.TemplateName AS SourcingWorkflowTemplateID, 
                      dbo.pSourcingHeader.Active, dbo.pSourcingHeader.CDate, dbo.pSourcingHeader.MUser, dbo.pSourcingHeader.MDate
FROM         dbo.pSourcingHeader LEFT OUTER JOIN
                      dbo.iCustom1 ON dbo.pSourcingHeader.Division = dbo.iCustom1.CustomID LEFT OUTER JOIN
                      dbo.pStyleCategory ON dbo.pSourcingHeader.StyleCategoryID = dbo.pStyleCategory.StyleCategoryId LEFT OUTER JOIN
                      dbo.pSourcingWorkflowTemplate ON 
                      dbo.pSourcingHeader.SourcingWorkflowTemplateID = dbo.pSourcingWorkflowTemplate.SourcingWorkflowTemplateID LEFT OUTER JOIN
                      dbo.pSourcingType ON dbo.pSourcingType.SourcingTypeId = dbo.pSourcingHeader.SourcingType
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09871', GetDate())
GO
