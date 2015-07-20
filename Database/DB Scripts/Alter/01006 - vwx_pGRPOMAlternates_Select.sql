/****** Object:  View [dbo].[vwx_pGRPOMAlternates_Select]    Script Date: 01/14/2011 10:26:27 ******/


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRPOMAlternates_Select]'))
DROP VIEW [dbo].[vwx_pGRPOMAlternates_Select]
GO
CREATE VIEW [dbo].[vwx_pGRPOMAlternates_Select]
AS
SELECT     TOP (100) PERCENT dbo.pGRPOM.POMGuidId, dbo.pGRPOM.RefCode, dbo.pGRAlternates.AlternatesCode, dbo.pGRPOM.POMDesc, dbo.pGRPOM.CnvtPOMDesc, 
                      dbo.pGRPOM.How2MeasName, dbo.pGRPOM.How2MeasText, dbo.pGRPOM.SortField AS Sort, dbo.pGRPOM.Muser, dbo.pGRPOM.MDate, 
                      dbo.pGRAlternates.AlternatesGuidId, dbo.pGRAlternates.AlternatesDesc, dbo.pGRPOMAlternates.POMAlternatesId, dbo.pGRCompany.Company, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(dbo.pGRPOM.ImageId, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS POMImage
FROM         dbo.pGRPOM INNER JOIN
                      dbo.pGRPOMAlternates ON dbo.pGRPOM.POMGuidId = dbo.pGRPOMAlternates.POMGuidId INNER JOIN
                      dbo.pGRAlternates ON dbo.pGRPOMAlternates.AlternatesGuidId = dbo.pGRAlternates.AlternatesGuidId LEFT OUTER JOIN
                      dbo.pGRCompany ON dbo.pGRPOM.CompanyGuidId = dbo.pGRCompany.CompanyGuidID
ORDER BY Sort, dbo.pGRPOM.RefCode, dbo.pGRAlternates.AlternatesCode


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01006', GetDate())
GO