/****** Object:  StoredProcedure [dbo].[spx_StyleTextImageVariation_INSERT]    Script Date: 09/06/2012 10:03:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTextImageVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTextImageVariation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleTextImageVariation_INSERT]    Script Date: 09/06/2012 10:03:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleTextImageVariation_INSERT] 
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	-- Text-Image Workflow ID
    DECLARE @WorkflowID UNIQUEIDENTIFIER
	SET @WorkflowID = '40000000-0000-0000-0000-000000000018'
	
	DECLARE @WorkflowItemID UNIQUEIDENTIFIER
	DECLARE @NewWorkflowItemID UNIQUEIDENTIFIER
	DECLARE @WorkflowItemCursor CURSOR
	
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
	
		INSERT INTO pStyleComment  
		(StyleID, StyleSet, WorkflowID, CUser, CDate, MUser, MDate, MChange, StyleReview, StyleComment, CTeamID, Active, WorkFlowItemId)  
		SELECT @NewStyleID, StyleSet, WorkflowID, CUser, CDate, MUser, MDate, MChange, StyleReview, StyleComment, CTeamID, Active, @NewWorkFlowItemId   
		FROM pStyleComment WITH (NOLOCK)  
		WHERE StyleID = @StyleID
		AND WorkFlowItemId = @WorkflowItemID  
  
  
		INSERT INTO pStyleDetailForm  
		(StyleDetailFormMasterID, WorkflowID, WorkFlowItemId, StyleID, Comments, StyleSet, ImageID, ImageVersion, CUser, CDate, MUser, MDate, Sort, StyleImageLinked, SessionItemTempID, StyleDetailFormLinkID)  
		SELECT NEWID(), WorkflowID, @NewWorkFlowItemId, @NewStyleID, Comments, StyleSet, ImageID, ImageVersion,CUser, CDate, MUser, MDate, Sort, StyleImageLinked, SessionItemTempID, StyleDetailFormLinkID  
		FROM pStyleDetailForm WITH (NOLOCK)  
		WHERE StyleID = @StyleID
		AND WorkflowItemID = @WorkflowItemID  
		
		FETCH NEXT FROM @WorkflowItemCursor INTO @WorkflowItemID
	 END 
   
	CLOSE @WorkflowItemCursor
	DEALLOCATE @WorkflowItemCursor
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04209', GetDate())
GO
