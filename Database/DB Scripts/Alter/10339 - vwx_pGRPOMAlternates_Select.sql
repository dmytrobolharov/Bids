IF OBJECT_ID(N'[dbo].[vwx_pGRPOMAlternates_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_pGRPOMAlternates_Select]
GO

CREATE VIEW [dbo].[vwx_pGRPOMAlternates_Select]
AS
SELECT     TOP (100) PERCENT dbo.pGRPOM.POMGuidId, dbo.pGRPOM.RefCode, dbo.pGRAlternates.AlternatesCode, dbo.pGRPOM.POMDesc, dbo.pGRPOM.CnvtPOMDesc, 
                      dbo.pGRPOM.How2MeasName, dbo.pGRPOM.How2MeasText, dbo.pGRPOM.SortField AS Sort, dbo.pGRPOM.Muser, dbo.pGRPOM.MDate, 
                      dbo.pGRAlternates.AlternatesGuidId, dbo.pGRAlternates.AlternatesDesc, dbo.pGRPOMAlternates.POMAlternatesId, dbo.pGRCompany.Company, 
                      dbo.fnx_GetStreamingTypedImageHTML('POM', dbo.pGRPOM.ImageID, 50, '') AS POMImage
FROM         dbo.pGRPOM INNER JOIN
                      dbo.pGRPOMAlternates ON dbo.pGRPOM.POMGuidId = dbo.pGRPOMAlternates.POMGuidId INNER JOIN
                      dbo.pGRAlternates ON dbo.pGRPOMAlternates.AlternatesGuidId = dbo.pGRAlternates.AlternatesGuidId LEFT OUTER JOIN
                      dbo.pGRCompany ON dbo.pGRPOM.CompanyGuidId = dbo.pGRCompany.CompanyGuidID
ORDER BY Sort, dbo.pGRPOM.RefCode, dbo.pGRAlternates.AlternatesCode


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10339', GetUTCDate())
GO
