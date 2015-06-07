IF OBJECT_ID(N'[dbo].[vwx_pGRPOM_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_pGRPOM_Select]
GO

CREATE VIEW [dbo].[vwx_pGRPOM_Select]
AS
SELECT p.POMGuidId, p.RefCode, p.POMDesc, p.CnvtPOMDesc, p.How2MeasName, p.How2MeasText, 
       p.SortField, p.Muser, p.MDate, p.CompanyGuidId, c.Company, c.IsActive, 
       dbo.fnx_GetStreamingTypedImageHTML('POM', p.ImageID, 50, '') AS POMImage
FROM dbo.pGRPOM p
LEFT OUTER JOIN dbo.pGRCompany c ON p.CompanyGuidId = c.CompanyGuidID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10337', GetUTCDate())
GO
