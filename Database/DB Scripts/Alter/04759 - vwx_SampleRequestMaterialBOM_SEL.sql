/****** Object:  View [dbo].[vwx_SampleRequestMaterialBOM_SEL]    Script Date: 01/16/2013 11:47:45 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleRequestMaterialBOM_SEL]'))
DROP VIEW [dbo].[vwx_SampleRequestMaterialBOM_SEL]
GO

/****** Object:  View [dbo].[vwx_SampleRequestMaterialBOM_SEL]    Script Date: 01/16/2013 11:47:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SampleRequestMaterialBOM_SEL]
AS
SELECT     a.StyleID, a.StyleSet, a.SampleRequestMaterialID, a.SampleRequestTradeID, a.SampleWorkflowID, ISNULL(b.MaterialNo, N'') + ISNULL(' - ' + b.MaterialName, N'') 
                      AS Material, a.Status, a.Submit, c.TradePartnerVendorID, i.Status AS SubmitStatus, a.StyleMaterialID, a.ItemDim1Id, a.StyleSourcingID, 
                      dbo.fnx_GetMaterialItemColorName(d.MaterialColorId) AS Colorway, f.ColorCode, f.ColorName, d.ItemDim1Name, d.ItemDim2Name, d.ItemDim3Name, a.MUser, 
                      a.MDate, b.MaterialImageID, b.MaterialImageVersion, d.WorkFlowItemID, d.StyleBOMDimensionID, d.StyleBOMDimensionItemID, 
                      CASE WHEN h.Artwork = 1 THEN 'Yes' ELSE 'No' END AS Artwork, CASE WHEN h.License = 1 THEN 'Yes' ELSE 'No' END AS License, c.TradePartnerID
FROM         dbo.pSampleRequestMaterialBOM AS a LEFT OUTER JOIN
                      dbo.pSampleRequestBOMTrade AS c ON c.SampleRequestTradeID = a.SampleRequestTradeID AND c.ItemDim1Id = a.ItemDim1Id AND 
                      c.ItemDim2Id = a.ItemDim2Id AND c.ItemDim3Id = a.ItemDim3Id LEFT OUTER JOIN
                      dbo.pMaterial AS b ON a.MaterialID = b.MaterialID LEFT OUTER JOIN
                      dbo.pStyleBOMItem AS d ON d.StyleMaterialID = a.StyleMaterialID LEFT OUTER JOIN
                      dbo.pMaterialColor AS e ON e.MaterialColorID = d.MaterialColorId LEFT OUTER JOIN
                      dbo.pColorPalette AS f ON f.ColorPaletteID = e.ColorPaletteID LEFT OUTER JOIN
                      dbo.pStyleBOM AS h ON a.StyleMaterialID = h.StyleMaterialID LEFT OUTER JOIN
                      dbo.pSampleRequestSubmitStatus AS i ON a.Status = i.StatusID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04759', GetDate())
GO
