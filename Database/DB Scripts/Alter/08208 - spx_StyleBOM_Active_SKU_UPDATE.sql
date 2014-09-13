IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Active_SKU_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_Active_SKU_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOM_Active_SKU_UPDATE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@Dim1Changed INT,
	@Dim2Changed INT,
	@Dim3Changed INT
AS
BEGIN
	
	UPDATE wfi SET wfi.WorkStatus = CASE 
		WHEN (@Dim1Changed > 0 AND sbd.ItemDim1TypeId IN (sku.ItemDim1TypeID, sku.ItemDim2TypeID, sku.ItemDim3TypeID))
			OR (@Dim2Changed > 0 AND sbd.ItemDim2TypeId IN (sku.ItemDim1TypeID, sku.ItemDim2TypeID, sku.ItemDim3TypeID))
			OR (@Dim3Changed > 0 AND sbd.ItemDim3TypeId IN (sku.ItemDim1TypeID, sku.ItemDim2TypeID, sku.ItemDim3TypeID))
		THEN 6
		ELSE wfi.WorkStatus END
	FROM pStyleSKUItem sku
	INNER JOIN pWorkFlowItem wfi ON sku.WorkflowItemID = wfi.WorkFlowItemID
	INNER JOIN pStyleBOMDimension sbd ON sku.StyleBOMDimensionID = sbd.StyleBOMDimensionID
	WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID AND wfi.WorkStatus IN (100, 102)
			
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08208', GetDate())
GO
