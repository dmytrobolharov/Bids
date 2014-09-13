IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSKU_BOM_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSKU_BOM_Logic_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleSKU_BOM_Logic_UPDATE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER
AS
BEGIN
	
	-- update SKU pages based on BOM if needed (put them work in progress if there are any changes to BOM)
	;WITH DimItems AS (
		SELECT V.DimTypeID, COUNT(V.DimID) AS DimCnt
		FROM pStyleBOMDimensionItem sbdi
		CROSS APPLY (VALUES (sbdi.ItemDim1TypeId, sbdi.ItemDim1Id),
							(sbdi.ItemDim2TypeId, sbdi.ItemDim2Id),
							(sbdi.ItemDim3TypeId, sbdi.ItemDim3Id))
						   V(DimTypeID, DimID)
		WHERE sbdi.StyleBOMDimensionID = @StyleBOMDimensionID AND V.DimID IS NOT NULL
		GROUP BY V.DimTypeID)
	, SkuDims AS (
		SELECT sku.StyleSKUItemID, wfi.WorkFlowItemID, V.DimTypeID, COUNT(DISTINCT V.DimID) AS DimCnt
		FROM pStyleSKUItem sku
		INNER JOIN pWorkFlowItem wfi ON sku.WorkflowItemID = wfi.WorkFlowItemID
		LEFT JOIN pStyleSKUItems skus ON sku.StyleSKUItemID = skus.StyleSKUItemID
		CROSS APPLY (VALUES (sku.ItemDim1TypeID, skus.ItemDim1ID),
							(sku.ItemDim2TypeID, skus.ItemDim2ID),
							(sku.ItemDim3TypeID, skus.ItemDim3ID))
						   V(DimTypeID, DimID)
		WHERE sku.StyleBOMDimensionID = @StyleBOMDimensionID
			AND V.DimTypeID <> '00000000-0000-0000-0000-000000000000'
			AND wfi.WorkStatus IN (100, 102)
		GROUP BY sku.StyleSKUItemID, wfi.WorkFlowItemID, V.DimTypeID)
	UPDATE wfi SET wfi.WorkStatus = 6 
	FROM SkuDims
	INNER JOIN pWorkFlowItem wfi ON SkuDims.WorkFlowItemID = wfi.WorkFlowItemID
	LEFT JOIN DimItems ON SkuDims.DimTypeID = DimItems.DimTypeID
	WHERE SkuDims.DimCnt <> DimItems.DimCnt OR DimItems.DimTypeID IS NULL
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08207', GetDate())
GO
