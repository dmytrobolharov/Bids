/****** Object:  StoredProcedure [dbo].[spx_WorkflowItem_REPLACE]    Script Date: 06/13/2013 16:15:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_WorkflowItem_REPLACE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_WorkflowItem_REPLACE]
GO

CREATE PROCEDURE [dbo].[spx_WorkflowItem_REPLACE]
	@srcWorkflowItemID UNIQUEIDENTIFIER,
	@dstWorkflowItemID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	
	DECLARE @WorkflowID UNIQUEIDENTIFIER,
			@StyleID UNIQUEIDENTIFIER,
			@StyleSeasonYearID UNIQUEIDENTIFIER,
			@StyleSet INT
			
	SELECT 
		@WorkflowID = WorkflowID, 
		@StyleID = StyleID, 
		@StyleSet = StyleSet, 
		@StyleSeasonYearID = StyleSeasonYearID
	FROM pWorkFlowItem WHERE WorkFlowItemID = @dstWorkflowItemID
	
	-- save data avalible for destination item
	SELECT * INTO #tmpWorkflowItem
	FROM pWorkFlowItem WHERE WorkFlowItemID = @dstWorkflowItemID
	
	
	exec spx_WorkflowItem_DELETE 
		@WorkflowID = @WorkflowID,
		@WorkflowItemID = @dstWorkflowItemID,
		@StyleID = @StyleID,
		@StyleSet = @StyleSet			
	
	exec spx_WorkflowItem_COPY
		@WorkflowID = @WorkflowID,  
		@WorkFlowItemId = @srcWorkflowItemID,  
		@StyleID = @StyleID,  
		@CopyStyleID = @StyleID,  
		@StyleSet = @StyleSet,  
		@CopyStyleSet = @StyleSet,  
		@CUser = @CUser,  
		@CDate = @CDate,
		@NewWorkFlowItemId = @dstWorkflowItemID  
		
	UPDATE pWorkFlowItem SET      
		WorkflowItemTypeId = twfi.WorkflowItemTypeId,		
		WorkFlowItemName = twfi.WorkFlowItemName,
		Sort = twfi.Sort,
		CUser = twfi.CUser,
		CDate = twfi.CDate,
		RepRowGuidColID = twfi.RepRowGuidColID,
		StatusID = twfi.StatusID,
		WorkStart = twfi.WorkStart,
		WorkDue = twfi.WorkDue,
		WorkAssignedTo = twfi.WorkAssignedTo,
		WorkStatus = twfi.WorkStatus,
		WorkEscalateTo = twfi.WorkEscalateTo,
		StyleSeasonYearID = twfi.StyleSeasonYearID,
		WorkflowItemMasterID = twfi.WorkflowItemMasterID
	FROM #tmpWorkflowItem twfi
	WHERE pWorkFlowItem.WorkFlowItemID = @dstWorkflowItemID
		
	DROP TABLE #tmpWorkflowItem
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05848', GetDate())
GO
