/****** Object:  View [dbo].[vwx_Sourcing_Header2_SEL]    Script Date: 02/27/2013 17:19:45 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_Header2_SEL]'))
DROP VIEW [dbo].[vwx_Sourcing_Header2_SEL]
GO

/****** Object:  View [dbo].[vwx_Sourcing_Header2_SEL]    Script Date: 02/27/2013 17:19:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_Sourcing_Header2_SEL]
AS
SELECT     dbo.pSourcingHeader.SourcingHeaderID, dbo.pSourcingHeader.SourcingName, dbo.pSourcingHeader.SourcingType, 
                      dbo.pSourcingHeader.Season + ' ' + dbo.pSourcingHeader.Year AS SeasonYear, dbo.iCustom1.Custom AS Division, 
                      dbo.pStyleCategory.StyleCategory AS StyleCategoryID, dbo.pSourcingWorkflowTemplate.TemplateName AS SourcingWorkflowTemplateID, 
                      dbo.pActive.Custom AS Active, dbo.pSourcingHeader.CUser, dbo.pSourcingHeader.CDate, dbo.pSourcingHeader.MUser, dbo.pSourcingHeader.MDate
FROM         dbo.pSourcingHeader LEFT OUTER JOIN
                      dbo.iCustom1 ON dbo.pSourcingHeader.Division = dbo.iCustom1.CustomID LEFT OUTER JOIN
                      dbo.pStyleCategory ON dbo.pSourcingHeader.StyleCategoryID = dbo.pStyleCategory.StyleCategoryId LEFT OUTER JOIN
                      dbo.pSourcingWorkflowTemplate ON 
                      dbo.pSourcingHeader.SourcingWorkflowTemplateID = dbo.pSourcingWorkflowTemplate.SourcingWorkflowTemplateID LEFT OUTER JOIN
                      dbo.pActive ON dbo.pSourcingHeader.Active = dbo.pActive.CustomKey LEFT OUTER JOIN
                      dbo.pSourcingType ON dbo.pSourcingType.SourcingTypeId = dbo.pSourcingHeader.SourcingType

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05182', GetDate())
GO

