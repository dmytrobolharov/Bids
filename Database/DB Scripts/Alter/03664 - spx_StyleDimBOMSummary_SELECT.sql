IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDimBOMSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDimBOMSummary_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleDimBOMSummary_SELECT]
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkFlowId uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleBOMDimensionId uniqueidentifier,
	@StyleBOMDimensionItemId nvarchar(50),
	@LinkedToMaterialTable int = 0
)
AS  

/*Get Image Server path portion.*/
DECLARE @ImageServer nvarchar(255)
SET @ImageServer = (SELECT TOP 1 AppSettingValue FROM sAppSetting WHERE UPPER(ConfigFileName) = UPPER('Server.config') AND UPPER(AppSettingKey) = UPPER('ImageServer'))


IF @LinkedToMaterialTable = 0  -- if BOM is not linked to pMaterial
BEGIN

	IF (@StyleBOMDimensionItemId<>'') AND (@StyleBOMDimensionItemId<>'00000000-0000-0000-0000-000000000000')
	BEGIN

		SELECT pStyleBOM.StyleMaterialID, pStyleBOM.AutoColor, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
			ISNULL(pStyleBOM.MainMaterial,0) AS MainMaterial, pStyleBOM.Development, pStyleBOM.MiscColor, pStyleBOM.StyleSet, 
			pStyleBOM.StyleID, pStyleBOM.WorkFlowId,pStyleBOM.WorkflowItemID,pStyleBOM.StyleBOMDimensionId,
			pStyleBOM.Dim1TypeSel, pStyleBOM.Dim2TypeSel, pStyleBOM.Dim3TypeSel,
			pStyleBOM.UOM,UOM.UOM as "UOMValue", MaterialColorId = COALESCE(pStyleBOMItem.MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
			Qty = case COALESCE(pStyleBOMItem.MaterialQuantity,'0') when '0' then
					   COALESCE(pStyleBOM.Qty,'0')
				  else
					   COALESCE(pStyleBOMItem.MaterialQuantity,'0')
				  end,
			pStyleBOM.MaterialPrice, pStyleBOM.Ext, 
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
			MaterialSizeID = COALESCE(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') , 
			pStyleBOM.MaterialPackLabelGroupID, pStyleBOM.TradePartnerID, pStyleBOM.TradePartnerVendorID, 
			pStyleBOM.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
			pMaterialsize.MaterialPrice as MPrice,
			pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage  ,
			GroupName = case pStyleBOM.MainMaterial when 1 then
					'Main Material'
				else
					pComponentType.ComponentDescription
				end
			, 0 AS MaterialDel, 
			'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pStyleBOM.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOM.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
			pStyleHeader.HeaderLocked
		FROM pStyleBOM 		
			INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
			--INNER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
			INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pStyleBOM.StyleID
			LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
			LEFT OUTER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
			LEFT OUTER JOIN pStyleBOMItem ON (pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID 
											  AND pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId
											  AND pStyleBOMItem.StyleBOMDimensionItemId=@StyleBOMDimensionItemId)
			LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
			and pmaterialcolor.MaterialcolorID=pStyleBOMItem.MaterialColorId
			LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
			LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pStyleBOMItem.MaterialDimension
		WHERE pStyleBOM.StyleId = @StyleId 
			AND pStyleBOM.StyleSet = @StyleSet
			AND pStyleBOM.WorkFlowId = @WorkFlowId 
			AND pStyleBOM.WorkflowItemID = @WorkflowItemID
			AND pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId 
		ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, 
			pStyleBOM.MaterialSort, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, pStyleBOM.StyleMaterialId

	END
	ELSE
	BEGIN

		IF (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'') AND (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'00000000-0000-0000-0000-000000000000')
		BEGIN

			SELECT pStyleBOM.StyleMaterialID, pStyleBOM.AutoColor,pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pStyleBOM.MainMaterial,0) AS MainMaterial, pStyleBOM.Development, pStyleBOM.MiscColor, pStyleBOM.StyleSet, 
				pStyleBOM.StyleID, pStyleBOM.WorkFlowId,pStyleBOM.WorkflowItemID,pStyleBOM.StyleBOMDimensionId,
				pStyleBOM.Dim1TypeSel, pStyleBOM.Dim2TypeSel, pStyleBOM.Dim3TypeSel,
				pStyleBOM.UOM,UOM.UOM as "UOMValue", MaterialColorId=COALESCE(pStyleBOM.MaterialColorId,'00000000-0000-0000-0000-000000000000'), pStyleBOM.Qty , pStyleBOM.MaterialPrice, pStyleBOM.Ext, 
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
				pStyleBOM.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage ,
				GroupName = case pStyleBOM.MainMaterial when 1 then
						'Main Material'
					  else
						pComponentType.ComponentDescription
					  end
				, 0 AS MaterialDel, 
				'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pStyleBOM.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOM.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
				pStyleHeader.HeaderLocked
			FROM pStyleBOM 			
				INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pStyleBOM.StyleID
				LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
				and pmaterialcolor.MaterialcolorID=pStyleBOM.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pStyleBOM.MaterialSizeId
			WHERE pStyleBOM.StyleId = @StyleId 
				AND pStyleBOM.StyleSet = @StyleSet
				AND pStyleBOM.WorkFlowId = @WorkFlowId 
				AND pStyleBOM.WorkflowItemID = @WorkflowItemID
				AND pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId 
			ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, 
				pStyleBOM.MaterialSort, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, pStyleBOM.StyleMaterialId

		END
		ELSE
		BEGIN

			-- This is mainly for the Material web service so that it can get all combinations for a particular WorkflowItemID.

			SELECT pStyleBOM.StyleMaterialID, pStyleBOM.AutoColor, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pStyleBOM.MainMaterial,0) AS MainMaterial, pStyleBOM.Development, pStyleBOM.MiscColor, pStyleBOM.StyleSet, 
				pStyleBOM.StyleID, pStyleBOM.WorkFlowId,pStyleBOM.WorkflowItemID,pStyleBOM.StyleBOMDimensionId,
				pStyleBOM.Dim1TypeSel, pStyleBOM.Dim2TypeSel, pStyleBOM.Dim3TypeSel,
				pStyleBOM.UOM,UOM.UOM as "UOMValue", MaterialColorId = COALESCE(pStyleBOMItem.MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
				pStyleBOMItem.ItemDim1Id, pStyleBOMItem.ItemDim2Id, pStyleBOMItem.ItemDim3Id,
				Qty = case COALESCE(pStyleBOMItem.MaterialQuantity,'0') when '0' then
						   COALESCE(pStyleBOM.Qty,'0')
					  else
						   COALESCE(pStyleBOMItem.MaterialQuantity,'0')
					  end,
				pStyleBOM.MaterialPrice, pStyleBOM.Ext, 
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
				MaterialSizeID = COALESCE(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') , 
				pStyleBOM.MaterialPackLabelGroupID, pStyleBOM.TradePartnerID, pStyleBOM.TradePartnerVendorID, 
				pStyleBOM.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
				@ImageServer + '/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImage,
				GroupName = case pStyleBOM.MainMaterial when 1 then
								'Main Material'
							else
								pComponentType.ComponentDescription
							end 
				, 0 AS MaterialDel, 
				@ImageServer + '/ImageStream.ashx?S=600&V=' + CAST(ISNULL(pStyleBOM.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOM.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS MaterialImage, 
				pStyleHeader.HeaderLocked
			FROM pStyleBOM 
				--INNER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
				INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pStyleBOM.StyleID
				LEFT OUTER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN pStyleBOMItem ON (pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID 
											  AND pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId)
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
											  AND pmaterialcolor.MaterialcolorID=pStyleBOMItem.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
											 AND pMaterialsize.MaterialSizeId=pStyleBOMItem.MaterialDimension
			WHERE pStyleBOM.StyleId = @StyleId 
				AND pStyleBOM.StyleSet = @StyleSet
				AND pStyleBOM.WorkFlowId = @WorkFlowId 
				AND pStyleBOM.WorkflowItemID = @WorkflowItemID
			ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, pStyleBOM.MaterialSort, 
				pStyleBOM.MaterialNo, pStyleBOM.MaterialName, pStyleBOM.StyleMaterialId,
				pStyleBOMItem.ItemDim1Name, pStyleBOMItem.ItemDim2Name, pStyleBOMItem.ItemDim3Name

		END

	END

END
ELSE  -- if BOM is linked to pMaterial
BEGIN

	IF (@StyleBOMDimensionItemId<>'') AND (@StyleBOMDimensionItemId<>'00000000-0000-0000-0000-000000000000')
	BEGIN

		SELECT pStyleBOM.StyleMaterialID, pStyleBOM.AutoColor, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
			ISNULL(pStyleBOM.MainMaterial,0) AS MainMaterial, pStyleBOM.Development, pStyleBOM.MiscColor, pStyleBOM.StyleSet, 
			pStyleBOM.StyleID, pStyleBOM.WorkFlowId,pStyleBOM.WorkflowItemID,pStyleBOM.StyleBOMDimensionId,
			pStyleBOM.Dim1TypeSel, pStyleBOM.Dim2TypeSel, pStyleBOM.Dim3TypeSel,
			pMaterial.UOM,UOM.UOM as "UOMValue", MaterialColorId = COALESCE(pStyleBOMItem.MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
			Qty = case COALESCE(pStyleBOMItem.MaterialQuantity,'0') when '0' then
					   COALESCE(pStyleBOM.Qty,'0')
				  else
					   COALESCE(pStyleBOMItem.MaterialQuantity,'0')
				  end,
			pStyleBOM.MaterialPrice, pStyleBOM.Ext, 
			pStyleBOM.MaterialSize, pStyleBOM.MaterialID, pStyleBOM.MaterialPlacement, 
			pStyleBOM.MaterialPlacementCode, pStyleBOM.MaterialPlacementDetail, pMaterial.MaterialImageID, 
			pMaterial.MaterialImageVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, 
			pStyleBOM.ComponentTypeID AS Expr1, pMaterial.MaterialType, pMaterial.MaterialNo, 
			pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, 
			pMaterial.E, pMaterial.F, pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, 
			pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, pMaterial.P, 
			pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, 
			pMaterial.W, pMaterial.X, pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.Notes, 
			pStyleBOM.Placement, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, 
			pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.DetailYesNo, 
			pStyleBOM.ImageType, pMaterial.height, pMaterial.width, pStyleBOM.CDate, pStyleBOM.CUser, 
			pStyleBOM.MDate, pStyleBOM.MUser, pStyleBOM.MChange, pStyleBOM.SChange, pStyleBOM.DChange, 
			pStyleBOM.CChange, pMaterial.Action, pStyleBOM.ColorPlacement, pStyleBOM.Artwork, 
			pStyleBOM.License, pStyleBOM.Colorway, pStyleBOM.MaterialSort, pStyleBOM.MaterialTrack, 
			pStyleBOM.MaterialLinked, pStyleBOM.MaterialDimension, pStyleBOM.MaterialLining, 
			MaterialSizeID = COALESCE(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') , 
			pStyleBOM.MaterialPackLabelGroupID, pMaterial.TradePartnerID, pMaterial.TradePartnerVendorID, uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,
			pStyleBOM.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
			pMaterialsize.MaterialPrice as MPrice,
			pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage  ,
			GroupName = case pStyleBOM.MainMaterial when 1 then
					'Main Material'
				else
					pComponentType.ComponentDescription
				end
			, 0 AS MaterialDel, 
			'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pStyleBOM.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOM.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
			pStyleHeader.HeaderLocked
		FROM pStyleBOM 		
			INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
			--INNER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
			INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pStyleBOM.StyleID
			LEFT OUTER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
			LEFT OUTER JOIN UOM ON pMaterial.UOM = UOM.UOMvalue
			LEFT OUTER JOIN pStyleBOMItem ON (pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID 
											  AND pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId
											  AND pStyleBOMItem.StyleBOMDimensionItemId=@StyleBOMDimensionItemId)
			LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
			and pmaterialcolor.MaterialcolorID=pStyleBOMItem.MaterialColorId
			LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
			LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pStyleBOMItem.MaterialDimension
			LEFT OUTER JOIN uTradePartner ON pMaterial.TradePartnerID = uTradePartner.TradePartnerID
			LEFT OUTER JOIN uTradePartnerVendor ON pMaterial.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
		WHERE pStyleBOM.StyleId = @StyleId 
			AND pStyleBOM.StyleSet = @StyleSet
			AND pStyleBOM.WorkFlowId = @WorkFlowId 
			AND pStyleBOM.WorkflowItemID = @WorkflowItemID
			AND pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId 
		ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, 
			pStyleBOM.MaterialSort, pMaterial.MaterialNo, pMaterial.MaterialName, pStyleBOM.StyleMaterialId

	END
	ELSE
	BEGIN

		IF (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'') AND (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'00000000-0000-0000-0000-000000000000')
		BEGIN

			SELECT pStyleBOM.StyleMaterialID, pStyleBOM.AutoColor,pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pStyleBOM.MainMaterial,0) AS MainMaterial, pStyleBOM.Development, pStyleBOM.MiscColor, pStyleBOM.StyleSet, 
				pStyleBOM.StyleID, pStyleBOM.WorkFlowId,pStyleBOM.WorkflowItemID,pStyleBOM.StyleBOMDimensionId,
				pStyleBOM.Dim1TypeSel, pStyleBOM.Dim2TypeSel, pStyleBOM.Dim3TypeSel,
				pMaterial.UOM,UOM.UOM as "UOMValue", MaterialColorId=COALESCE(pStyleBOM.MaterialColorId,'00000000-0000-0000-0000-000000000000'), 
				pStyleBOM.Qty , pStyleBOM.MaterialPrice, pStyleBOM.Ext, 
				pStyleBOM.MaterialSize, pStyleBOM.MaterialID, pStyleBOM.MaterialPlacement, 
				pStyleBOM.MaterialPlacementCode, pStyleBOM.MaterialPlacementDetail, pMaterial.MaterialImageID, 
				pMaterial.MaterialImageVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, 
				pStyleBOM.ComponentTypeID AS Expr1, pMaterial.MaterialType, pMaterial.MaterialNo, 
				pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, 
				pMaterial.E, pMaterial.F, pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, 
				pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, pMaterial.P, 
				pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, 
				pMaterial.W, pMaterial.X, pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.Notes, 
				pStyleBOM.Placement, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, 
				pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.DetailYesNo, 
				pStyleBOM.ImageType, pMaterial.height, pMaterial.width, pStyleBOM.CDate, pStyleBOM.CUser, 
				pStyleBOM.MDate, pStyleBOM.MUser, pStyleBOM.MChange, pStyleBOM.SChange, pStyleBOM.DChange, 
				pStyleBOM.CChange, pMaterial.Action, pStyleBOM.ColorPlacement, pStyleBOM.Artwork, 
				pStyleBOM.License, pStyleBOM.Colorway, pStyleBOM.MaterialSort, pStyleBOM.MaterialTrack, 
				pStyleBOM.MaterialLinked, pStyleBOM.MaterialDimension, pStyleBOM.MaterialLining, 
				MaterialSizeID = COALESCE(pStyleBOM.MaterialSizeID,'00000000-0000-0000-0000-000000000000'), 
				pStyleBOM.MaterialPackLabelGroupID, pMaterial.TradePartnerID, pMaterial.TradePartnerVendorID, uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,
				pStyleBOM.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage ,
				GroupName = case pStyleBOM.MainMaterial when 1 then
						'Main Material'
					  else
						pComponentType.ComponentDescription
					  end
				, 0 AS MaterialDel, 
				'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pStyleBOM.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOM.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
				pStyleHeader.HeaderLocked
			FROM pStyleBOM 			
				INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pStyleBOM.StyleID
				LEFT OUTER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN UOM ON pMaterial.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
				and pmaterialcolor.MaterialcolorID=pStyleBOM.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pStyleBOM.MaterialSizeId
				LEFT OUTER JOIN uTradePartner ON pMaterial.TradePartnerID = uTradePartner.TradePartnerID
				LEFT OUTER JOIN uTradePartnerVendor ON pMaterial.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
			WHERE pStyleBOM.StyleId = @StyleId 
				AND pStyleBOM.StyleSet = @StyleSet
				AND pStyleBOM.WorkFlowId = @WorkFlowId 
				AND pStyleBOM.WorkflowItemID = @WorkflowItemID
				AND pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId 
			ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, 
				pStyleBOM.MaterialSort, pMaterial.MaterialNo, pMaterial.MaterialName, pStyleBOM.StyleMaterialId

		END
		ELSE
		BEGIN

			-- This is mainly for the Material web service so that it can get all combinations for a particular WorkflowItemID.

			SELECT pStyleBOM.StyleMaterialID, pStyleBOM.AutoColor, pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pStyleBOM.MainMaterial,0) AS MainMaterial, pStyleBOM.Development, pStyleBOM.MiscColor, pStyleBOM.StyleSet, 
				pStyleBOM.StyleID, pStyleBOM.WorkFlowId,pStyleBOM.WorkflowItemID,pStyleBOM.StyleBOMDimensionId,
				pStyleBOM.Dim1TypeSel, pStyleBOM.Dim2TypeSel, pStyleBOM.Dim3TypeSel,
				pMaterial.UOM,UOM.UOM as "UOMValue", MaterialColorId = COALESCE(pStyleBOMItem.MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
				pStyleBOMItem.ItemDim1Id, pStyleBOMItem.ItemDim2Id, pStyleBOMItem.ItemDim3Id,
				Qty = case COALESCE(pStyleBOMItem.MaterialQuantity,'0') when '0' then
						   COALESCE(pStyleBOM.Qty,'0')
					  else
						   COALESCE(pStyleBOMItem.MaterialQuantity,'0')
					  end,
				pStyleBOM.MaterialPrice, pStyleBOM.Ext, 
				pStyleBOM.MaterialSize, pStyleBOM.MaterialID, pStyleBOM.MaterialPlacement, 
				pStyleBOM.MaterialPlacementCode, pStyleBOM.MaterialPlacementDetail, pMaterial.MaterialImageID, 
				pMaterial.MaterialImageVersion, pMaterial.NoColorMatch, pMaterial.SupplierID, 
				pStyleBOM.ComponentTypeID AS Expr1, pMaterial.MaterialType, pMaterial.MaterialNo, 
				pMaterial.MaterialName, pMaterial.A, pMaterial.B, pMaterial.C, pMaterial.D, 
				pMaterial.E, pMaterial.F, pMaterial.G, pMaterial.H, pMaterial.I, pMaterial.J, 
				pMaterial.K, pMaterial.L, pMaterial.M, pMaterial.N, pMaterial.O, pMaterial.P, 
				pMaterial.Q, pMaterial.R, pMaterial.S, pMaterial.T, pMaterial.U, pMaterial.V, 
				pMaterial.W, pMaterial.X, pMaterial.Y, pMaterial.Z, pMaterial.Source, pMaterial.Notes, 
				pStyleBOM.Placement, pMaterial.VendorPrice, pMaterial.VolumePrice, pMaterial.VolumePriceMinimum, 
				pMaterial.VendorProductionMin, pMaterial.VendorProductionLeadTime, pMaterial.DetailYesNo, 
				pStyleBOM.ImageType, pMaterial.height, pMaterial.width, pStyleBOM.CDate, pStyleBOM.CUser, 
				pStyleBOM.MDate, pStyleBOM.MUser, pStyleBOM.MChange, pStyleBOM.SChange, pStyleBOM.DChange, 
				pStyleBOM.CChange, pMaterial.Action, pStyleBOM.ColorPlacement, pStyleBOM.Artwork, 
				pStyleBOM.License, pStyleBOM.Colorway, pStyleBOM.MaterialSort, pStyleBOM.MaterialTrack, 
				pStyleBOM.MaterialLinked, pStyleBOM.MaterialDimension, pStyleBOM.MaterialLining, 
				MaterialSizeID = COALESCE(pStyleBOMItem.MaterialDimension,'00000000-0000-0000-0000-000000000000') , 
				pStyleBOM.MaterialPackLabelGroupID, pMaterial.TradePartnerID, pMaterial.TradePartnerVendorID, uTradePartner.TradePartnerName, uTradePartnerVendor.VendorName,
				pStyleBOM.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
				@ImageServer + '/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS ColorImage,
				GroupName = case pStyleBOM.MainMaterial when 1 then
								'Main Material'
							else
								pComponentType.ComponentDescription
							end 
				, 0 AS MaterialDel, 
				@ImageServer + '/ImageStream.ashx?S=600&V=' + CAST(ISNULL(pStyleBOM.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOM.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) AS MaterialImage, 
				pStyleHeader.HeaderLocked
			FROM pStyleBOM 
				--INNER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
				INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pStyleBOM.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pStyleBOM.StyleID
				LEFT OUTER JOIN pMaterial ON pStyleBOM.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN UOM ON pMaterial.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pStyleBOMItem ON (pStyleBOM.StyleMaterialID = pStyleBOMItem.StyleMaterialID 
											  AND pStyleBOM.StyleBOMDimensionId = pStyleBOMItem.StyleBOMDimensionId)
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
											  AND pmaterialcolor.MaterialcolorID=pStyleBOMItem.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
											 AND pMaterialsize.MaterialSizeId=pStyleBOMItem.MaterialDimension
				LEFT OUTER JOIN uTradePartner ON pMaterial.TradePartnerID = uTradePartner.TradePartnerID
				LEFT OUTER JOIN uTradePartnerVendor ON pMaterial.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
			WHERE pStyleBOM.StyleId = @StyleId 
				AND pStyleBOM.StyleSet = @StyleSet
				AND pStyleBOM.WorkFlowId = @WorkFlowId 
				AND pStyleBOM.WorkflowItemID = @WorkflowItemID
			ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, pStyleBOM.MaterialSort, 
				pMaterial.MaterialNo, pMaterial.MaterialName, pStyleBOM.StyleMaterialId,
				pStyleBOMItem.ItemDim1Name, pStyleBOMItem.ItemDim2Name, pStyleBOMItem.ItemDim3Name

		END

	END

END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03664', GetDate())
GO