IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimSKU_FromPlanning_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimSKU_FromPlanning_Update]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMDimSKU_FromPlanning_Update]
	@PlanningItemID nvarchar(50),
	@StyleBOMDimensionID nvarchar(50) = NULL,
	@MUser nvarchar(200),
	@MDate datetime
AS
BEGIN
	
	IF @StyleBOMDimensionID IS NULL
	BEGIN
		SELECT @StyleBOMDimensionId = StyleBOMDimensionID FROM pPlanningItem WHERE PlanningItemID = @PlanningItemID
	END
	
	IF @StyleBOMDimensionID IS NOT NULL AND @StyleBOMDimensionID <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		DECLARE @StyleID NVARCHAR(50)
		DECLARE @StyleSet INT
		DECLARE @WorkflowID NVARCHAR(50)
		DECLARE @WorkflowItemID NVARCHAR(50)
		
		SELECT @StyleID = StyleID, @StyleSet = StyleSet, @WorkFlowID = WorkFlowID, @WorkflowItemID = WorkFlowItemID 
		FROM pStyleBOMDimension 
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID
		
		EXEC spx_StyleBOMDimSKU_Update
			@StyleBOMDimensionId = @StyleBOMDimensionId,
			@StyleID = @StyleID,
			@Styleset = @StyleSet,
			@WorkFlowID = @WorkflowID,
			@WorkFlowItemID = @WorkflowItemID,
			@ItemDim1 = NULL,
			@ItemDim1Name = NULL,
			@ItemDim2 = NULL,
			@ItemDim2Name = NULL,
			@ItemDim3 = NULL,
			@ItemDim3Name = NULL,
			@MUser = @MUser,
			@MDate = @MDate
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06719', GetDate())
GO
