IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMaterialList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMaterialList_SELECT]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMMaterialList_SELECT]
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkFlowId uniqueidentifier,
	@WorkflowItemID uniqueidentifier
)
AS  
	SELECT DISTINCT pStyleBOM.AUTOCOLOR, pStyleBOM.Artwork, pStyleBOM.License, pStyleBOM.Colorway, uTradePartnerVendor.VendorName, 
		  pStyleBOM.StyleMaterialID, pStyleBOM.StyleMaterialMasterID, pStyleBOM.CopyStyleMaterialID, pStyleBOM.MainMaterial, 
		  pStyleBOM.Development, pStyleBOM.MiscColor, pStyleBOM.StyleSet, pStyleBOM.WorkflowId, pStyleBOM.WorkflowItemId, 
		  pStyleBOM.StyleBOMDimensionId, pStyleBOM.StyleID, pStyleBOM.UOM, pStyleBOM.MaterialColorId, pStyleBOM.Qty, 
		  pStyleBOM.MaterialPrice, pStyleBOM.Ext, pStyleBOM.MaterialSize, pStyleBOM.MaterialID, pStyleBOM.MaterialPlacement, 
		  pStyleBOM.MaterialPlacementCode, pStyleBOM.MaterialPlacementDetail, pStyleBOM.MaterialImageID, pStyleBOM.MaterialImageVersion, 
		  pStyleBOM.NoColorMatch, pStyleBOM.SupplierID, pStyleBOM.ComponentTypeID, pStyleBOM.MaterialType, pStyleBOM.MaterialNo, 
		  pStyleBOM.MaterialName, pStyleBOM.Dim1TypeSel AS DimManage, pStyleBOM.Dim1TypeSel, pStyleBOM.Dim2TypeSel, 
		  pStyleBOM.Dim3TypeSel, pStyleBOM.Source, pStyleBOM.Notes, pStyleBOM.Placement, pStyleBOM.VendorPrice, 
		  pStyleBOM.VolumePrice, pStyleBOM.VolumePriceMinimum, pStyleBOM.VendorProductionMin, pStyleBOM.VendorProductionLeadTime, 
		  pStyleBOM.DetailYesNo, pStyleBOM.ImageType, pStyleBOM.height, pStyleBOM.width, pStyleBOM.CDate, pStyleBOM.CUser, 
		  pStyleBOM.MDate, pStyleBOM.MUser, pStyleBOM.MChange, pStyleBOM.SChange, pStyleBOM.DChange, pStyleBOM.CChange, 
		  pStyleBOM.Action, pStyleBOM.ColorPlacement, pStyleBOM.MaterialSort, pStyleBOM.MaterialTrack, pStyleBOM.MaterialLinked, 
		  pStyleBOM.MaterialDimension, 
		  pStyleBOM.MaterialLining, pStyleBOM.MaterialSizeID, pStyleBOM.MaterialPackLabelGroupID, pStyleBOM.MaterialBOM 
		  --pMaterial.MaterialColorRequired, pMaterial.FactorySourced,
		  --pMaterial.MaterialCode
	FROM  uTradePartnerVendor RIGHT OUTER JOIN
		  pStyleBOM INNER JOIN
		  --pMaterial ON pMaterial.MaterialID = pStyleBOM.MaterialID INNER JOIN
		  pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID ON 
		  uTradePartnerVendor.TradePartnerVendorID = pStyleBOM.TradePartnerVendorID
		  WHERE WorkflowItemId = @WorkflowItemID order by pStyleBOM.MaterialNo


GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03164'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03164', GetDate())
END

GO		


