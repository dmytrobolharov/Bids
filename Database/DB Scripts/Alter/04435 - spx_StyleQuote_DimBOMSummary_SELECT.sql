/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_DimBOMSummary_SELECT]    Script Date: 11/20/2012 17:25:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuote_DimBOMSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuote_DimBOMSummary_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_DimBOMSummary_SELECT]    Script Date: 11/20/2012 17:25:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




create PROCEDURE [dbo].[spx_StyleQuote_DimBOMSummary_SELECT]
(
	@StyleQuoteItemID uniqueidentifier,
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
		@StyleBOMDimensionId uniqueidentifier
		
		
SELECT top 1
	@StyleId = StyleID,
	@StyleSet = StyleSet,
	@WorkFlowId = WorkFlowID,
	@WorkflowItemID = WorkFlowItemID,
	@StyleBOMDimensionId = StyleBOMDimensionID
FROM pSourcingQuoteStyleBOM WHERE StyleQuoteItemID = @StyleQuoteItemID




		IF (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'') AND (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'00000000-0000-0000-0000-000000000000')
		BEGIN

			SELECT pSourcingQuotationBOMMaterials.StyleMaterialID, pSourcingQuotationBOMMaterials.AutoColor,pComponentType.ComponentTypeID, pComponentType.ComponentDescription, 
				ISNULL(pSourcingQuotationBOMMaterials.MainMaterial,0) AS MainMaterial, pSourcingQuotationBOMMaterials.Development, pSourcingQuotationBOMMaterials.MiscColor, pSourcingQuotationBOMMaterials.StyleSet, 
				pSourcingQuotationBOMMaterials.StyleID, pSourcingQuotationBOMMaterials.WorkFlowId,pSourcingQuotationBOMMaterials.WorkflowItemID,pSourcingQuotationBOMMaterials.StyleBOMDimensionId,
				pSourcingQuotationBOMMaterials.Dim1TypeSel, pSourcingQuotationBOMMaterials.Dim2TypeSel, pSourcingQuotationBOMMaterials.Dim3TypeSel,
				pSourcingQuotationBOMMaterials.UOM,UOM.UOM as "UOMValue", MaterialColorId=COALESCE(pSourcingQuotationBOMMaterials.MaterialColorId,'00000000-0000-0000-0000-000000000000'), pSourcingQuotationBOMMaterials.Qty , pSourcingQuotationBOMMaterials.MaterialPrice, pSourcingQuotationBOMMaterials.Ext, 
				pSourcingQuotationBOMMaterials.MaterialSize, pSourcingQuotationBOMMaterials.MaterialID, pSourcingQuotationBOMMaterials.MaterialPlacement, 
				pSourcingQuotationBOMMaterials.MaterialPlacementCode, pSourcingQuotationBOMMaterials.MaterialPlacementDetail, pSourcingQuotationBOMMaterials.MaterialImageID, 
				pSourcingQuotationBOMMaterials.MaterialImageVersion, pSourcingQuotationBOMMaterials.NoColorMatch, pSourcingQuotationBOMMaterials.SupplierID, 
				pSourcingQuotationBOMMaterials.ComponentTypeID AS Expr1, pSourcingQuotationBOMMaterials.MaterialType, pSourcingQuotationBOMMaterials.MaterialNo, 
				pSourcingQuotationBOMMaterials.MaterialName, pSourcingQuotationBOMMaterials.A, pSourcingQuotationBOMMaterials.B, pSourcingQuotationBOMMaterials.C, pSourcingQuotationBOMMaterials.D, 
				pSourcingQuotationBOMMaterials.E, pSourcingQuotationBOMMaterials.F, pSourcingQuotationBOMMaterials.G, pSourcingQuotationBOMMaterials.H, pSourcingQuotationBOMMaterials.I, pSourcingQuotationBOMMaterials.J, 
				pSourcingQuotationBOMMaterials.K, pSourcingQuotationBOMMaterials.L, pSourcingQuotationBOMMaterials.M, pSourcingQuotationBOMMaterials.N, pSourcingQuotationBOMMaterials.O, pSourcingQuotationBOMMaterials.P, 
				pSourcingQuotationBOMMaterials.Q, pSourcingQuotationBOMMaterials.R, pSourcingQuotationBOMMaterials.S, pSourcingQuotationBOMMaterials.T, pSourcingQuotationBOMMaterials.U, pSourcingQuotationBOMMaterials.V, 
				pSourcingQuotationBOMMaterials.W, pSourcingQuotationBOMMaterials.X, pSourcingQuotationBOMMaterials.Y, pSourcingQuotationBOMMaterials.Z, pSourcingQuotationBOMMaterials.Source, pSourcingQuotationBOMMaterials.Notes, 
				pSourcingQuotationBOMMaterials.Placement, pSourcingQuotationBOMMaterials.VendorPrice, pSourcingQuotationBOMMaterials.VolumePrice, pSourcingQuotationBOMMaterials.VolumePriceMinimum, 
				pSourcingQuotationBOMMaterials.VendorProductionMin, pSourcingQuotationBOMMaterials.VendorProductionLeadTime, pSourcingQuotationBOMMaterials.DetailYesNo, 
				pSourcingQuotationBOMMaterials.ImageType, pSourcingQuotationBOMMaterials.height, pSourcingQuotationBOMMaterials.width, pSourcingQuotationBOMMaterials.CDate, pSourcingQuotationBOMMaterials.CUser, 
				pSourcingQuotationBOMMaterials.MDate, pSourcingQuotationBOMMaterials.MUser, pSourcingQuotationBOMMaterials.MChange, pSourcingQuotationBOMMaterials.SChange, pSourcingQuotationBOMMaterials.DChange, 
				pSourcingQuotationBOMMaterials.CChange, pSourcingQuotationBOMMaterials.Action, pSourcingQuotationBOMMaterials.ColorPlacement, pSourcingQuotationBOMMaterials.Artwork, 
				pSourcingQuotationBOMMaterials.License, pSourcingQuotationBOMMaterials.Colorway, pSourcingQuotationBOMMaterials.MaterialSort, pSourcingQuotationBOMMaterials.MaterialTrack, 
				pSourcingQuotationBOMMaterials.MaterialLinked, pSourcingQuotationBOMMaterials.MaterialDimension, pSourcingQuotationBOMMaterials.MaterialLining, 
				MaterialSizeID = COALESCE(pSourcingQuotationBOMMaterials.MaterialSizeID,'00000000-0000-0000-0000-000000000000'), 
				pSourcingQuotationBOMMaterials.MaterialPackLabelGroupID, pSourcingQuotationBOMMaterials.TradePartnerID, pSourcingQuotationBOMMaterials.TradePartnerVendorID, 
				pSourcingQuotationBOMMaterials.MaterialBOM, pComponentType.ComponentOrder, pMaterialsize.MaterialSize as MSize, 
				pMaterialsize.MaterialPrice as MPrice,pSourcingQuotationBOMMaterials.StyleQuoteItemID,
				pColorPalette.ColorPaletteID, pColorPalette.ColorFolderID,  pColorPalette.ColorCode, pColorPalette.ColorName,
			'<img src=''../System/Control/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage ,
				GroupName = case pSourcingQuotationBOMMaterials.MainMaterial when 1 then
						'Main Material'
					  else
						pComponentType.ComponentDescription
					  end
				, 0 AS MaterialDel, 
				'<img src=''../System/Control/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pSourcingQuotationBOMMaterials.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pSourcingQuotationBOMMaterials.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
				pStyleHeader.HeaderLocked, pSourcingQuotationBOMMaterials.Comments
			FROM pSourcingQuotationBOMMaterials 			
				INNER JOIN pComponentType ON pSourcingQuotationBOMMaterials.MaterialType = pComponentType.ComponentTypeID 
				--INNER JOIN UOM ON pSourcingQuotationBOMMaterials.UOM = UOM.UOMvalue
				INNER JOIN pStyleHeader ON pStyleHeader.StyleID = pSourcingQuotationBOMMaterials.StyleID
				LEFT OUTER JOIN UOM ON pSourcingQuotationBOMMaterials.UOM = UOM.UOMvalue
				LEFT OUTER JOIN pMaterial ON pSourcingQuotationBOMMaterials.MaterialID = pMaterial.MaterialID
				LEFT OUTER JOIN pmaterialcolor ON pMaterial.MaterialID = pmaterialcolor.MaterialID
				and pmaterialcolor.MaterialcolorID=pSourcingQuotationBOMMaterials.MaterialColorId
				LEFT OUTER JOIN pColorPalette ON pColorPalette.ColorPaletteID = pmaterialcolor.ColorPaletteID
				LEFT OUTER JOIN pMaterialsize ON pMaterial.MaterialID = pMaterialsize.MaterialID
			and pMaterialsize.MaterialSizeId=pSourcingQuotationBOMMaterials.MaterialSizeId
			WHERE pSourcingQuotationBOMMaterials.StyleId = @StyleId 
				AND pSourcingQuotationBOMMaterials.StyleSet = @StyleSet
				AND pSourcingQuotationBOMMaterials.WorkFlowId = @WorkFlowId 
				AND pSourcingQuotationBOMMaterials.WorkflowItemID = @WorkflowItemID
				AND pSourcingQuotationBOMMaterials.StyleBOMDimensionId = @StyleBOMDimensionId 
				and pSourcingQuotationBOMMaterials.StyleQuoteItemID = @StyleQuoteItemID
			ORDER BY pSourcingQuotationBOMMaterials.MainMaterial DESC, pComponentType.ComponentOrder, 
				pSourcingQuotationBOMMaterials.MaterialSort, pSourcingQuotationBOMMaterials.MaterialNo, pSourcingQuotationBOMMaterials.MaterialName, pSourcingQuotationBOMMaterials.StyleMaterialId

		END
		





GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04435', GetDate())
GO