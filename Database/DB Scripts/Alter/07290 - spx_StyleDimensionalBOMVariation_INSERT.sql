IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDimensionalBOMVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDimensionalBOMVariation_INSERT]
GO



CREATE PROCEDURE [dbo].[spx_StyleDimensionalBOMVariation_INSERT]
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Dimensional BOM Workflow ID
	DECLARE @WorkflowID UNIQUEIDENTIFIER
	SET @WorkflowID = '40000000-0000-0000-0000-000000000080'
	
	DECLARE @WorkflowItemID UNIQUEIDENTIFIER
	DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	DECLARE @MasterID UNIQUEIDENTIFIER
	DECLARE @WorkflowItemCursor CURSOR
	
	DECLARE @MasterIDs AS TABLE(
		OldWorkFlowItemMasterID UNIQUEIDENTIFIER,
		MasterID UNIQUEIDENTIFIER)
	
	INSERT INTO @MasterIDs(OldWorkFlowItemMasterID)
	SELECT DISTINCT WorkFlowItemMasterID FROM pWorkFlowItem WHERE StyleID = @StyleID AND WorkflowID = @WorkflowID
	UPDATE @MasterIDs SET MasterID = NEWID()
	
	SET @WorkflowItemCursor = CURSOR SCROLL
	FOR SELECT WorkFlowItemID FROM pWorkFlowItem WHERE StyleID = @StyleID AND WorkflowID = @WorkflowID
	OPEN @WorkflowItemCursor
	FETCH NEXT FROM @WorkflowItemCursor INTO @WorkflowItemID
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		SET @NewWorkflowItemID = NEWID()
		
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
						@StyleID, 
						1, 
						1, 
						@CUser, 
						@CDate,
						@NewWorkflowItemID,
						@StyleSeasonYearID
		
		SELECT @MasterID = WorkflowItemMasterID FROM pWorkflowItem WHERE WorkflowItemID = @WorkflowItemID
		
		UPDATE pWorkFlowItem SET WorkflowItemMasterID = (SELECT MasterID FROM @MasterIDs WHERE OldWorkFlowItemMasterID = @MasterID), 
		StyleSeasonYearID = @StyleSeasonYearID
		WHERE WorkFlowItemID = @NewWorkflowItemID
	
		FETCH NEXT FROM @WorkflowItemCursor INTO @WorkflowItemID
	END
	
	CLOSE @WorkflowItemCursor
	DEALLOCATE @WorkflowItemCursor
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07290', GetDate())
GO
