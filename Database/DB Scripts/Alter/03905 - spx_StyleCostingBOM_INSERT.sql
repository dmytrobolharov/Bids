IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCostingBOM_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCostingBOM_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleCostingBOM_INSERT](
	@StyleCostingScenarioItemsId UNIQUEIDENTIFIER 
	,@StyleId UNIQUEIDENTIFIER 
	,@BOMWorkflowItemID UNIQUEIDENTIFIER 
	,@CreatedBy NVARCHAR(200)
	,@CreatedDate DATETIME
)

AS
BEGIN

DECLARE @StyleBOMDimensionId uniqueidentifier
DECLARE @ItemDim1Type uniqueidentifier
DECLARE @ItemDim2Type uniqueidentifier
DECLARE @ItemDim3Type uniqueidentifier
DECLARE @Count_DimItems int
DECLARE @Cost As decimal(18,3)

SELECT @StyleBOMDimensionId = StyleBOMDimensionID FROM pStyleBOMDimension WHERE WorkFlowItemID = @BOMWorkflowItemID

-- Getting  Dimensions Types
SELECT @ItemDim1Type = ItemDim1TypeId, @ItemDim2Type = ItemDim2TypeId, @ItemDim3Type = ItemDim3TypeId FROM pStyleBOMDimension
WHERE StyleBOMDimensionID = @StyleBOMDimensionId

-- Temporary table
CREATE TABLE #temp_BOM (
	StyleMaterialID uniqueidentifier,
	Qty decimal(18,3),
	Dim_Qty decimal(18,3),
	MaterialPrice decimal(18,3),
	MaterialBOM int,
	VendorPrice decimal(18,3),
	VolumePrice decimal(18,3),
	Total decimal(18,3)
)

-- insert materials with prices
INSERT INTO #temp_BOM (StyleMaterialID, Qty, MaterialPrice, MaterialBOM, VendorPrice, VolumePrice) 
SELECT StyleMaterialID, Qty, MaterialPrice, MaterialBOM, VendorPrice, VolumePrice 
FROM pStyleBOM
WHERE StyleBOMDimensionId = @StyleBOMDimensionId


SELECT @Count_DimItems = COUNT(*) 
FROM pStyleBOMDimensionItems 
WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1


-- set average quantity for material
IF @Count_DimItems > 0
BEGIN
	UPDATE #temp_BOM
	SET Dim_Qty = (
		SELECT SUM(MaterialQuantity) / @Count_DimItems FROM pStyleBOMItem
				WHERE StyleMaterialID = #temp_BOM.StyleMaterialID
				AND StyleBOMDimensionID = @StyleBOMDimensionId
		)
END

UPDATE #temp_BOM
SET Dim_Qty = Qty WHERE Dim_Qty IS NULL
	
-- calc Total (Qty * Price)
UPDATE #temp_BOM
SET Total = ISNULL(Dim_Qty,0) * ISNULL(MaterialPrice, VolumePrice)


-- insert to pstyleCostingBOM records for particular StytleCostingScenario
INSERT INTO pstyleCostingBOM (StytleCostingScenarioItemsID, StyleID, StyleBOMDimensionID,
		StyleMaterialId, MaterialNo, MaterialName, MaterialType, MaterialTypeDesc, MaterialCost,
		CUser, CDate, MUser, MDate)
SELECT @StyleCostingScenarioItemsId, @StyleId, @StyleBOMDimensionId,
		pStyleBOM.StyleMaterialID, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, pStyleBOM.MaterialType, pComponentType.ComponentDescription, #temp_BOM.Total,
		@CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
FROM #temp_BOM
	INNER JOIN pStyleBOM ON #temp_BOM.StyleMaterialID = pStyleBOM.StyleMaterialID
	INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03905', GetDate())
GO
