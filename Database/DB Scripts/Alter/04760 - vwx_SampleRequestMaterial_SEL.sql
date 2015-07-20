/****** Object:  View [dbo].[vwx_SampleRequestMaterial_SEL]    Script Date: 01/16/2013 11:32:14 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestMaterial_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestMaterial_SEL]
GO

/****** Object:  View [dbo].[vwx_SampleRequestMaterial_SEL]    Script Date: 01/16/2013 11:32:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SampleRequestMaterial_SEL]
AS
SELECT     a.SampleRequestMaterialID, a.SampleRequestTradeID, a.SampleWorkflowID, ISNULL(b.MaterialNo, '') + ISNULL(' - ' + b.MaterialName, '') AS Material, a.Status, 
                      a.Submit, c.TradePartnerVendorID, c.TradePartnerID, a.StyleMaterialID, a.StyleColorID, a.StyleSourcingID, f.ColorCode, f.ColorName, g.StyleColorName AS Colorway, 
                      a.MUser, a.MDate, b.MaterialImageID, b.MaterialImageVersion
FROM         dbo.pSampleRequestMaterial AS a LEFT OUTER JOIN
                      dbo.pSampleRequestTrade AS c ON c.SampleRequestTradeID = a.SampleRequestTradeID LEFT OUTER JOIN
                      dbo.pMaterial AS b ON a.MaterialID = b.MaterialID LEFT OUTER JOIN
                      dbo.pStyleColorwayItem AS d ON d.StyleMaterialID = a.StyleMaterialID AND d.StyleColorID = a.StyleColorID LEFT OUTER JOIN
                      dbo.pStyleColorway AS g ON g.StyleColorID = d.StyleColorID LEFT OUTER JOIN
                      dbo.pMaterialColor AS e ON e.MaterialColorID = d.MaterialColorID LEFT OUTER JOIN
                      dbo.pColorPalette AS f ON f.ColorPaletteID = e.ColorPaletteID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04760', GetDate())
GO

