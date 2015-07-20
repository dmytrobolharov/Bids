
/****** Object:  View [dbo].[vwx_SampleRequestMaterial_SEL]    Script Date: 02/03/2012 15:26:39 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestMaterial_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestMaterial_SEL]
GO

CREATE VIEW [dbo].[vwx_SampleRequestMaterial_SEL]  
AS  
  
SELECT a.SampleRequestMaterialID, a.SampleRequestTradeID, a.SampleWorkflowID,   
  ISNULL(b.MaterialNo,'') + ISNULL(' - '+b.MaterialName,'')  as Material, a.Status, a.Submit,c.TradePartnerVendorID,  
  a.StyleMaterialID, a.StyleColorID,a.StyleSourcingID, f.ColorCode, f.ColorName, g.StyleColorName as Colorway,  
  a.MUser, a.MDate, b.MaterialImageID, b.MaterialImageVersion  
FROM pSampleRequestMaterial a  
 LEFT OUTER JOIN pSampleRequestTrade c On c.SampleRequestTradeID = a.SampleRequestTradeID  
 LEFT OUTER JOIN pMaterial b On a.MaterialID =  b.MaterialID   
 LEFT OUTER JOIN pStyleColorwayItem d ON d.StyleMaterialID = a.StyleMaterialID and d.StyleColorID = a.StyleColorID  
 LEFT OUTER JOIN pStyleColorway g on g.StyleColorID =  d.StyleColorID   
   
 LEFT OUTER JOIN pMaterialColor  e ON e.MaterialColorID  =  d.MaterialColorID   
 LEFT OUTER JOIN pColorPalette f on f.ColorPaletteID =  e.ColorPaletteID  

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03080'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03080', GetDate())

END

GO