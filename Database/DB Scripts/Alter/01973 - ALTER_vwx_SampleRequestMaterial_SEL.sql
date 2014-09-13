IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestMaterial_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestMaterial_SEL]
GO

CREATE VIEW [dbo].[vwx_SampleRequestMaterial_SEL]
AS
SELECT     a.SampleRequestMaterialID, a.SampleRequestTradeID, a.SampleWorkflowID, b.MaterialNo + ' - ' + b.MaterialName AS Material, a.Status, a.Submit, 
                      c.TradePartnerVendorID, a.StyleMaterialID, a.StyleColorID, a.StyleSourcingID, f.ColorCode, f.ColorName, g.StyleColorName AS Colorway, a.MUser, a.MDate
FROM         dbo.pSampleRequestMaterial AS a INNER JOIN
                      dbo.pSampleRequestTrade AS c ON c.SampleRequestTradeID = a.SampleRequestTradeID INNER JOIN
                      dbo.pMaterial AS b ON a.MaterialID = b.MaterialID LEFT OUTER JOIN
                      dbo.pStyleColorwayItem AS d ON d.StyleMaterialID = a.StyleMaterialID AND d.StyleColorID = a.StyleColorID LEFT OUTER JOIN
                      dbo.pStyleColorway AS g ON g.StyleColorID = d.StyleColorID LEFT OUTER JOIN
                      dbo.pMaterialColor AS e ON e.MaterialColorID = d.MaterialColorID LEFT OUTER JOIN
                      dbo.pColorPalette AS f ON f.ColorPaletteID = e.ColorPaletteID

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01973'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01973', GetDate())
END
GO