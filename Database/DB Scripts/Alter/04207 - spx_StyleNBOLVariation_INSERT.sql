/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLVariation_INSERT]    Script Date: 09/06/2012 10:02:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleNBOLVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleNBOLVariation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleNBOLVariation_INSERT]    Script Date: 09/06/2012 10:02:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleNBOLVariation_INSERT]
	(@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Measurements Workflow ID
	DECLARE @WorkflowID UNIQUEIDENTIFIER
	SET @WorkflowID = '40000000-0000-0000-0000-000000000078'
	
	DECLARE @WorkflowItemID UNIQUEIDENTIFIER
	DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER
	DECLARE @WorkflowItemCursor CURSOR
	
	DECLARE @StyleSetCursor CURSOR
	DECLARE @StyleSet INT
	-- For each New BOL Workflow Item in current variation
	SET @WorkflowItemCursor = CURSOR SCROLL
	FOR SELECT WorkFlowItemID FROM pWorkFlowItem WHERE StyleID = @StyleID AND WorkflowID = @WorkflowID
	OPEN @WorkflowItemCursor
	FETCH NEXT FROM @WorkflowItemCursor INTO @WorkflowItemID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	
		SELECT @NewWorkflowItemID = NEWID()
		-- Inserting the data from current workflow item into new workflow item
		INSERT INTO pWorkFlowItem (WorkFlowItemID, WorkflowID, WorkflowItemTypeId, StyleID, WorkFlowItemName,
									Sort, CUser, CDate, MUser, MDate, StyleSet, RepRowGuidColID, StatusID, 
									WorkStart, WorkDue, WorkAssignedTo, WorkStatus, WorkEscalateTo)
		SELECT @NewWorkflowItemID, WorkflowID, WorkflowItemTypeId, @NewStyleID, WorkFlowItemName,
									Sort, CUser, CDate, MUser, MDate, StyleSet, RepRowGuidColID, StatusID, 
									WorkStart, WorkDue, WorkAssignedTo, WorkStatus, WorkEscalateTo
		FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkflowItemID
		
		-- For each style set
		SET @StyleSetCursor = CURSOR SCROLL
		FOR SELECT DISTINCT StyleSet FROM pStyleNBOLItems WHERE StyleID=@StyleID
		OPEN @StyleSetCursor
		FETCH NEXT FROM @StyleSetCursor INTO @StyleSet
		
		WHILE @@FETCH_STATUS = 0 -- Copying the NBOL items from old style to new
		BEGIN
			EXEC spx_StyleNBOL_Copy
					@WorkflowID = @WorkflowID,
					@NewWorkFlowItemId = @NewWorkFlowItemId,
					@OldWorkFlowItemId = @WorkFlowItemId,
					@NewStyleID = @NewStyleID,
					@OldStyleID = @StyleID,
					@NewStyleSet = @StyleSet,
					@OldStyleSet = @StyleSet,
					@CUser = @CUser,
					@CDate = @CDate
			FETCH NEXT FROM @StyleSetCursor INTO @StyleSet
		END
		
		CLOSE @StyleSetCursor
		DEALLOCATE @StyleSetCursor
		
		FETCH NEXT FROM @WorkflowItemCursor INTO @WorkflowItemID
	END
	
	CLOSE @WorkflowItemCursor
	DEALLOCATE @WorkflowItemCursor
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04207', GetDate())
GO
