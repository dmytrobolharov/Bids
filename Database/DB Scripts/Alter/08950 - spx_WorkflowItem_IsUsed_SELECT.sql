IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_IsUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_IsUsed_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_WorkflowItem_IsUsed_SELECT]
	@WorkflowItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	DECLARE @WorkflowID UNIQUEIDENTIFIER,
			@StyleID UNIQUEIDENTIFIER,
			@StyleSet INT
	SELECT @WorkflowID = WorkflowID,
		@StyleID = StyleID,
		@StyleSet = StyleSet 
	FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkflowItemID
	
	IF @WorkflowID = '40000000-0000-0000-0000-000000000080' -- BOM
	BEGIN
		-- check for using in sample requests
		IF EXISTS(SELECT * FROM pWorkFlowItem wi
			INNER JOIN pWorkFlowItem wi_master ON wi.WorkflowItemMasterID = wi_master.WorkflowItemMasterID
			INNER JOIN pSampleRequestBOMTrade srt ON wi_master.WorkFlowItemID = srt.WorkFlowItemID
			INNER JOIN pSampleRequestSubmitBOM srsb ON srt.SampleRequestTradeID = srsb.SampleRequestTradeID 
			WHERE wi.WorkFlowItemID = @WorkFlowItemID)
		BEGIN
			SELECT 1			
		END
		-- check for using in Style SKU workflow
		ELSE IF EXISTS(SELECT * FROM pWorkFlowItem wi
			INNER JOIN pWorkFlowItem wi_master ON wi.WorkflowItemMasterID = wi_master.WorkflowItemMasterID
			INNER JOIN pStyleBOMDimension sbd ON wi_master.WorkFlowItemID = sbd.WorkFlowItemID
			INNER JOIN pStyleSKUItem ski ON sbd.StyleBOMDimensionID = ski.StyleBOMDimensionID
			WHERE wi.WorkFlowItemID = @WorkFlowItemID)
		BEGIN
			SELECT 1
		END
		-- check for using in quotes
		ELSE IF EXISTS(SELECT * FROM pWorkFlowItem wi
			INNER JOIN pWorkFlowItem wi_master ON wi.WorkflowItemMasterID = wi_master.WorkflowItemMasterID
			INNER JOIN pStyleBOMDimension sbd ON wi_master.WorkFlowItemID = sbd.WorkFlowItemID
			INNER JOIN pStyleQuoteItem sqi ON sbd.StyleBOMDimensionID = sqi.StyleColorID
			WHERE wi.WorkFlowItemID = @WorkFlowItemID)
		BEGIN
			SELECT 1
		END
		-- check for using in Planning
		ELSE IF EXISTS(SELECT * FROM pWorkFlowItem wi
			INNER JOIN pWorkFlowItem wi_master ON wi.WorkflowItemMasterID = wi_master.WorkflowItemMasterID
			INNER JOIN pStyleBOMDimension sbd ON wi_master.WorkFlowItemID = sbd.WorkFlowItemID
			INNER JOIN pPlanningItem pli ON sbd.StyleBOMDimensionID = pli.StyleBOMDimensionID
			WHERE wi.WorkFlowItemID = @WorkFlowItemID)
		BEGIN
			SELECT 1
		END
		ELSE
			SELECT 0
	END
	ELSE IF @WorkflowID = '40000000-0000-0000-0000-000000000050' -- Measurements
	BEGIN
		DECLARE @MeasIsUsed TABLE(IsUsed INT)
		INSERT INTO @MeasIsUsed
		EXEC spx_MeasurementIsUsed_SELECT
			@WorkFlowId = @WorkflowID,
			@WorkFlowItemId = @WorkflowItemID,
			@StyleId = @StyleId,
			@StyleSet = @StyleSet
		
		IF (SELECT SUM(IsUsed) FROM @MeasIsUsed) > 0
			SELECT 1
		ELSE 
			SELECT 0
	END
	ELSE IF @WorkflowID = '40000000-0000-0000-0000-000000000090' -- Style SKU
	BEGIN
		-- do not allow to delete any SKU Plans that are linked to a Planning
		IF EXISTS(SELECT * FROM pWorkFlowItem wi
			INNER JOIN pWorkFlowItem wi_master ON wi.WorkflowItemMasterID = wi_master.WorkflowItemMasterID
			INNER JOIN pStyleSKUItem ssi ON wi_master.WorkFlowItemID = ssi.WorkflowItemID
			WHERE wi.WorkFlowItemID = @WorkflowItemID AND ssi.PlanningSKUHeaderID IS NOT NULL)
		BEGIN
			SELECT 1
		END
		ELSE
			SELECT 0
	END
	ELSE
		SELECT 0
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08950', GetDate())
GO
