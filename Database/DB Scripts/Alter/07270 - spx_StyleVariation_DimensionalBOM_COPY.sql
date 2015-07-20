/****** Object:  StoredProcedure [dbo].[spx_StyleVariation_DimensionalBOM_COPY]    Script Date: 03/18/2014 13:31:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleVariation_DimensionalBOM_COPY]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleVariation_DimensionalBOM_COPY]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleVariation_DimensionalBOM_COPY]    Script Date: 03/18/2014 13:31:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleVariation_DimensionalBOM_COPY]
	@CopyStyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@NewWorkflowMasterID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@NewStyleBOMDimensionID UNIQUEIDENTIFIER = NULL OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @WorkflowItemID UNIQUEIDENTIFIER
    DECLARE @OldStyleSet INT
    DECLARE @WorkflowID UNIQUEIDENTIFIER
    DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER
    DECLARE @SeasonYearID UNIQUEIDENTIFIER

    
    SET @WorkflowID = '40000000-0000-0000-0000-000000000080'
    SELECT @NewWorkflowItemID = NEWID()
    
    SELECT @WorkflowItemID = WorkflowItemID, @OldStyleSet = StyleSet FROM pStyleBOMDimension 
    WHERE StyleBOMDimensionID = @StyleBOMDimensionID
    
	SELECT @SeasonYearID = pStyleSeasonYear.SeasonYearID 
	FROM pWorkFlowItem INNER JOIN pStyleSeasonYear ON pStyleSeasonYear.StyleSeasonYearID = pWorkflowItem.StyleSeasonYearID
	WHERE WorkFlowItemID = @WorkflowItemID
	
	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER
	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @NewStyleID AND SeasonYearID = @SeasonYearID
	IF @StyleSeasonYearID IS NULL
	BEGIN
		EXEC spx_StyleSeasonYearTrans_INSERT
		@StyleID = @NewStyleID, 
		@SeasonYearID = @SeasonYearID,
		@CUser = @CUser, 
		@CDate = @CDate, 
		@ChangeTransID = NULL, 
		@ChangeTransUserID = NULL, 
		@ChangeTransPageName = NULL, 
		@Sort = NULL
		
		SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @NewStyleID AND SeasonYearID = @SeasonYearID
	END

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
VALUES ('DB_Version', '0.5.0000', '07270', GetDate())
GO
