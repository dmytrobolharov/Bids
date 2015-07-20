IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_SampleRequestMaterial_SEL')
    DROP VIEW vwx_SampleRequestMaterial_SEL
GO

CREATE VIEW [dbo].[vwx_SampleRequestMaterial_SEL]
AS

      SELECT a.SampleRequestMaterialID, a.SampleRequestTradeID, a.SampleWorkflowID, 
      b.MaterialNo  + ' - ' + b.MaterialName  as Material, a.Status, a.Submit,c.TradePartnerVendorID,
      a.StyleMaterialID, a.StyleColorID,a.StyleSourcingID, f.ColorCode, f.ColorName, g.StyleColorName as Colorway
      , a.MUser, a.MDate
      FROM pSampleRequestMaterial a
      INNER JOIN pSampleRequestTrade c On c.SampleRequestTradeID = a.SampleRequestTradeID
      INNER JOIN pMaterial b On a.MaterialID =  b.MaterialID 
      INNER JOIN pStyleColorwayItem d ON d.StyleMaterialID = a.StyleMaterialID and d.StyleColorID = a.StyleColorID
      INNER JOIN pStyleColorway g on g.StyleColorID =  d.StyleColorID 
      LEFT OUTER JOIN pMaterialColor  e ON e.MaterialColorID  =  d.MaterialColorID 
      LEFT OUTER JOIN pColorPalette f on f.ColorPaletteID =  e.ColorPaletteID

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01205', GetDate())
GO