IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleCosting_BOM_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleCosting_BOM_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleCosting_BOM_UPDATE]
	@StyleId uniqueidentifier,
	@StyleSet int,
	@WorkflowId uniqueidentifier,
	@WorkflowItemID uniqueidentifier,
	@StyleCostingId uniqueidentifier
AS

DECLARE	@StyleBOMDimensionId uniqueidentifier
DECLARE @Count_DimItems int

DECLARE @BOMCosting nvarchar(20)
	
BEGIN
	
	-- Getting @StyleBOMDimensionId
	SELECT @StyleBOMDimensionId = StyleBOMDimensionID FROM pStyleBOMDimension
	WHERE StyleID = @StyleId AND StyleSet = @StyleSet 
			AND WorkFlowID = @WorkflowId AND WorkFlowItemID = @WorkFlowItemID
			
	-- Temporary table for materials list
	CREATE TABLE #temp_BOM (
		StyleMaterialID uniqueidentifier,
		Qty nvarchar(18),
		Dim_Qty nvarchar(18),
		MaterialPrice money,
		MaterialBOM int,
		VendorPrice decimal(19,3),
		VolumePrice decimal(19,3)
	)
	
	-- inserting materials
	INSERT INTO #temp_BOM (StyleMaterialID, Qty, MaterialPrice, MaterialBOM, VendorPrice, VolumePrice) 
	SELECT StyleMaterialID, Qty, MaterialPrice, MaterialBOM, VendorPrice, VolumePrice FROM pStyleBOM
	WHERE	StyleID = @StyleId AND StyleSet = @StyleSet 
			AND WorkflowId = @WorkflowId AND WorkflowItemId = @WorkflowItemID
			AND StyleBOMDimensionId = @StyleBOMDimensionId
	
	-- getting count items of dimensions
	SET @Count_DimItems = 
		(SELECT COUNT(*) FROM pStyleBOMDimensionItems 
			WHERE StyleBOMDimensionID = @StyleBOMDimensionId
			AND ItemDim1Active = 1 AND ItemDim2Active = 1 AND ItemDim3Active = 1
		)
	
	-- set average quantity for materials
	UPDATE #temp_BOM
	SET Dim_Qty = (
		SELECT SUM(MaterialQuantity) / @Count_DimItems FROM pStyleBOMItem
				WHERE StyleMaterialID = #temp_BOM.StyleMaterialID
				AND StyleBOMDimensionID = @StyleBOMDimensionId
		)
		
	UPDATE #temp_BOM
	SET Dim_Qty = Qty WHERE Dim_Qty IS NULL
	
	-- calculation BOMCosting = SUM(Dim_Qty*MaterialPrice)
	SELECT @BOMCosting = CAST(CAST(SUM(ISNULL(Dim_Qty,0) * isnull(MaterialPrice,VolumePrice)) AS DECIMAL(18,2)) AS VARCHAR(20))
	FROM #temp_BOM WHERE MaterialBOM = 1
	
	-- update Costing table
	UPDATE pStyleCosting 
	SET StyleBOMDimensionID = @StyleBOMDimensionId,
		BOMCost = @BOMCosting
	WHERE StyleCostingID = @StyleCostingId

END


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03245'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03245', GetDate())

END
GO