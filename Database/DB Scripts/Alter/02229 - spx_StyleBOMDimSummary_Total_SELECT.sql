IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimSummary_Total_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimSummary_Total_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMDimSummary_Total_SELECT]
(
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleBOMDimensionId uniqueidentifier,
	@StyleBOMDimension1ItemId nvarchar(50),
	@StyleBOMDimension2ItemId nvarchar(50),
	@StyleBOMDimension3ItemId nvarchar(50),
	@IsAverage int
)

AS

DECLARE @ItemDim1Type uniqueidentifier
DECLARE @ItemDim2Type uniqueidentifier
DECLARE @ItemDim3Type uniqueidentifier

DECLARE @Count_ItemDim1 int
DECLARE @Count_ItemDim2 int
DECLARE @Count_ItemDim3 int

BEGIN

-- Getting  Dimensions Types
SELECT @ItemDim1Type = ItemDim1TypeId, @ItemDim2Type = ItemDim2TypeId, @ItemDim3Type = ItemDim3TypeId FROM pStyleBOMDimension
WHERE StyleBOMDimensionID = @StyleBOMDimensionId

-- Temporary table
CREATE TABLE #temp_BOM (
	StyleMaterialID uniqueidentifier,
	Qty nvarchar(18),
	Dim_Qty nvarchar(18),
	MaterialPrice money,
	MaterialBOM int,
	VendorPrice decimal(19,3),
	VolumePrice decimal(19,3)
)

-- insert materials with prices
INSERT INTO #temp_BOM (StyleMaterialID, Qty, MaterialPrice, MaterialBOM, VendorPrice, VolumePrice) 
SELECT StyleMaterialID, Qty, MaterialPrice, MaterialBOM, VendorPrice, VolumePrice FROM pStyleBOM
WHERE	StyleID = @StyleId AND StyleSet = @StyleSet 
		AND WorkflowId = @WorkflowId AND WorkflowItemId = @WorkflowItemID
		AND StyleBOMDimensionId = @StyleBOMDimensionId
		
IF @IsAverage = 1		-- if quantity is average for different dimensions
BEGIN
	SELECT @Count_ItemDim1 = COUNT(*) FROM pStyleBOMDimensionItem 
	WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Id IS NOT NULL
	SELECT @Count_ItemDim2 = COUNT(*) FROM pStyleBOMDimensionItem 
	WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim2Id IS NOT NULL
	SELECT @Count_ItemDim3 = COUNT(*) FROM pStyleBOMDimensionItem 
	WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim3Id IS NOT NULL
	
	-- set average quantity for material
	UPDATE #temp_BOM
	SET Dim_Qty = (
		SELECT SUM(MaterialQuantity) / (@Count_ItemDim1*@Count_ItemDim2*@Count_ItemDim3) FROM pStyleBOMItem
				WHERE StyleMaterialID = #temp_BOM.StyleMaterialID
				AND StyleBOMDimensionID = @StyleBOMDimensionId
		)
END
ELSE			-- set quantity for certain dimension
BEGIN
	IF @ItemDim3Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		UPDATE #temp_BOM
		SET Dim_Qty = (
			SELECT MaterialQuantity FROM pStyleBOMItem
					WHERE StyleMaterialID = #temp_BOM.StyleMaterialID
					AND StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Id = @StyleBOMDimension1ItemId
					AND ItemDim2Id = @StyleBOMDimension2ItemId AND ItemDim3Id = @StyleBOMDimension3ItemId
			)
	END
	ELSE IF @ItemDim2Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		UPDATE #temp_BOM
		SET Dim_Qty = (
			SELECT MaterialQuantity FROM pStyleBOMItem
					WHERE StyleMaterialID = #temp_BOM.StyleMaterialID
					AND StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Id = @StyleBOMDimension1ItemId
					AND ItemDim2Id = @StyleBOMDimension2ItemId
			)
	END 
	ELSE IF @ItemDim3Type <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		UPDATE #temp_BOM
		SET Dim_Qty = (
			SELECT MaterialQuantity FROM pStyleBOMItem
					WHERE StyleMaterialID = #temp_BOM.StyleMaterialID
					AND StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Id = @StyleBOMDimension1ItemId
			)
	END
END

UPDATE #temp_BOM
SET Dim_Qty = Qty WHERE Dim_Qty IS NULL

-- result calculation:  SUM (Dim_Qty * MaterialPrice)
SELECT '   ' AS cellSpace, 'BOM Costing  ' AS [Cost Type], '$' + CAST(CAST(SUM(ISNULL(Dim_Qty,0) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
FROM         #temp_BOM WHERE MaterialBOM = 1
UNION ALL
SELECT '   ' AS cellSpace, 'Total Costing  ' AS [Cost Type], '$' +  CAST(CAST(SUM(ISNULL(Dim_Qty,0) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(10)) + '' AS [Total Cost], '   ' AS cellSpace1
FROM         #temp_BOM


DROP TABLE #temp_BOM


END

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02229'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02229', GetDate())
END
GO