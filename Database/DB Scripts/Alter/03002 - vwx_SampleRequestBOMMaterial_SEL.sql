/****** Object:  View [dbo].[vwx_SampleRequestBOMMaterial_SEL]    Script Date: 01/24/2012 18:34:57 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestBOMMaterial_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestBOMMaterial_SEL]
GO


CREATE VIEW [dbo].[vwx_SampleRequestBOMMaterial_SEL] 
AS    
SELECT  
	a.StyleID,
	a.StyleSet,  
    a.SampleRequestMaterialID,
    a.SampleRequestTradeID,
    a.SampleWorkflowID,  
    ISNULL(b.MaterialNo,'') + CASE WHEN b.MaterialName IS NOT NULL OR b.MaterialName<>'' THEN ' - ' +b.MaterialName ELSE '' END  as Material,
    b.MaterialNo,
    b.MaterialName,
    a.Status, a.Submit,c.TradePartnerVendorID, 
    a.StyleMaterialID,    
    a.StyleSourcingID,	
	dbo.fnx_GetMaterialItemColorName(d.MaterialColorID) As Colorway, 
    ISNULL(f.ColorCode,'') As ColorCode,
    ISNULL(f.ColorName,'') As ColorName, 
    d.Itemdim1Name As Itemdim1Name,
    d.Itemdim2Name As Itemdim2Name,
    d.Itemdim3Name As Itemdim3Name,
    a.MUser,
    a.MDate,
    b.MaterialImageID,
    b.MaterialImageVersion,
    d.WorkFlowItemID,
    d.StyleBOMDimensionID,
    d.StyleBOMDimensionItemID,
    h.MainMaterial  
FROM
    pSampleRequestMaterialBOM a 
    LEFT OUTER JOIN pSampleRequestBOMTrade c On c.SampleRequestTradeID = a.SampleRequestTradeID  
    LEFT OUTER JOIN pMaterial b On a.MaterialID =  b.MaterialID  
    LEFT OUTER JOIN pStyleBOMItem d ON d.StyleMaterialID = a.StyleMaterialID
    LEFT OUTER JOIN pMaterialColor  e ON d.MaterialColorId=e.MaterialColorID   
    LEFT OUTER JOIN pColorPalette f on f.ColorPaletteID =  e.ColorPaletteID
    LEFT OUTER JOIN pStyleBOMDimension g ON g.StyleBOMDimensionID=d.StyleBOMDimensionID 
	LEFT OUTER JOIN pStyleBOM h ON d.StyleBOMDimensionID=h.StyleBOMDimensionId AND d.StyleMaterialID=h.StyleMaterialID


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03002'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03002', GetDate())
END
GO
