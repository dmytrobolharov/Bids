IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuote_DimBOMSummary_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuote_DimBOMSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleQuote_DimBOMSummary_SELECT]
(
	@StyleQuoteItemID uniqueidentifier,
	@LinkedToMaterialTable int = 0,
	@ConfigFile VARCHAR(256) = 'Server.config'
)
AS  

/*Get Image Server path portion.*/
DECLARE @ImageServer nvarchar(255)
SET @ImageServer = (SELECT TOP 1 AppSettingValue FROM sAppSetting WHERE UPPER(AppSettingKey) = UPPER('ImageServer') AND UPPER(ConfigFileName) = UPPER(@ConfigFile))

DECLARE @StyleBOMDimensionId UNIQUEIDENTIFIER

SELECT @StyleBOMDimensionId = StyleColorID
FROM pStyleQuoteItem sqi WHERE StyleQuoteItemID = @StyleQuoteItemID

	--IF (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'') AND (CAST(@StyleBOMDimensionId AS nvarchar(50))<>'00000000-0000-0000-0000-000000000000')
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
		'<img src=''' + @ImageServer + '/colorStream.ashx?S=20&CFID=' + CAST(ISNULL(pColorPalette.ColorFolderID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '&CPID=' + CAST(ISNULL(pColorPalette.ColorPaletteID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS ColorImage ,
			GroupName = case pStyleBOM.MainMaterial when 1 then
					'Main Material'
				  else
					pComponentType.ComponentDescription
				  end
			, 0 AS MaterialDel, 
			'<img src=''' + @ImageServer + '/ImageStream.ashx?S=25&V=' + CAST(ISNULL(pStyleBOM.MaterialImageVersion, 0) AS NVARCHAR(5)) + '&IID=' + CAST(ISNULL(pStyleBOM.MaterialImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS MaterialImage, 
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
		WHERE pStyleBOM.StyleBOMDimensionId = @StyleBOMDimensionId 			
		ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, 
			pStyleBOM.MaterialSort, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, pStyleBOM.StyleMaterialId

	END
		


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06674', GetDate())
GO
