IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMItem_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMItem_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMItem_Logic_UPDATE]
(
	@DimLevel INT
	, @StyleBOMDimensionId UNIQUEIDENTIFIER
	, @DimID UNIQUEIDENTIFIER
)
AS
BEGIN
	SELECT *
	INTO #tmpMaterial
	FROM pStyleBOM sb
		CROSS APPLY (
			VALUES (sb.Dim1TypeSel, 1),
				   (sb.Dim2TypeSel, 2),
				   (sb.Dim3TypeSel, 3)
		) V(DimTypeSel, DimLevel)
	WHERE sb.StyleBOMDimensionId = @StyleBOMDimensionId
		AND DimLevel = @DimLevel AND DimTypeSel = 0

	SELECT DISTINCT
		CASE WHEN @DimLevel != 1 THEN sbi.ItemDim1Id ELSE '00000000-0000-0000-0000-000000000000' END AS ItemDim1Id
		, CASE WHEN @DimLevel != 2 THEN sbi.ItemDim2Id ELSE '00000000-0000-0000-0000-000000000000' END AS ItemDim2Id
		, CASE WHEN @DimLevel != 3 THEN sbi.ItemDim3Id ELSE '00000000-0000-0000-0000-000000000000' END AS ItemDim3Id
		, CASE WHEN @DimLevel != 1 THEN sbi.ItemDim1Name ELSE NULL END AS ItemDim1Name
		, CASE WHEN @DimLevel != 2 THEN sbi.ItemDim2Name ELSE NULL END AS ItemDim2Name
		, CASE WHEN @DimLevel != 3 THEN sbi.ItemDim3Name ELSE NULL END AS ItemDim3Name
		, sbi.MaterialQuantity, sbi.MaterialDimension, sbi.StyleMaterialID, sbi.StyleBOMItemID
	INTO #tmpSrc
	FROM pStyleBOMItem sbi
		CROSS APPLY (
			VALUES (sbi.ItemDim1Id, 1), 
				   (sbi.ItemDim2Id, 2), 
				   (sbi.ItemDim3Id, 3)
		) V(ItemDimID, DimLevel)
		INNER JOIN #tmpMaterial stb ON sbi.StyleMaterialID = stb.StyleMaterialID
	WHERE sbi.StyleBOMDimensionID = @StyleBOMDimensionId
		AND v.ItemDimID = @DimID AND v.DimLevel = @DimLevel
		AND sbi.MaterialQuantity IS NOT NULL
		AND sbi.MaterialDimension IS NOT NULL

	;WITH clst AS (
		SELECT * FROM pStyleBOMDimensionItem sbdi
			CROSS APPLY (
				VALUES (sbdi.ItemDim1Id, 1), 
					   (sbdi.ItemDim2Id, 2), 
					   (sbdi.ItemDim3Id, 3)
			) V(ItemDimID, DimLevel)
		WHERE v.ItemDimID != @DimID AND DimLevel = @DimLevel
			AND sbdi.StyleBOMDimensionID = @StyleBOMDimensionId
	)
	SELECT
		CASE WHEN @DimLevel = 1 THEN clst.ItemDim1Id ELSE #tmpSrc.ItemDim1Id END AS ItemDim1Id
		, CASE WHEN @DimLevel = 2 THEN clst.ItemDim2Id ELSE #tmpSrc.ItemDim2Id END AS ItemDim2Id
		, CASE WHEN @DimLevel = 3 THEN clst.ItemDim3Id ELSE #tmpSrc.ItemDim3Id END AS ItemDim3Id
		, CASE WHEN @DimLevel = 1 THEN clst.ItemDim1Name ELSE #tmpSrc.ItemDim1Name END AS ItemDim1Name
		, CASE WHEN @DimLevel = 2 THEN clst.ItemDim2Name ELSE #tmpSrc.ItemDim2Name END AS ItemDim2Name
		, CASE WHEN @DimLevel = 3 THEN clst.ItemDim3Name ELSE #tmpSrc.ItemDim3Name END AS ItemDim3Name
		, #tmpSrc.MaterialDimension, #tmpsrc.MaterialQuantity, #tmpSrc.StyleMaterialID, #tmpSrc.StyleBOMItemID
	INTO #tmpRes
	FROM #tmpMaterial
		INNER JOIN clst ON #tmpMaterial.StyleBOMDimensionId = clst.StyleBOMDimensionID
		INNER JOIN #tmpSrc ON #tmpMaterial.StyleMaterialID = #tmpSrc.StyleMaterialID


	INSERT INTO pStyleBOMItem (
		StyleBOMItemID, StyleBOMDimensionID, StyleMaterialID, WorkFlowID, WorkFlowItemID, StyleID, StyleSet
		, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name, ItemDim2Id, ItemDim2Name, ItemDim3Id, ItemDim3Name
		, ItemDim3ColSelId, MaterialColorId, MaterialQuantity, MaterialDimension, MaterialPrice, Comments, ImageId, CDate, CUser, MDate, MUser
	)
	SELECT
		NEWID(), @StyleBOMDimensionId, #tmpres.StyleMaterialID, src.WorkFlowID, src.WorkFlowItemID, src.StyleID, src.StyleSet
		, src.ItemDim1TypeId, src.ItemDim2TypeId, src.ItemDim3TypeId, #tmpRes.ItemDim1Id, #tmpRes.ItemDim1Name, #tmpRes.ItemDim2Id, #tmpRes.ItemDim2Name, #tmpRes.ItemDim3Id, #tmpRes.ItemDim3Name
		, src.ItemDim3ColSelId, src.MaterialColorId, src.MaterialQuantity, src.MaterialDimension, src.MaterialPrice, src.Comments, src.ImageId, src.CDate, src.CUser, src.MDate, src.MUser
	FROM #tmpRes
		LEFT JOIN pStyleBOMItem sbi ON #tmpres.StyleMaterialID = sbi.StyleMaterialID
			AND sbi.StyleBOMDimensionID = @StyleBOMDimensionId
			AND ISNULL(#tmpRes.ItemDim1Id, '00000000-0000-0000-0000-000000000000') = ISNULL(sbi.ItemDim1Id, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(#tmpRes.ItemDim2Id, '00000000-0000-0000-0000-000000000000') = ISNULL(sbi.ItemDim2Id, '00000000-0000-0000-0000-000000000000')
			AND ISNULL(#tmpRes.ItemDim3Id, '00000000-0000-0000-0000-000000000000') = ISNULL(sbi.ItemDim3Id, '00000000-0000-0000-0000-000000000000')
		INNER JOIN pStyleBOMItem src ON #tmpRes.StyleBOMItemID = src.StyleBOMItemID
	WHERE sbi.StyleBOMItemID IS NULL

	DROP TABLE #tmpRes
	DROP TABLE #tmpMaterial
	DROP TABLE #tmpSrc

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09718', GetDate())
GO
