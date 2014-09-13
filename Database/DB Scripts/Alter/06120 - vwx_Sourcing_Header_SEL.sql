IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Sourcing_Header_SEL]'))
DROP VIEW [dbo].[vwx_Sourcing_Header_SEL]
GO


CREATE VIEW [dbo].[vwx_Sourcing_Header_SEL]
AS
SELECT     dbo.pSourcingHeader.SourcingHeaderID, dbo.pSourcingHeader.SourcingName, dbo.pSourcingHeader.SourcingType, dbo.pSourcingType.SourcingTypeName, 
                      dbo.pSourcingHeader.Season, dbo.pSourcingHeader.Year, dbo.pSourcingHeader.Division AS DivisionID, 
                      dbo.pSourcingHeader.Season + ' ' + dbo.pSourcingHeader.Year AS SeasonYear, dbo.iCustom1.Custom AS Division, 
                      dbo.pSourcingHeader.StyleCategoryID, dbo.pSourcingWorkflowTemplate.TemplateName AS SourcingWorkflowTemplateID, 
                      dbo.pSourcingHeader.Active, dbo.pSourcingHeader.CUser, dbo.pSourcingHeader.CDate, dbo.pSourcingHeader.MUser, dbo.pSourcingHeader.MDate, 
                      STUFF 
                      ((SELECT ', ' + dbo.pStyleType.StyleTypeDescription FROM dbo.pSourcingHeaderToStyleType
							LEFT JOIN dbo.pStyleType ON dbo.pSourcingHeaderToStyleType.StyleTypeID = dbo.pStyleType.StyleTypeID
						WHERE dbo.pSourcingHeaderToStyleType.SourcingHeaderID = dbo.pSourcingHeader.SourcingHeaderID
						ORDER BY  dbo.pStyleType.StyleTypeDescription
						FOR XML PATH('')), 1, 2, '') AS StyleTypes,
                      STUFF 
                      ((SELECT ', ' + dbo.pStyleCategory.StyleCategory FROM dbo.pSourcingHeaderToStyleCategory
							LEFT JOIN dbo.pStyleCategory ON dbo.pSourcingHeaderToStyleCategory.StyleCategoryID = dbo.pStyleCategory.StyleCategoryId
						WHERE dbo.pSourcingHeaderToStyleCategory.SourcingHeaderID = dbo.pSourcingHeader.SourcingHeaderID
						ORDER BY  dbo.pStyleCategory.StyleCategory
						FOR XML PATH('')), 1, 2, '') AS StyleCategories                      
FROM         dbo.pSourcingHeader LEFT OUTER JOIN
                      dbo.iCustom1 ON dbo.pSourcingHeader.Division = dbo.iCustom1.CustomID LEFT OUTER JOIN
                      --dbo.pStyleCategory ON dbo.pSourcingHeader.StyleCategoryID = dbo.pStyleCategory.StyleCategoryId LEFT OUTER JOIN
                      dbo.pSourcingWorkflowTemplate ON 
                      dbo.pSourcingHeader.SourcingWorkflowTemplateID = dbo.pSourcingWorkflowTemplate.SourcingWorkflowTemplateID LEFT OUTER JOIN
                      dbo.pActive ON dbo.pSourcingHeader.Active = dbo.pActive.CustomKey LEFT OUTER JOIN
                      dbo.pSourcingType ON dbo.pSourcingType.SourcingTypeId = dbo.pSourcingHeader.SourcingType


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06120', GetDate())
GO
