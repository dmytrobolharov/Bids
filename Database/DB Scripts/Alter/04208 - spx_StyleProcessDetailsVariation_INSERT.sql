/****** Object:  StoredProcedure [dbo].[spx_StyleProcessDetailsVariation_INSERT]    Script Date: 09/06/2012 10:02:53 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleProcessDetailsVariation_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleProcessDetailsVariation_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleProcessDetailsVariation_INSERT]    Script Date: 09/06/2012 10:02:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleProcessDetailsVariation_INSERT]
	@StyleID UNIQUEIDENTIFIER,
	@NewStyleID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @WorkflowID UNIQUEIDENTIFIER
	SET @WorkflowID = '80000000-0000-0000-0000-000000000008'
	
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
	
		INSERT INTO pConPageDetail  
		( StyleID, WorkflowID, WorkFlowItemId, Sort, StyleSet, Detail, OrigOperationSN, Level0Desc, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3,   
		AuxField4, AuxField5, Linked, Level0ID, Level1ID, Level2ID, Level3ID, CUser, CDate, MUser, MDate)  
		SELECT @NewStyleID, @WorkflowID, @NewWorkFlowItemId, Sort, StyleSet, Detail, OrigOperationSN, Level0Desc, Level1Desc, Level2Desc, Level3Desc, ImageID, AuxField1, AuxField2, AuxField3,   
		AuxField4, AuxField5, Linked, Level0ID, Level1ID, Level2ID, Level3ID, CUser, CDate, MUser, MDate  
		FROM pConPageDetail WITH (NOLOCK)  
		WHERE StyleID = @StyleID  
		AND WorkflowItemID = @WorkflowItemID 
		
		FETCH NEXT FROM @WorkflowItemCursor INTO @WorkflowItemID
	 END 
   
	CLOSE @WorkflowItemCursor
	DEALLOCATE @WorkflowItemCursor
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04208', GetDate())
GO
