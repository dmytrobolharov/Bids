
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwx_pGRPOM4Company_Select]
AS
SELECT     d.POMCompanyId, d.CompanyGuidID, d.POMAlternatesId, d.RefCode, d.POMDesc, d.How2MeasText, d.SortField, d.IsLinked, d.MUser, d.MDate, 
                      dbo.pGRAlternates.AlternatesCode, '<img src=''../System/Control/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(d.ImageId, 
                      '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS POMImage, d.ImageId
FROM         dbo.pGRPOMCompany AS d INNER JOIN
                      dbo.pGRPOMAlternates ON d.POMAlternatesId = dbo.pGRPOMAlternates.POMAlternatesId INNER JOIN
                      dbo.pGRAlternates ON dbo.pGRPOMAlternates.AlternatesGuidId = dbo.pGRAlternates.AlternatesGuidId

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01024', GetDate())
GO
