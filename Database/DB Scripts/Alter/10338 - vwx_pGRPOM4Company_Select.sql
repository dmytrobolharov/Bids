IF OBJECT_ID(N'[dbo].[vwx_pGRPOM4Company_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_pGRPOM4Company_Select]
GO

CREATE VIEW [dbo].[vwx_pGRPOM4Company_Select]
AS
SELECT d.POMCompanyId, d.CompanyGuidID, d.POMAlternatesId, d.RefCode, d.POMDesc, d.How2MeasText, d.SortField, d.IsLinked, d.MUser, d.MDate, 
       dbo.pGRAlternates.AlternatesCode, d.ImageId, 
	   dbo.fnx_GetStreamingTypedImageHTML('POM', d.ImageID, 50, '') AS POMImage
FROM dbo.pGRPOMCompany AS d 
INNER JOIN dbo.pGRPOMAlternates ON d.POMAlternatesId = dbo.pGRPOMAlternates.POMAlternatesId 
INNER JOIN dbo.pGRAlternates ON dbo.pGRPOMAlternates.AlternatesGuidId = dbo.pGRAlternates.AlternatesGuidId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10338', GetUTCDate())
GO
