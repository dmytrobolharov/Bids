

/****** Object:  View [dbo].[vwx_SampleRequestBOMMaterial_SEL]    Script Date: 01/21/2012 08:49:51 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestMaterialBOM_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestMaterialBOM_SEL]
GO

CREATE VIEW [dbo].[vwx_SampleRequestMaterialBOM_SEL] 
AS    
SELECT  
	a.StyleID,
	a.StyleSet,  
    a.SampleRequestMaterialID,
    a.SampleRequestTradeID,
    a.SampleWorkflowID,  
    ISNULL(b.MaterialNo,'') + ISNULL(' - '+b.MaterialName,'')  as Material,
    a.Status, a.Submit,c.TradePartnerVendorID, 
    a.StyleMaterialID,
    a.ItemDim1Id,
    a.StyleSourcingID,	
	dbo.fnx_GetMaterialItemColorName(d.MaterialColorID) As Colorway, 
    f.ColorCode,
    f.ColorName, 
    d.Itemdim1Name As Itemdim1Name,
    d.Itemdim2Name As Itemdim2Name,
    d.Itemdim3Name As Itemdim3Name,
    a.MUser,
    a.MDate,
    b.MaterialImageID,
    b.MaterialImageVersion,
    d.WorkFlowItemID,
    d.StyleBOMDimensionID,
    d.StyleBOMDimensionItemID   
FROM
    pSampleRequestMaterialBOM a 
    LEFT OUTER JOIN pSampleRequestBOMTrade c On c.SampleRequestTradeID = a.SampleRequestTradeID  AND c.ItemDim1Id = a.ItemDim1Id AND  c.ItemDim2Id = a.ItemDim2Id AND  c.ItemDim3Id = a.ItemDim3Id
    LEFT OUTER JOIN pMaterial b On a.MaterialID =  b.MaterialID  
    LEFT OUTER JOIN pStyleBOMItem d ON d.StyleMaterialID = a.StyleMaterialID
    LEFT OUTER JOIN pMaterialColor  e ON e.MaterialColorID  =  d.MaterialColorId
    LEFT OUTER JOIN pColorPalette f on f.ColorPaletteID =  e.ColorPaletteID
    LEFT OUTER JOIN pStyleBOMDimension g ON g.StyleBOMDimensionID=d.StyleBOMDimensionID 


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02968'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02968', GetDate())
END
GO