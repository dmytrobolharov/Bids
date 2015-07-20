IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMSummary_selectQE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMSummary_selectQE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOMSummary_selectQE]
(
@StyleId uniqueidentifier,
@StyleSet int,
@WorkFlowId uniqueidentifier,
@WorkflowItemID uniqueidentifier
)

AS
begin
	SELECT pStyleBOM.StyleMaterialID, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
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
      pStyleBOM.MaterialBOM, pComponentType.ComponentOrder, '' AS GroupName, 0 AS MaterialDel, 
	  --pMaterialTradePartner.MaterialTradePartnerCustom1,
	  '<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pStyleBOM.MaterialImageVersion, 0) 
      AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOM.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
      + ''' />' AS MaterialImage, pStyleHeader.HeaderLocked
FROM  pStyleBOMTemp as pStyleBOM
	INNER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
	INNER JOIN  pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
	INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pStyleBOM.StyleID	
WHERE pStyleBOM.StyleId = @StyleId AND pStyleBOM.StyleSet = @StyleSet
AND pStyleBOM.WorkFlowId = @WorkFlowId AND pStyleBOM.WorkflowItemID = @WorkflowItemID
--And pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId 
and pStyleBOM.QuickAdd=1
ORDER BY pStyleBOM.MDate DESC
--ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, 
--pStyleBOM.MaterialSort, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, pStyleBOM.StyleMaterialId

end


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03103'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03103', GetDate())

END

GO