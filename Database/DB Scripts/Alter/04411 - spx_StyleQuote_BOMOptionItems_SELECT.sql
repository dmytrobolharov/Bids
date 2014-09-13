/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_DimBOMSummary_SELECT]    Script Date: 11/20/2012 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuote_BOMOptionItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuote_BOMOptionItems_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_DimBOMSummary_SELECT]    Script Date: 11/20/2012 17:25:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleQuote_BOMOptionItems_SELECT]
(
	@StyleOptionID UNIQUEIDENTIFIER,
	@StyleQuoteItemID UNIQUEIDENTIFIER,
	@LinkedToMaterialTable int = 0
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


IF @LinkedToMaterialTable = 0  -- if BOM is not linked to pMaterial
BEGIN

	IF (@StyleBOMDimensionItemId<>'') AND (@StyleBOMDimensionItemId<>'00000000-0000-0000-0000-000000000000')
	BEGIN

		SELECT pSourcingQuotationBOMOptionItems.StyleMaterialID, pSourcingQuotationBOMOptionItems.AutoColor, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
			ISNULL(pSourcingQuotationBOMOptionItems.MainMaterial,0) AS MainMaterial, pSourcingQuotationBOMOptionItems.Development, pSourcingQuotationBOMOptionItems.MiscColor, pSourcingQuotationBOMOptionItems.StyleSet, 
			pSourcingQuotationBOMOptionItems.StyleID, pSourcingQuotationBOMOptionItems.WorkFlowId,pSourcingQuotationBOMOptionItems.WorkflowItemID,pSourcingQuotationBOMOptionItems.StyleBOMDimensionId,
			pSourcingQuotationBOMOptionItems.Dim1TypeSel, pSourcingQuotationBOMOptionItems.Dim2TypeSel, pSourcingQuotationBOMOptionItems.Dim3TypeSel,
			pSourcingQuotationBOMOptionItems.UOM,UOM.UOM as "UOMValue", MaterialColorId = COALESCE(pStyleBOMItem.MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
			Qty = case COALESCE(pStyleBOMItem.MaterialQuantity,'0') when '0' then
					   COALESCE(pSourcingQuotationBOMOptionItems.Qty,'0')
				  else
					   COALESCE(pStyleBOMItem.MaterialQuantity,'0')
				  end,
			pSourcingQuotationBOMOptionItems.MaterialPrice, pSourcingQuotationBOMOptionItems.Ext, 
			pSourcingQuotationBOMOptionItems.MaterialSize, pSourcingQuotationBOMOptionItems.MaterialID, pSourcingQuotationBOMOptionItems.MaterialPlacement, 
			pSourcingQuotationBOMOptionItems.MaterialPlacementCode, pSourcingQuotationBOMOptionItems.MaterialPlacementDetail, pSourcingQuotationBOMOptionItems.MaterialImageID, 
			pSourcingQuotationBOMOptionItems.MaterialImageVersion, pSourcingQuotationBOMOptionItems.NoColorMatch, pSourcingQuotationBOMOptionItems.SupplierID, 
			pSourcingQuotationBOMOptionItems.ComponentTypeID AS Expr1, pSourcingQuotationBOMOptionItems.MaterialType, pSourcingQuotationBOMOptionItems.MaterialNo, 
			pSourcingQuotationBOMOptionItems.MaterialName, pSourcingQuotationBOMOptionItems.A, pSourcingQuotationBOMOptionItems.B, pSourcingQuotationBOMOptionItems.C, pSourcingQuotationBOMOptionItems.D, 
			pSourcingQuotationBOMOptionItems.E, pSourcingQuotationBOMOptionItems.F, pSourcingQuotationBOMOptionItems.G, pSourcingQuotationBOMOptionItems.H, pSourcingQuotationBOMOptionItems.I, pSourcingQuotationBOMOptionItems.J, 
			pSourcingQuotationBOMOptionItems.K, pSourcingQuotationBOMOptionItems.L, pSourcingQuotationBOMOptionItems.M, pSourcingQuotationBOMOptionItems.N, pSourcingQuotationBOMOptionItems.O, pSourcingQuotationBOMOptionItems.P, 
			pSourcingQuotationBOMOptionItems.Q, pSourcingQuotationBOMOptionItems.R, pSourcingQuotationBOMOptionItems.S, pSourcingQuotationBOMOptionItems.T, pSourcingQuotationBOMOptionItems.U, pSourcingQuotationBOMOptionItems.V, 
			pSourcingQuotationBOMOptionItems.W, pSourcingQuotationBOMOptionItems.X, pSourcingQuotationBOMOptionItems.Y, pSourcingQuotationBOMOptionItems.Z, pSourcingQuotationBOMOptionItems.Source, pSourcingQuotationBOMOptionItems.Notes, 
			pSourcingQuotationBOMOptionItems.Placement, pSourcingQuotationBOMOptionItems.VendorPrice, pSourcingQuotationBOMOptionItems.VolumePrice, pSourcingQuotationBOMOptionItems.VolumePriceMinimum, 
			pSourcingQuotationBOMOptionItems.VendorProductionMin, pSourcingQuotationBOMOptionItems.VendorProductionLeadTime, pSourcingQuotationBOMOptionItems.DetailYesNo, 
			pSourcingQuotationBOMOptionItems.ImageType, pSourcingQuotationBOMOptionItems.height, pSourcingQuotationBOMOptionItems.width, pSourcingQuotationBOMOptionItems.CDate, pSourcingQuotationBOMOptionItems.CUser, 
			pSourcingQuotationBOMOptionItems.MDate, pSourcingQuotationBOMOptionItems.MUser, pSourcingQuotationBOMOptionItems.MChange, pSourcingQuotationBOMOptionItems.SChange, pSourcingQuotationBOMOptionItems.DChange, 
			pSourcingQuotationBOMOptionItems.CChange, pSourcingQuotationBOMOptionItems.Action, pSourcingQuotationBOMOptionItems.ColorPlacement, pSourcingQuotationBOMOptionItems.Artwork, 
			pSourcingQuotationBOMOptionItems.License, pSourcingQuotationBOMOptionItems.Colorway, pSourcingQuotationBOMOptionItems.MaterialSort, pSourcingQuotationBOMOptionItems.MaterialTrack, 
			pSourcingQuotationBOMOptionItems.MaterialLinked, pSourcingQuotationBOMOptionItems.MaterialDimension, pSourcingQuotationBOMOptionItems.MaterialLining, 
			MaterialSizeID = COALESCE(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') , 
			pSourcingQuotationBOMOptionItems.MaterialPackLabelGroupID, pSourcingQuotationBOMOptionItems.TradePartnerID, pSourcingQuotationBOMOptionItems.TradePartnerVendorID, 
			pSourcingQuotationBOMOptionItems.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
			pMaterialsize.MaterialPrice as MPrice,
			pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage  ,
			GroupName = case pSourcingQuotationBOMOptionItems.MainMaterial when 1 then
					'Main Material'
				else
					pComponentType.ComponentDescription
				end
			, 0 AS MaterialDel, 
			'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
			pStyleHeader.HeaderLocked
		FROM pSourcingQuotationBOMOptionItems 		
			INNER JOIN pComponentType ON pSourcingQuotationBOMOptionItems.MaterialType = pComponentType.ComponentTypeID 
			--INNER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
			INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pSourcingQuotationBOMOptionItems.StyleID
			LEFT OUTER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
			LEFT OUTER JOIN pMaterial ON pSourcingQuotationBOMOptionItems.MaterialID = pMaterial.MaterialID
			LEFT OUTER JOIN pStyleBOMItem ON (pSourcingQuotationBOMOptionItems.StyleMaterialID = pStyleBOMItem.StyleMaterialID 
											  AND pSourcingQuotationBOMOptionItems.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId
											  AND pStyleBOMItem.StyleBOMDimensionItemId=@StyleBOMDimensionItemId)
			LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
			and pmaterialcolor.MaterialcolorID=pStyleBOMItem.MaterialColorId
			LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
			LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pStyleBOMItem.MaterialDimension
		WHERE pSourcingQuotationBOMOptionItems.StyleOptionId = @StyleOptionID			
		ORDER BY pSourcingQuotationBOMOptionItems.MainMaterial DESC, pComponentType.ComponentOrder, 
			pSourcingQuotationBOMOptionItems.MaterialSort, pSourcingQuotationBOMOptionItems.MaterialNo, pSourcingQuotationBOMOptionItems.MaterialName, pSourcingQuotationBOMOptionItems.StyleMaterialId

	END
	ELSE
	BEGIN

		IF (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'') AND (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'00000000-0000-0000-0000-000000000000')
		BEGIN

			SELECT pSourcingQuotationBOMOptionItems.StyleMaterialID, pSourcingQuotationBOMOptionItems.AutoColor,pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pSourcingQuotationBOMOptionItems.MainMaterial,0) AS MainMaterial, pSourcingQuotationBOMOptionItems.Development, pSourcingQuotationBOMOptionItems.MiscColor, pSourcingQuotationBOMOptionItems.StyleSet, 
				pSourcingQuotationBOMOptionItems.StyleID, pSourcingQuotationBOMOptionItems.WorkFlowId,pSourcingQuotationBOMOptionItems.WorkflowItemID,pSourcingQuotationBOMOptionItems.StyleBOMDimensionId,
				pSourcingQuotationBOMOptionItems.Dim1TypeSel, pSourcingQuotationBOMOptionItems.Dim2TypeSel, pSourcingQuotationBOMOptionItems.Dim3TypeSel,
				pSourcingQuotationBOMOptionItems.UOM,UOM.UOM as "UOMValue", MaterialColorId=COALESCE(pSourcingQuotationBOMOptionItems.MaterialColorId,'00000000-0000-0000-0000-000000000000'), pSourcingQuotationBOMOptionItems.Qty , pSourcingQuotationBOMOptionItems.MaterialPrice, pSourcingQuotationBOMOptionItems.Ext, 
				pSourcingQuotationBOMOptionItems.MaterialSize, pSourcingQuotationBOMOptionItems.MaterialID, pSourcingQuotationBOMOptionItems.MaterialPlacement, 
				pSourcingQuotationBOMOptionItems.MaterialPlacementCode, pSourcingQuotationBOMOptionItems.MaterialPlacementDetail, pSourcingQuotationBOMOptionItems.MaterialImageID, 
				pSourcingQuotationBOMOptionItems.MaterialImageVersion, pSourcingQuotationBOMOptionItems.NoColorMatch, pSourcingQuotationBOMOptionItems.SupplierID, 
				pSourcingQuotationBOMOptionItems.ComponentTypeID AS Expr1, pSourcingQuotationBOMOptionItems.MaterialType, pSourcingQuotationBOMOptionItems.MaterialNo, 
				pSourcingQuotationBOMOptionItems.MaterialName, pSourcingQuotationBOMOptionItems.A, pSourcingQuotationBOMOptionItems.B, pSourcingQuotationBOMOptionItems.C, pSourcingQuotationBOMOptionItems.D, 
				pSourcingQuotationBOMOptionItems.E, pSourcingQuotationBOMOptionItems.F, pSourcingQuotationBOMOptionItems.G, pSourcingQuotationBOMOptionItems.H, pSourcingQuotationBOMOptionItems.I, pSourcingQuotationBOMOptionItems.J, 
				pSourcingQuotationBOMOptionItems.K, pSourcingQuotationBOMOptionItems.L, pSourcingQuotationBOMOptionItems.M, pSourcingQuotationBOMOptionItems.N, pSourcingQuotationBOMOptionItems.O, pSourcingQuotationBOMOptionItems.P, 
				pSourcingQuotationBOMOptionItems.Q, pSourcingQuotationBOMOptionItems.R, pSourcingQuotationBOMOptionItems.S, pSourcingQuotationBOMOptionItems.T, pSourcingQuotationBOMOptionItems.U, pSourcingQuotationBOMOptionItems.V, 
				pSourcingQuotationBOMOptionItems.W, pSourcingQuotationBOMOptionItems.X, pSourcingQuotationBOMOptionItems.Y, pSourcingQuotationBOMOptionItems.Z, pSourcingQuotationBOMOptionItems.Source, pSourcingQuotationBOMOptionItems.Notes, 
				pSourcingQuotationBOMOptionItems.Placement, pSourcingQuotationBOMOptionItems.VendorPrice, pSourcingQuotationBOMOptionItems.VolumePrice, pSourcingQuotationBOMOptionItems.VolumePriceMinimum, 
				pSourcingQuotationBOMOptionItems.VendorProductionMin, pSourcingQuotationBOMOptionItems.VendorProductionLeadTime, pSourcingQuotationBOMOptionItems.DetailYesNo, 
				pSourcingQuotationBOMOptionItems.ImageType, pSourcingQuotationBOMOptionItems.height, pSourcingQuotationBOMOptionItems.width, pSourcingQuotationBOMOptionItems.CDate, pSourcingQuotationBOMOptionItems.CUser, 
				pSourcingQuotationBOMOptionItems.MDate, pSourcingQuotationBOMOptionItems.MUser, pSourcingQuotationBOMOptionItems.MChange, pSourcingQuotationBOMOptionItems.SChange, pSourcingQuotationBOMOptionItems.DChange, 
				pSourcingQuotationBOMOptionItems.CChange, pSourcingQuotationBOMOptionItems.Action, pSourcingQuotationBOMOptionItems.ColorPlacement, pSourcingQuotationBOMOptionItems.Artwork, 
				pSourcingQuotationBOMOptionItems.License, pSourcingQuotationBOMOptionItems.Colorway, pSourcingQuotationBOMOptionItems.MaterialSort, pSourcingQuotationBOMOptionItems.MaterialTrack, 
				pSourcingQuotationBOMOptionItems.MaterialLinked, pSourcingQuotationBOMOptionItems.MaterialDimension, pSourcingQuotationBOMOptionItems.MaterialLining, 
				MaterialSizeID = COALESCE(pSourcingQuotationBOMOptionItems.MaterialSizeID,'00000000-0000-0000-0000-000000000000'), 
				pSourcingQuotationBOMOptionItems.MaterialPackLabelGroupID, pSourcingQuotationBOMOptionItems.TradePartnerID, pSourcingQuotationBOMOptionItems.TradePartnerVendorID, 
				pSourcingQuotationBOMOptionItems.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage ,
				GroupName = case pSourcingQuotationBOMOptionItems.MainMaterial when 1 then
						'Main Material'
					  else
						pComponentType.ComponentDescription
					  end
				, 0 AS MaterialDel, 
				'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
				pStyleHeader.HeaderLocked
			FROM pSourcingQuotationBOMOptionItems 			
				INNER JOIN pComponentType ON pSourcingQuotationBOMOptionItems.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pSourcingQuotationBOMOptionItems.StyleID
				LEFT OUTER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pMaterial ON pSourcingQuotationBOMOptionItems.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
				and pmaterialcolor.MaterialcolorID=pSourcingQuotationBOMOptionItems.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pSourcingQuotationBOMOptionItems.MaterialSizeId
			WHERE pSourcingQuotationBOMOptionItems.StyleOptionId = @StyleOptionID
			ORDER BY pSourcingQuotationBOMOptionItems.MainMaterial DESC, pComponentType.ComponentOrder, 
				pSourcingQuotationBOMOptionItems.MaterialSort, pSourcingQuotationBOMOptionItems.MaterialNo, pSourcingQuotationBOMOptionItems.MaterialName, pSourcingQuotationBOMOptionItems.StyleMaterialId

		END
		ELSE
		BEGIN

			-- This is mainly for the Material web service so that it can get all combinations for a particular WorkflowItemID.

			SELECT pSourcingQuotationBOMOptionItems.StyleMaterialID, pSourcingQuotationBOMOptionItems.AutoColor, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pSourcingQuotationBOMOptionItems.MainMaterial,0) AS MainMaterial, pSourcingQuotationBOMOptionItems.Development, pSourcingQuotationBOMOptionItems.MiscColor, pSourcingQuotationBOMOptionItems.StyleSet, 
				pSourcingQuotationBOMOptionItems.StyleID, pSourcingQuotationBOMOptionItems.WorkFlowId,pSourcingQuotationBOMOptionItems.WorkflowItemID,pSourcingQuotationBOMOptionItems.StyleBOMDimensionId,
				pSourcingQuotationBOMOptionItems.Dim1TypeSel, pSourcingQuotationBOMOptionItems.Dim2TypeSel, pSourcingQuotationBOMOptionItems.Dim3TypeSel,
				pSourcingQuotationBOMOptionItems.UOM,UOM.UOM as "UOMValue", MaterialColorId = COALESCE(pStyleBOMItem.MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
				pStyleBOMItem.ItemDim1Id, pStyleBOMItem.ItemDim2Id, pStyleBOMItem.ItemDim3Id,
				Qty = case COALESCE(pStyleBOMItem.MaterialQuantity,'0') when '0' then
						   COALESCE(pSourcingQuotationBOMOptionItems.Qty,'0')
					  else
						   COALESCE(pStyleBOMItem.MaterialQuantity,'0')
					  end,
				pSourcingQuotationBOMOptionItems.MaterialPrice, pSourcingQuotationBOMOptionItems.Ext, 
				pSourcingQuotationBOMOptionItems.MaterialSize, pSourcingQuotationBOMOptionItems.MaterialID, pSourcingQuotationBOMOptionItems.MaterialPlacement, 
				pSourcingQuotationBOMOptionItems.MaterialPlacementCode, pSourcingQuotationBOMOptionItems.MaterialPlacementDetail, pSourcingQuotationBOMOptionItems.MaterialImageID, 
				pSourcingQuotationBOMOptionItems.MaterialImageVersion, pSourcingQuotationBOMOptionItems.NoColorMatch, pSourcingQuotationBOMOptionItems.SupplierID, 
				pSourcingQuotationBOMOptionItems.ComponentTypeID AS Expr1, pSourcingQuotationBOMOptionItems.MaterialType, pSourcingQuotationBOMOptionItems.MaterialNo, 
				pSourcingQuotationBOMOptionItems.MaterialName, pSourcingQuotationBOMOptionItems.A, pSourcingQuotationBOMOptionItems.B, pSourcingQuotationBOMOptionItems.C, pSourcingQuotationBOMOptionItems.D, 
				pSourcingQuotationBOMOptionItems.E, pSourcingQuotationBOMOptionItems.F, pSourcingQuotationBOMOptionItems.G, pSourcingQuotationBOMOptionItems.H, pSourcingQuotationBOMOptionItems.I, pSourcingQuotationBOMOptionItems.J, 
				pSourcingQuotationBOMOptionItems.K, pSourcingQuotationBOMOptionItems.L, pSourcingQuotationBOMOptionItems.M, pSourcingQuotationBOMOptionItems.N, pSourcingQuotationBOMOptionItems.O, pSourcingQuotationBOMOptionItems.P, 
				pSourcingQuotationBOMOptionItems.Q, pSourcingQuotationBOMOptionItems.R, pSourcingQuotationBOMOptionItems.S, pSourcingQuotationBOMOptionItems.T, pSourcingQuotationBOMOptionItems.U, pSourcingQuotationBOMOptionItems.V, 
				pSourcingQuotationBOMOptionItems.W, pSourcingQuotationBOMOptionItems.X, pSourcingQuotationBOMOptionItems.Y, pSourcingQuotationBOMOptionItems.Z, pSourcingQuotationBOMOptionItems.Source, pSourcingQuotationBOMOptionItems.Notes, 
				pSourcingQuotationBOMOptionItems.Placement, pSourcingQuotationBOMOptionItems.VendorPrice, pSourcingQuotationBOMOptionItems.VolumePrice, pSourcingQuotationBOMOptionItems.VolumePriceMinimum, 
				pSourcingQuotationBOMOptionItems.VendorProductionMin, pSourcingQuotationBOMOptionItems.VendorProductionLeadTime, pSourcingQuotationBOMOptionItems.DetailYesNo, 
				pSourcingQuotationBOMOptionItems.ImageType, pSourcingQuotationBOMOptionItems.height, pSourcingQuotationBOMOptionItems.width, pSourcingQuotationBOMOptionItems.CDate, pSourcingQuotationBOMOptionItems.CUser, 
				pSourcingQuotationBOMOptionItems.MDate, pSourcingQuotationBOMOptionItems.MUser, pSourcingQuotationBOMOptionItems.MChange, pSourcingQuotationBOMOptionItems.SChange, pSourcingQuotationBOMOptionItems.DChange, 
				pSourcingQuotationBOMOptionItems.CChange, pSourcingQuotationBOMOptionItems.Action, pSourcingQuotationBOMOptionItems.ColorPlacement, pSourcingQuotationBOMOptionItems.Artwork, 
				pSourcingQuotationBOMOptionItems.License, pSourcingQuotationBOMOptionItems.Colorway, pSourcingQuotationBOMOptionItems.MaterialSort, pSourcingQuotationBOMOptionItems.MaterialTrack, 
				pSourcingQuotationBOMOptionItems.MaterialLinked, pSourcingQuotationBOMOptionItems.MaterialDimension, pSourcingQuotationBOMOptionItems.MaterialLining, 
				MaterialSizeID = COALESCE(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') , 
				pSourcingQuotationBOMOptionItems.MaterialPackLabelGroupID, pSourcingQuotationBOMOptionItems.TradePartnerID, pSourcingQuotationBOMOptionItems.TradePartnerVendorID, 
				pSourcingQuotationBOMOptionItems.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
				@ImageServer + '/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImage,
				GroupName = case pSourcingQuotationBOMOptionItems.MainMaterial when 1 then
								'Main Material'
							else
								pComponentType.ComponentDescription
							end 
				, 0 AS MaterialDel, 
				@ImageServer + '/ImageStream.ashx?S=600&V=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS MaterialImage, 
				pStyleHeader.HeaderLocked
			FROM pSourcingQuotationBOMOptionItems 
				--INNER JOIN pMaterial ON pSourcingQuotationBOMOptionItems.MaterialID = pMaterial.MaterialID
				INNER JOIN pComponentType ON pSourcingQuotationBOMOptionItems.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pSourcingQuotationBOMOptionItems.StyleID
				LEFT OUTER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pMaterial ON pSourcingQuotationBOMOptionItems.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN pStyleBOMItem ON (pSourcingQuotationBOMOptionItems.StyleMaterialID = pStyleBOMItem.StyleMaterialID 
											  AND pSourcingQuotationBOMOptionItems.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId)
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
											  AND pmaterialcolor.MaterialcolorID=pStyleBOMItem.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
											 AND pMaterialsize.MaterialSizeId=pStyleBOMItem.MaterialDimension
			WHERE pSourcingQuotationBOMOptionItems.StyleOptionId = @StyleOptionID
			ORDER BY pSourcingQuotationBOMOptionItems.MainMaterial DESC, pComponentType.ComponentOrder, pSourcingQuotationBOMOptionItems.MaterialSort, 
				pSourcingQuotationBOMOptionItems.MaterialNo, pSourcingQuotationBOMOptionItems.MaterialName, pSourcingQuotationBOMOptionItems.StyleMaterialId,
				pStyleBOMItem.ItemDim1Name, pStyleBOMItem.ItemDim2Name, pStyleBOMItem.ItemDim3Name

		END

	END

END
ELSE  -- if BOM is linked to pMaterial
BEGIN

	IF (@StyleBOMDimensionItemId<>'') AND (@StyleBOMDimensionItemId<>'00000000-0000-0000-0000-000000000000')
	BEGIN

		SELECT pSourcingQuotationBOMOptionItems.StyleMaterialID, pSourcingQuotationBOMOptionItems.AutoColor, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
			ISNULL(pSourcingQuotationBOMOptionItems.MainMaterial,0) AS MainMaterial, pSourcingQuotationBOMOptionItems.Development, pSourcingQuotationBOMOptionItems.MiscColor, pSourcingQuotationBOMOptionItems.StyleSet, 
			pSourcingQuotationBOMOptionItems.StyleID, pSourcingQuotationBOMOptionItems.WorkFlowId,pSourcingQuotationBOMOptionItems.WorkflowItemID,pSourcingQuotationBOMOptionItems.StyleBOMDimensionId,
			pSourcingQuotationBOMOptionItems.Dim1TypeSel, pSourcingQuotationBOMOptionItems.Dim2TypeSel, pSourcingQuotationBOMOptionItems.Dim3TypeSel,
			pMaterial.UOM,UOM.UOM as "UOMValue", MaterialColorId = COALESCE(pStyleBOMItem.MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
			Qty = case COALESCE(pStyleBOMItem.MaterialQuantity,'0') when '0' then
					   COALESCE(pSourcingQuotationBOMOptionItems.Qty,'0')
				  else
					   COALESCE(pStyleBOMItem.MaterialQuantity,'0')
				  end,
			pSourcingQuotationBOMOptionItems.MaterialPrice, pSourcingQuotationBOMOptionItems.Ext, 
			pSourcingQuotationBOMOptionItems.MaterialSize, pSourcingQuotationBOMOptionItems.MaterialID, pSourcingQuotationBOMOptionItems.MaterialPlacement, 
			pSourcingQuotationBOMOptionItems.MaterialPlacementCode, pSourcingQuotationBOMOptionItems.MaterialPlacementDetail, pMaterial.MaterialImageID, 
			pMaterial.MaterialImageVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, 
			pSourcingQuotationBOMOptionItems.ComponentTypeID AS Expr1, pMaterial.MaterialType, pMaterial.MaterialNo, 
			pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, 
			pMaterial.E, pMaterial.F, pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, 
			pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, pMaterial.P, 
			pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, 
			pMaterial.W, pMaterial.X, pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.Notes, 
			pSourcingQuotationBOMOptionItems.Placement, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, 
			pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.DetailYesNo, 
			pSourcingQuotationBOMOptionItems.ImageType, pMaterial.height, pMaterial.width, pSourcingQuotationBOMOptionItems.CDate, pSourcingQuotationBOMOptionItems.CUser, 
			pSourcingQuotationBOMOptionItems.MDate, pSourcingQuotationBOMOptionItems.MUser, pSourcingQuotationBOMOptionItems.MChange, pSourcingQuotationBOMOptionItems.SChange, pSourcingQuotationBOMOptionItems.DChange, 
			pSourcingQuotationBOMOptionItems.CChange, pMaterial.Action, pSourcingQuotationBOMOptionItems.ColorPlacement, pSourcingQuotationBOMOptionItems.Artwork, 
			pSourcingQuotationBOMOptionItems.License, pSourcingQuotationBOMOptionItems.Colorway, pSourcingQuotationBOMOptionItems.MaterialSort, pSourcingQuotationBOMOptionItems.MaterialTrack, 
			pSourcingQuotationBOMOptionItems.MaterialLinked, pSourcingQuotationBOMOptionItems.MaterialDimension, pSourcingQuotationBOMOptionItems.MaterialLining, 
			MaterialSizeID = COALESCE(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') , 
			pSourcingQuotationBOMOptionItems.MaterialPackLabelGroupID, pMaterial.TradePartnerID, pMaterial.TradePartnerVendorID, uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,
			pSourcingQuotationBOMOptionItems.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
			pMaterialsize.MaterialPrice as MPrice,
			pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage  ,
			GroupName = case pSourcingQuotationBOMOptionItems.MainMaterial when 1 then
					'Main Material'
				else
					pComponentType.ComponentDescription
				end
			, 0 AS MaterialDel, 
			'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
			pStyleHeader.HeaderLocked
		FROM pSourcingQuotationBOMOptionItems 		
			INNER JOIN pComponentType ON pSourcingQuotationBOMOptionItems.MaterialType = pComponentType.ComponentTypeID 
			--INNER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
			INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pSourcingQuotationBOMOptionItems.StyleID
			LEFT OUTER JOIN pMaterial ON pSourcingQuotationBOMOptionItems.MaterialID = pMaterial.MaterialID
			LEFT OUTER JOIN UOM ON pMaterial.UOM = UOM.UOMvalue
			LEFT OUTER JOIN pStyleBOMItem ON (pSourcingQuotationBOMOptionItems.StyleMaterialID = pStyleBOMItem.StyleMaterialID 
											  AND pSourcingQuotationBOMOptionItems.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId
											  AND pStyleBOMItem.StyleBOMDimensionItemId=@StyleBOMDimensionItemId)
			LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
			and pmaterialcolor.MaterialcolorID=pStyleBOMItem.MaterialColorId
			LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
			LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pStyleBOMItem.MaterialDimension
			LEFT OUTER JOIN uTradePartner ON pMaterial.TradePartnerID = uTradePartner.TradePartnerID
			LEFT OUTER JOIN uTradePartnerVendor ON pMaterial.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
		WHERE pSourcingQuotationBOMOptionItems.StyleOptionId = @StyleOptionID
		ORDER BY pSourcingQuotationBOMOptionItems.MainMaterial DESC, pComponentType.ComponentOrder, 
			pSourcingQuotationBOMOptionItems.MaterialSort, pMaterial.MaterialNo, pMaterial.MaterialName, pSourcingQuotationBOMOptionItems.StyleMaterialId

	END
	ELSE
	BEGIN

		IF (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'') AND (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'00000000-0000-0000-0000-000000000000')
		BEGIN

			SELECT pSourcingQuotationBOMOptionItems.StyleMaterialID, pSourcingQuotationBOMOptionItems.AutoColor,pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pSourcingQuotationBOMOptionItems.MainMaterial,0) AS MainMaterial, pSourcingQuotationBOMOptionItems.Development, pSourcingQuotationBOMOptionItems.MiscColor, pSourcingQuotationBOMOptionItems.StyleSet, 
				pSourcingQuotationBOMOptionItems.StyleID, pSourcingQuotationBOMOptionItems.WorkFlowId,pSourcingQuotationBOMOptionItems.WorkflowItemID,pSourcingQuotationBOMOptionItems.StyleBOMDimensionId,
				pSourcingQuotationBOMOptionItems.Dim1TypeSel, pSourcingQuotationBOMOptionItems.Dim2TypeSel, pSourcingQuotationBOMOptionItems.Dim3TypeSel,
				pMaterial.UOM,UOM.UOM as "UOMValue", MaterialColorId=COALESCE(pSourcingQuotationBOMOptionItems.MaterialColorId,'00000000-0000-0000-0000-000000000000'), 
				pSourcingQuotationBOMOptionItems.Qty , pSourcingQuotationBOMOptionItems.MaterialPrice, pSourcingQuotationBOMOptionItems.Ext, 
				pSourcingQuotationBOMOptionItems.MaterialSize, pSourcingQuotationBOMOptionItems.MaterialID, pSourcingQuotationBOMOptionItems.MaterialPlacement, 
				pSourcingQuotationBOMOptionItems.MaterialPlacementCode, pSourcingQuotationBOMOptionItems.MaterialPlacementDetail, pMaterial.MaterialImageID, 
				pMaterial.MaterialImageVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, 
				pSourcingQuotationBOMOptionItems.ComponentTypeID AS Expr1, pMaterial.MaterialType, pMaterial.MaterialNo, 
				pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, 
				pMaterial.E, pMaterial.F, pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, 
				pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, pMaterial.P, 
				pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, 
				pMaterial.W, pMaterial.X, pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.Notes, 
				pSourcingQuotationBOMOptionItems.Placement, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, 
				pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.DetailYesNo, 
				pSourcingQuotationBOMOptionItems.ImageType, pMaterial.height, pMaterial.width, pSourcingQuotationBOMOptionItems.CDate, pSourcingQuotationBOMOptionItems.CUser, 
				pSourcingQuotationBOMOptionItems.MDate, pSourcingQuotationBOMOptionItems.MUser, pSourcingQuotationBOMOptionItems.MChange, pSourcingQuotationBOMOptionItems.SChange, pSourcingQuotationBOMOptionItems.DChange, 
				pSourcingQuotationBOMOptionItems.CChange, pMaterial.Action, pSourcingQuotationBOMOptionItems.ColorPlacement, pSourcingQuotationBOMOptionItems.Artwork, 
				pSourcingQuotationBOMOptionItems.License, pSourcingQuotationBOMOptionItems.Colorway, pSourcingQuotationBOMOptionItems.MaterialSort, pSourcingQuotationBOMOptionItems.MaterialTrack, 
				pSourcingQuotationBOMOptionItems.MaterialLinked, pSourcingQuotationBOMOptionItems.MaterialDimension, pSourcingQuotationBOMOptionItems.MaterialLining, 
				MaterialSizeID = COALESCE(pSourcingQuotationBOMOptionItems.MaterialSizeID,'00000000-0000-0000-0000-000000000000'), 
				pSourcingQuotationBOMOptionItems.MaterialPackLabelGroupID, pMaterial.TradePartnerID, pMaterial.TradePartnerVendorID, uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,
				pSourcingQuotationBOMOptionItems.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage ,
				GroupName = case pSourcingQuotationBOMOptionItems.MainMaterial when 1 then
						'Main Material'
					  else
						pComponentType.ComponentDescription
					  end
				, 0 AS MaterialDel, 
				'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
				pStyleHeader.HeaderLocked
			FROM pSourcingQuotationBOMOptionItems 			
				INNER JOIN pComponentType ON pSourcingQuotationBOMOptionItems.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pSourcingQuotationBOMOptionItems.StyleID
				LEFT OUTER JOIN pMaterial ON pSourcingQuotationBOMOptionItems.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN UOM ON pMaterial.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
				and pmaterialcolor.MaterialcolorID=pSourcingQuotationBOMOptionItems.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pSourcingQuotationBOMOptionItems.MaterialSizeId
				LEFT OUTER JOIN uTradePartner ON pMaterial.TradePartnerID = uTradePartner.TradePartnerID
				LEFT OUTER JOIN uTradePartnerVendor ON pMaterial.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
			WHERE pSourcingQuotationBOMOptionItems.StyleOptionId = @StyleOptionID
			ORDER BY pSourcingQuotationBOMOptionItems.MainMaterial DESC, pComponentType.ComponentOrder, 
				pSourcingQuotationBOMOptionItems.MaterialSort, pMaterial.MaterialNo, pMaterial.MaterialName, pSourcingQuotationBOMOptionItems.StyleMaterialId

		END
		ELSE
		BEGIN

			-- This is mainly for the Material web service so that it can get all combinations for a particular WorkflowItemID.

			SELECT pSourcingQuotationBOMOptionItems.StyleMaterialID, pSourcingQuotationBOMOptionItems.AutoColor, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pSourcingQuotationBOMOptionItems.MainMaterial,0) AS MainMaterial, pSourcingQuotationBOMOptionItems.Development, pSourcingQuotationBOMOptionItems.MiscColor, pSourcingQuotationBOMOptionItems.StyleSet, 
				pSourcingQuotationBOMOptionItems.StyleID, pSourcingQuotationBOMOptionItems.WorkFlowId,pSourcingQuotationBOMOptionItems.WorkflowItemID,pSourcingQuotationBOMOptionItems.StyleBOMDimensionId,
				pSourcingQuotationBOMOptionItems.Dim1TypeSel, pSourcingQuotationBOMOptionItems.Dim2TypeSel, pSourcingQuotationBOMOptionItems.Dim3TypeSel,
				pMaterial.UOM,UOM.UOM as "UOMValue", MaterialColorId = COALESCE(pStyleBOMItem.MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
				pStyleBOMItem.ItemDim1Id, pStyleBOMItem.ItemDim2Id, pStyleBOMItem.ItemDim3Id,
				Qty = case COALESCE(pStyleBOMItem.MaterialQuantity,'0') when '0' then
						   COALESCE(pSourcingQuotationBOMOptionItems.Qty,'0')
					  else
						   COALESCE(pStyleBOMItem.MaterialQuantity,'0')
					  end,
				pSourcingQuotationBOMOptionItems.MaterialPrice, pSourcingQuotationBOMOptionItems.Ext, 
				pSourcingQuotationBOMOptionItems.MaterialSize, pSourcingQuotationBOMOptionItems.MaterialID, pSourcingQuotationBOMOptionItems.MaterialPlacement, 
				pSourcingQuotationBOMOptionItems.MaterialPlacementCode, pSourcingQuotationBOMOptionItems.MaterialPlacementDetail, pMaterial.MaterialImageID, 
				pMaterial.MaterialImageVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, 
				pSourcingQuotationBOMOptionItems.ComponentTypeID AS Expr1, pMaterial.MaterialType, pMaterial.MaterialNo, 
				pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, 
				pMaterial.E, pMaterial.F, pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, 
				pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, pMaterial.P, 
				pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, 
				pMaterial.W, pMaterial.X, pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.Notes, 
				pSourcingQuotationBOMOptionItems.Placement, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, 
				pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.DetailYesNo, 
				pSourcingQuotationBOMOptionItems.ImageType, pMaterial.height, pMaterial.width, pSourcingQuotationBOMOptionItems.CDate, pSourcingQuotationBOMOptionItems.CUser, 
				pSourcingQuotationBOMOptionItems.MDate, pSourcingQuotationBOMOptionItems.MUser, pSourcingQuotationBOMOptionItems.MChange, pSourcingQuotationBOMOptionItems.SChange, pSourcingQuotationBOMOptionItems.DChange, 
				pSourcingQuotationBOMOptionItems.CChange, pMaterial.Action, pSourcingQuotationBOMOptionItems.ColorPlacement, pSourcingQuotationBOMOptionItems.Artwork, 
				pSourcingQuotationBOMOptionItems.License, pSourcingQuotationBOMOptionItems.Colorway, pSourcingQuotationBOMOptionItems.MaterialSort, pSourcingQuotationBOMOptionItems.MaterialTrack, 
				pSourcingQuotationBOMOptionItems.MaterialLinked, pSourcingQuotationBOMOptionItems.MaterialDimension, pSourcingQuotationBOMOptionItems.MaterialLining, 
				MaterialSizeID = COALESCE(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') , 
				pSourcingQuotationBOMOptionItems.MaterialPackLabelGroupID, pMaterial.TradePartnerID, pMaterial.TradePartnerVendorID, uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,
				pSourcingQuotationBOMOptionItems.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
				@ImageServer + '/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImage,
				GroupName = case pSourcingQuotationBOMOptionItems.MainMaterial when 1 then
								'Main Material'
							else
								pComponentType.ComponentDescription
							end 
				, 0 AS MaterialDel, 
				@ImageServer + '/ImageStream.ashx?S=600&V=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pSourcingQuotationBOMOptionItems.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS MaterialImage, 
				pStyleHeader.HeaderLocked
			FROM pSourcingQuotationBOMOptionItems 
				--INNER JOIN pMaterial ON pSourcingQuotationBOMOptionItems.MaterialID = pMaterial.MaterialID
				INNER JOIN pComponentType ON pSourcingQuotationBOMOptionItems.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pSourcingQuotationBOMOptionItems.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pSourcingQuotationBOMOptionItems.StyleID
				LEFT OUTER JOIN pMaterial ON pSourcingQuotationBOMOptionItems.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN UOM ON pMaterial.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pStyleBOMItem ON (pSourcingQuotationBOMOptionItems.StyleMaterialID = pStyleBOMItem.StyleMaterialID 
											  AND pSourcingQuotationBOMOptionItems.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId)
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
											  AND pmaterialcolor.MaterialcolorID=pStyleBOMItem.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
											 AND pMaterialsize.MaterialSizeId=pStyleBOMItem.MaterialDimension
				LEFT OUTER JOIN uTradePartner ON pMaterial.TradePartnerID = uTradePartner.TradePartnerID
				LEFT OUTER JOIN uTradePartnerVendor ON pMaterial.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
			WHERE pSourcingQuotationBOMOptionItems.StyleOptionId = @StyleOptionID
			ORDER BY pSourcingQuotationBOMOptionItems.MainMaterial DESC, pComponentType.ComponentOrder, pSourcingQuotationBOMOptionItems.MaterialSort, 
				pMaterial.MaterialNo, pMaterial.MaterialName, pSourcingQuotationBOMOptionItems.StyleMaterialId,
				pStyleBOMItem.ItemDim1Name, pStyleBOMItem.ItemDim2Name, pStyleBOMItem.ItemDim3Name

		END

	END

END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04411', GetDate())
GO