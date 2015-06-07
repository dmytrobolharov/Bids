IF OBJECT_ID(N'[dbo].[spx_StyleBOMSummary_selectQEAdd]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleBOMSummary_selectQEAdd]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMSummary_selectQEAdd]
(
@StyleId uniqueidentifier,
@StyleSet int,
@WorkFlowId uniqueidentifier,
@WorkflowItemID uniqueidentifier
)

AS
begin
	SELECT pStyleBOM.StyleMaterialID, pStyleBOM.ComponentTypeID, 
	--pStyleBOM.ComponentTypeID, 
	--convert(nvarchar(50),pStyleBOM.ComponentTypeID) as ComponentDescription,  
      ISNULL(pStyleBOM.MainMaterial,0) AS MainMaterial, pStyleBOM.Development, pStyleBOM.MiscColor, pStyleBOM.StyleSet, 
      pStyleBOM.StyleID, pStyleBOM.WorkFlowId,pStyleBOM.WorkflowItemID,pStyleBOM.StyleBOMDimensionId,     
      pStyleBOM.UOM,pStyleBOM.UOM as "UOMValue",  pStyleBOM.Qty , pStyleBOM.MaterialPrice, pStyleBOM.Ext, 
      pStyleBOM.MaterialSize, pStyleBOM.MaterialID, pStyleBOM.MaterialPlacement, 
      pStyleBOM.MaterialPlacementCode, pStyleBOM.MaterialPlacementDetail, pStyleBOM.MaterialImageID, 
      pStyleBOM.MaterialImageVersion, pStyleBOM.NoColorMatch, pStyleBOM.SupplierID, 
      pStyleBOM.ComponentTypeID AS Expr1, pStyleBOM.MaterialType, pStyleBOM.MaterialNo, 
      pStyleBOM.MaterialName, pStyleBOM.A, pStyleBOM.B, pStyleBOM.C, pStyleBOM.D, 
      pStyleBOM.E, pStyleBOM.F, pStyleBOM.G, pStyleBOM.H, pStyleBOM.I, pStyleBOM.J, 
      pStyleBOM.K, pStyleBOM.L, pStyleBOM.M, pStyleBOM.N, pStyleBOM.O, pStyleBOM.P, 
      pStyleBOM.Q, pStyleBOM.R, pStyleBOM.S, pStyleBOM.T, pStyleBOM.U, pStyleBOM.V, 
      pStyleBOM.W, pStyleBOM.X, pStyleBOM.Y, pStyleBOM.Z, pStyleBOM.Source, pStyleBOM.Notes, 
      pStyleBOM.Placement, pStyleBOM.VendorPrice, pStyleBOM.VolumePrice, pStyleBOM.VolumePriceMinimum, 
      pStyleBOM.VendorProductionMin, pStyleBOM.VendorProductionLeadTime, pStyleBOM.DetailYesNo, 
      pStyleBOM.ImageType, pStyleBOM.height, pStyleBOM.width, pStyleBOM.CDate, pStyleBOM.CUser, 
      pStyleBOM.MDate, pStyleBOM.MUser, pStyleBOM.MChange, pStyleBOM.SChange, pStyleBOM.DChange, 
      pStyleBOM.CChange, pStyleBOM.Action, pStyleBOM.ColorPlacement, pStyleBOM.Artwork, 
      pStyleBOM.License, pStyleBOM.Colorway, pStyleBOM.MaterialSort, pStyleBOM.MaterialTrack, 
      pStyleBOM.MaterialLinked, pStyleBOM.MaterialDimension, pStyleBOM.MaterialLining, 
      MaterialSizeID = COALESCE(pStyleBOM.MaterialSizeID,'00000000-0000-0000-0000-000000000000'), 
      pStyleBOM.MaterialPackLabelGroupID, pStyleBOM.TradePartnerID, pStyleBOM.TradePartnerVendorID, 
      pStyleBOM.MaterialBOM, 0 AS MaterialDel, 
	  --pMaterialTradePartner.MaterialTradePartnerCustom1,
      dbo.fnx_GetStreamingImageHTML(pStyleBOM.MaterialImageID, pStyleBOM.MaterialImageVersion, 25, '') AS MaterialImage
FROM  pStyleBOMTemp as pStyleBOM
--inner join  vwx_Style_BOMComponentType_SELECT v on 	v.ComponentTypeID=pStyleBOM.ComponentTypeID
WHERE pStyleBOM.StyleId = @StyleId AND pStyleBOM.StyleSet = @StyleSet
AND pStyleBOM.WorkFlowId = @WorkFlowId AND pStyleBOM.WorkflowItemID = @WorkflowItemID
--And pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId 
and pStyleBOM.QuickAdd=2
ORDER BY pStyleBOM.MDate DESC
--ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, 
--pStyleBOM.MaterialSort, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, pStyleBOM.StyleMaterialId

end



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10382', GetUTCDate())
GO
