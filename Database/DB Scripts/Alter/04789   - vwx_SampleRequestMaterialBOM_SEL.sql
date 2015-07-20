/****** Object:  View [dbo].[vwx_SampleRequestMaterialBOM_SEL]    Script Date: 01/16/2013 11:37:52 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestMaterialBOM_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestMaterialBOM_SEL]
GO

/****** Object:  View [dbo].[vwx_SampleRequestMaterialBOM_SEL]    Script Date: 01/16/2013 11:37:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
    a.Status, a.Submit,c.TradePartnerVendorID, c.TradePartnerID,
    i.Status As SubmitStatus,
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
    d.StyleBOMDimensionItemID,   
    CASE WHEN h.Artwork=1 THEN 'Yes' ELSE 'No' END  AS Artwork,    
    CASE WHEN h.License=1 THEN 'Yes' ELSE 'No' END  AS License
FROM
    pSampleRequestMaterialBOM a 
    LEFT OUTER JOIN pSampleRequestBOMTrade c On c.SampleRequestTradeID = a.SampleRequestTradeID  AND c.ItemDim1Id = a.ItemDim1Id AND  c.ItemDim2Id = a.ItemDim2Id AND  c.ItemDim3Id = a.ItemDim3Id
    LEFT OUTER JOIN pMaterial b On a.MaterialID =  b.MaterialID  
    LEFT OUTER JOIN pStyleBOMItem d ON d.StyleMaterialID = a.StyleMaterialID
    LEFT OUTER JOIN pMaterialColor  e ON e.MaterialColorID  =  d.MaterialColorId
    LEFT OUTER JOIN pColorPalette f on f.ColorPaletteID =  e.ColorPaletteID
	LEFT OUTER JOIN pStyleBOM h ON a.StyleMaterialID=h.StyleMaterialID 		
	LEFT OUTER JOIN pSampleRequestSubmitStatus i ON a.Status=i.StatusID




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04789', GetDate())
GO