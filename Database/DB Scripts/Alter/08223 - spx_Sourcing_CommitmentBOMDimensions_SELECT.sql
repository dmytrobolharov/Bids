IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_CommitmentBOMDimensions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_CommitmentBOMDimensions_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Sourcing_CommitmentBOMDimensions_SELECT]
	@SourcingCommitmentItemID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER,
			@StyleSKUItemID UNIQUEIDENTIFIER

	SELECT @StyleBOMDimensionID = StyleColorID,
		@StyleSKUItemID = StyleSKUItemID 
	FROM pSourcingCommitmentItem WHERE SourcingCommitmentItemID = @SourcingCommitmentItemID
	
	IF @StyleSKUItemID IS NULL OR @StyleSKUItemID = '00000000-0000-0000-0000-000000000000'
		SELECT * FROM pStyleBOMDimension sbd 
		LEFT JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
		WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID
	ELSE
		WITH SKU AS (
			SELECT * FROM pStyleSKUItem sku
			CROSS APPLY (VALUES (sku.ItemDim1TypeID), (sku.ItemDim2TypeID), (sku.ItemDim3TypeID)) V(DimTypeID)
			WHERE sku.StyleSKUItemID = @StyleSKUItemID AND V.DimTypeID <> '00000000-0000-0000-0000-000000000000'
		)
		SELECT sbd.StyleBOMDimensionID, sbd.WorkflowID, sbd.StyleSet, sbd.WorkflowItemID, wfi.WorkFlowItemName,
			ISNULL(sku1.DimTypeID, '00000000-0000-0000-0000-000000000000') AS ItemDim1TypeID,
			ISNULL(sku2.DimTypeID, '00000000-0000-0000-0000-000000000000') AS ItemDim2TypeID,
			ISNULL(sku3.DimTypeID, '00000000-0000-0000-0000-000000000000') AS ItemDim3TypeID,
			CASE WHEN sku1.DimTypeID IS NOT NULL THEN sbd.ItemDim1TypeName ELSE '' END AS ItemDim1TypeName,
			CASE WHEN sku2.DimTypeID IS NOT NULL THEN sbd.ItemDim2TypeName ELSE '' END AS ItemDim2TypeName,
			CASE WHEN sku3.DimTypeID IS NOT NULL THEN sbd.ItemDim3TypeName ELSE '' END AS ItemDim3TypeName
		FROM pStyleBOMDimension sbd
		LEFT JOIN SKU sku1 ON sbd.ItemDim1TypeId = sku1.DimTypeID
		LEFT JOIN SKU sku2 ON sbd.ItemDim2TypeId = sku2.DimTypeID
		LEFT JOIN SKU sku3 ON sbd.ItemDim3TypeId = sku3.DimTypeID
		LEFT JOIN pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID
		WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08223', GetDate())
GO
