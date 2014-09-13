IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Style_DimensionalBOM_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Style_DimensionalBOM_COPY]
GO


CREATE PROCEDURE [dbo].[spx_Style_DimensionalBOM_COPY]
	@CopyStyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@NewWorkflowMasterID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@NewStyleBOMDimensionID UNIQUEIDENTIFIER = NULL OUTPUT
AS
BEGIN
    DECLARE @WorkflowItemID UNIQUEIDENTIFIER
    DECLARE @OldStyleSet INT
    DECLARE @WorkflowID UNIQUEIDENTIFIER
    DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER

    SET @WorkflowID = '40000000-0000-0000-0000-000000000080'
    SELECT @NewWorkflowItemID = NEWID()
    
    SELECT @WorkflowItemID = WorkflowItemID, @OldStyleSet = StyleSet FROM pStyleBOMDimension 
    WHERE StyleBOMDimensionID = @StyleBOMDimensionID
    
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @NewStyleID AND SeasonYearID = @SeasonYearID
	
    EXEC spx_WorkflowItem_COPY @WorkflowID, 
								@WorkflowItemID,
								@NewStyleID, 
								@CopyStyleID, 
								@OldStyleSet,
								@OldStyleSet, 
								@CUSer, 
								@CDate,
								@NewWorkflowItemID,
								@StyleSeasonYearID
								
	UPDATE pWorkflowItem SET StyleSeasonYearID = @StyleSeasonYearID, WorkflowItemMasterID = @NewWorkflowMasterID 
	WHERE WorkFlowItemID = @NewWorkflowItemID
	
	SELECT @NewStyleBOMDimensionID = StyleBOMDimensionID FROM pStyleBOMDimension WHERE WorkFlowItemID = @NewWorkflowItemID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08915', GetDate())
GO

