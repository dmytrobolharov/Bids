
/****** Object:  View [dbo].[vwx_pGRPOM4Company_Select]    Script Date: 01/14/2011 10:26:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRPOM4Company_Select]'))
DROP VIEW [dbo].[vwx_pGRPOM4Company_Select]
GO

GO
CREATE VIEW [dbo].[vwx_pGRPOM4Company_Select]
AS
SELECT     d.POMCompanyId, d.CompanyGuidID, d.POMAlternatesId, d.RefCode, d.POMDesc, d.How2MeasText, d.SortField, d.IsLinked, d.MUser, d.MDate, 
                      dbo.pGRAlternates.AlternatesCode, '<img src=''../System/Control/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(d.ImageId, 
                      '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS POMImage
FROM         dbo.pGRPOMCompany AS d INNER JOIN
                      dbo.pGRPOMAlternates ON d.POMAlternatesId = dbo.pGRPOMAlternates.POMAlternatesId INNER JOIN
                      dbo.pGRAlternates ON dbo.pGRPOMAlternates.AlternatesGuidId = dbo.pGRAlternates.AlternatesGuidId

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '00991', GetDate())
