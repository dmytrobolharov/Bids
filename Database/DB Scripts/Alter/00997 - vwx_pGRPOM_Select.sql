/****** Object:  View [dbo].[vwx_pGRPOM_Select]    Script Date: 01/07/2011 09:17:19 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRPOM_Select]'))
DROP VIEW [dbo].[vwx_pGRPOM_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[vwx_pGRPOM_Select]
AS
SELECT     dbo.pGRPOM.POMGuidId, dbo.pGRPOM.RefCode, dbo.pGRPOM.POMDesc, dbo.pGRPOM.CnvtPOMDesc, dbo.pGRPOM.How2MeasName, 
                      dbo.pGRPOM.How2MeasText, dbo.pGRPOM.SortField, dbo.pGRPOM.Muser, dbo.pGRPOM.MDate, dbo.pGRPOM.CompanyGuidId, dbo.pGRCompany.Company, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=POM&S=50&ID=' + CAST(ISNULL(dbo.pGRPOM.ImageId, '00000000-0000-0000-0000-000000000000') 
                      AS NVARCHAR(50)) + ''' />' AS POMImage, IsActive
FROM         dbo.pGRPOM LEFT OUTER JOIN
                      dbo.pGRCompany ON dbo.pGRPOM.CompanyGuidId = dbo.pGRCompany.CompanyGuidID 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '00997', GetDate())
GO