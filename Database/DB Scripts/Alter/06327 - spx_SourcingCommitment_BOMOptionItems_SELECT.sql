IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitment_BOMOptionItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitment_BOMOptionItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SourcingCommitment_BOMOptionItems_SELECT]
(
	@SourcingCommitmentBOMOptionID UNIQUEIDENTIFIER,
	@StyleQuoteItemID UNIQUEIDENTIFIER
)
AS  

/*Get Image Server path portion.*/
DECLARE @ImageServer nvarchar(255)
SET @ImageServer = (SELECT TOP 1 AppSettingValue FROM sAppSetting WHERE UPPER(ConfigFileName) = UPPER('Server.config') AND UPPER(AppSettingKey) = UPPER('ImageServer'))

declare @StyleId uniqueidentifier,
		@StyleSet int,
		@WorkFlowId uniqueidentifier,
		@WorkflowItemID uniqueidentifier,
		@StyleBOMDimensionId uniqueidentifier,
		@StyleBOMDimensionItemId nvarchar(50);
		
SELECT 
	@StyleId = StyleID,
	@StyleSet = StyleSet,
	@WorkFlowId = WorkFlowID,
	@WorkflowItemID = WorkFlowItemID,
	@StyleBOMDimensionId = StyleBOMDimensionID,
	@StyleBOMDimensionItemId = StyleBOMDimensionItemID
FROM pSourcingQuoteStyleBOM WHERE StyleQuoteItemID = @StyleQuoteItemID


		--IF (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'') AND (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'00000000-0000-0000-0000-000000000000')
		--BEGIN

			SELECT pSourcingCommitmentBOMOptionItems.StyleMaterialID, pSourcingCommitmentBOMOptionItems.AutoColor,pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pSourcingCommitmentBOMOptionItems.MainMaterial,0) AS MainMaterial, pSourcingCommitmentBOMOptionItems.Development, pSourcingCommitmentBOMOptionItems.MiscColor, pSourcingCommitmentBOMOptionItems.StyleSet, 
				pSourcingCommitmentBOMOptionItems.StyleID, pSourcingCommitmentBOMOptionItems.WorkFlowId,pSourcingCommitmentBOMOptionItems.WorkflowItemID,pSourcingCommitmentBOMOptionItems.StyleBOMDimensionId,
				pSourcingCommitmentBOMOptionItems.Dim1TypeSel, pSourcingCommitmentBOMOptionItems.Dim2TypeSel, pSourcingCommitmentBOMOptionItems.Dim3TypeSel,
				pSourcingCommitmentBOMOptionItems.UOM,UOM.UOM as "UOMValue", MaterialColorId=COALESCE(pSourcingCommitmentBOMOptionItems.MaterialColorId,'00000000-0000-0000-0000-000000000000'), pSourcingCommitmentBOMOptionItems.Qty , pSourcingCommitmentBOMOptionItems.MaterialPrice, pSourcingCommitmentBOMOptionItems.Ext, 
				pSourcingCommitmentBOMOptionItems.MaterialSize, pSourcingCommitmentBOMOptionItems.MaterialID, pSourcingCommitmentBOMOptionItems.MaterialPlacement, 
				pSourcingCommitmentBOMOptionItems.MaterialPlacementCode, pSourcingCommitmentBOMOptionItems.MaterialPlacementDetail, pSourcingCommitmentBOMOptionItems.MaterialImageID, 
				pSourcingCommitmentBOMOptionItems.MaterialImageVersion, pSourcingCommitmentBOMOptionItems.NoColorMatch, pSourcingCommitmentBOMOptionItems.SupplierID, 
				pSourcingCommitmentBOMOptionItems.ComponentTypeID AS Expr1, pSourcingCommitmentBOMOptionItems.MaterialType, pSourcingCommitmentBOMOptionItems.MaterialNo, 
				pSourcingCommitmentBOMOptionItems.MaterialName, pSourcingCommitmentBOMOptionItems.A, pSourcingCommitmentBOMOptionItems.B, pSourcingCommitmentBOMOptionItems.C, pSourcingCommitmentBOMOptionItems.D, 
				pSourcingCommitmentBOMOptionItems.E, pSourcingCommitmentBOMOptionItems.F, pSourcingCommitmentBOMOptionItems.G, pSourcingCommitmentBOMOptionItems.H, pSourcingCommitmentBOMOptionItems.I, pSourcingCommitmentBOMOptionItems.J, 
				pSourcingCommitmentBOMOptionItems.K, pSourcingCommitmentBOMOptionItems.L, pSourcingCommitmentBOMOptionItems.M, pSourcingCommitmentBOMOptionItems.N, pSourcingCommitmentBOMOptionItems.O, pSourcingCommitmentBOMOptionItems.P, 
				pSourcingCommitmentBOMOptionItems.Q, pSourcingCommitmentBOMOptionItems.R, pSourcingCommitmentBOMOptionItems.S, pSourcingCommitmentBOMOptionItems.T, pSourcingCommitmentBOMOptionItems.U, pSourcingCommitmentBOMOptionItems.V, 
				pSourcingCommitmentBOMOptionItems.W, pSourcingCommitmentBOMOptionItems.X, pSourcingCommitmentBOMOptionItems.Y, pSourcingCommitmentBOMOptionItems.Z, pSourcingCommitmentBOMOptionItems.Source, pSourcingCommitmentBOMOptionItems.Notes, 
				pSourcingCommitmentBOMOptionItems.Placement, pSourcingCommitmentBOMOptionItems.VendorPrice, pSourcingCommitmentBOMOptionItems.VolumePrice, pSourcingCommitmentBOMOptionItems.VolumePriceMinimum, 
				pSourcingCommitmentBOMOptionItems.VendorProductionMin, pSourcingCommitmentBOMOptionItems.VendorProductionLeadTime, pSourcingCommitmentBOMOptionItems.DetailYesNo, 
				pSourcingCommitmentBOMOptionItems.ImageType, pSourcingCommitmentBOMOptionItems.height, pSourcingCommitmentBOMOptionItems.width, pSourcingCommitmentBOMOptionItems.CDate, pSourcingCommitmentBOMOptionItems.CUser, 
				pSourcingCommitmentBOMOptionItems.MDate, pSourcingCommitmentBOMOptionItems.MUser, pSourcingCommitmentBOMOptionItems.MChange, pSourcingCommitmentBOMOptionItems.SChange, pSourcingCommitmentBOMOptionItems.DChange, 
				pSourcingCommitmentBOMOptionItems.CChange, pSourcingCommitmentBOMOptionItems.Action, pSourcingCommitmentBOMOptionItems.ColorPlacement, pSourcingCommitmentBOMOptionItems.Artwork, 
				pSourcingCommitmentBOMOptionItems.License, pSourcingCommitmentBOMOptionItems.Colorway, pSourcingCommitmentBOMOptionItems.MaterialSort, pSourcingCommitmentBOMOptionItems.MaterialTrack, 
				pSourcingCommitmentBOMOptionItems.MaterialLinked, pSourcingCommitmentBOMOptionItems.MaterialDimension, pSourcingCommitmentBOMOptionItems.MaterialLining, 
				MaterialSizeID = COALESCE(pSourcingCommitmentBOMOptionItems.MaterialSizeID,'00000000-0000-0000-0000-000000000000'), 
				pSourcingCommitmentBOMOptionItems.MaterialPackLabelGroupID, pSourcingCommitmentBOMOptionItems.TradePartnerID, pSourcingCommitmentBOMOptionItems.TradePartnerVendorID, 
				pSourcingCommitmentBOMOptionItems.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage ,
				GroupName = case pSourcingCommitmentBOMOptionItems.MainMaterial when 1 then
						'Main Material'
					  else
						pComponentType.ComponentDescription
					  end
				, 0 AS MaterialDel, 
				'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pSourcingCommitmentBOMOptionItems.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pSourcingCommitmentBOMOptionItems.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
				pStyleHeader.HeaderLocked, pSourcingCommitmentBOMOptionItems.Comments, pSourcingCommitmentBOMOptionItems.SourcingCommitmentBOMOptionItemID,
				pSourcingCommitmentBOMOptionItems.SubstituteForID
			FROM pSourcingCommitmentBOMOptionItems 			
				INNER JOIN pComponentType ON pSourcingCommitmentBOMOptionItems.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pSourcingCommitmentBOMOptionItems.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pSourcingCommitmentBOMOptionItems.StyleID
				LEFT OUTER JOIN UOM ON pSourcingCommitmentBOMOptionItems.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pMaterial ON pSourcingCommitmentBOMOptionItems.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
				and pmaterialcolor.MaterialcolorID=pSourcingCommitmentBOMOptionItems.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pSourcingCommitmentBOMOptionItems.MaterialSizeId
			WHERE pSourcingCommitmentBOMOptionItems.SourcingCommitmentBOMOptionID = @SourcingCommitmentBOMOptionID
			ORDER BY pSourcingCommitmentBOMOptionItems.MainMaterial DESC, pComponentType.ComponentOrder, 
				pSourcingCommitmentBOMOptionItems.MaterialSort, pSourcingCommitmentBOMOptionItems.MaterialNo, pSourcingCommitmentBOMOptionItems.MaterialName, pSourcingCommitmentBOMOptionItems.StyleMaterialId

		--END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06327', GetDate())
GO