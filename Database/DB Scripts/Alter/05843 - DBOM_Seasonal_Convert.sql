UPDATE Mapping SET IsSeasonal = 1 WHERE Map = '40000000-0000-0000-0000-000000000080'
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pWorkflowItem' AND COLUMN_NAME = 'WorkflowItemMasterID')
BEGIN
	ALTER TABLE pWorkflowItem ADD WorkflowItemMasterID UNIQUEIDENTIFIER
END
GO

BEGIN TRY
	BEGIN TRAN

	-- duplicate DBOM workflows for all seasons in style
	INSERT INTO pStyleWorkflow(
		StyleWorkflowID, StyleWorkflowMasterID, StyleID, StyleSet, 
		WorkflowID, WorkflowType, WorkflowOrder, WorkDay, WorkDate, WorkStart, WorkDue,
		WorkAssignedTo, WorkComplete, WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort,
		CUser, CDate, MUser, MDate, ActualCompletedDate, WorkflowTemplateID, WorkflowTemplateItemID,
		PlannedStartDate, PlannedDueDate, PlannedWorkDays, 
		WorkflowAssignedTo, WorkEscalateTo, WorkflowAlerts, WorkflowAccessTypeID, WorkflowAccessTypeDesc,
		StyleSeasonYearID)
	SELECT NEWID(), sw.StyleWorkflowMasterID, sw.StyleID, sw.StyleSet, 
		sw.WorkflowID, sw.WorkflowType, sw.WorkflowOrder, sw.WorkDay, sw.WorkDate, sw.WorkStart, sw.WorkDue,
		sw.WorkAssignedTo, sw.WorkComplete, sw.WorkStatus, sw.WorkStatusDate, sw.WorkStatusBy, sw.WorkVersion, sw.WorkComments, sw.WorkSort,
		sw.CUser, sw.CDate, sw.MUser, sw.MDate, sw.ActualCompletedDate, sw.WorkflowTemplateID, sw.WorkflowTemplateItemID,
		sw.PlannedStartDate, sw.PlannedDueDate, sw.PlannedWorkDays, 
		sw.WorkflowAssignedTo, sw.WorkEscalateTo, sw.WorkflowAlerts, sw.WorkflowAccessTypeID, sw.WorkflowAccessTypeDesc,
		ssy.StyleSeasonYearID
	FROM pStyleWorkflow sw
	INNER JOIN Mapping m ON sw.WorkflowID = m.Map
	INNER JOIN pStyleSeasonYear ssy ON sw.StyleID = ssy.StyleID
	WHERE m.Map = '40000000-0000-0000-0000-000000000080' AND sw.StyleSeasonYearID IS NULL
	ORDER BY sw.StyleID, WorkflowID

	-- remove original DBOM workflows, except ones for style without any season years at all
	DELETE FROM pStyleWorkflow 
	WHERE StyleWorkflowID IN (
		SELECT DISTINCT StyleWorkflowID FROM pStyleWorkflow sw
		INNER JOIN pStyleSeasonYear ssy ON sw.StyleID = ssy.StyleID
		INNER JOIN Mapping m ON sw.WorkflowID = m.Map
		WHERE m.Map = '40000000-0000-0000-0000-000000000080' AND sw.StyleSeasonYearID IS NULL
	)

	-- is used as source for copying workflow items
	DECLARE @tmpWorkflowItem TABLE(
		ROWID INT IDENTITY(1, 1), 
		WorkflowItemID UNIQUEIDENTIFIER,
		StyleSeasonYearID UNIQUEIDENTIFIER)
		
	INSERT INTO @tmpWorkflowItem(WorkflowItemID, StyleSeasonYearID)
	SELECT wfi.WorkFlowItemID, ssy.StyleSeasonYearID FROM pWorkflowItem wfi
	INNER JOIN pStyleSeasonYear ssy ON wfi.StyleID = ssy.StyleID
	WHERE WorkflowID = '40000000-0000-0000-0000-000000000080'
	ORDER BY wfi.WorkFlowItemID

	DECLARE @ProcessedWorkflowItems TABLE(
		WorkflowItemID UNIQUEIDENTIFIER,
		MasterID UNIQUEIDENTIFIER)
	DECLARE @TOTAL INT = (SELECT COUNT(*) FROM @tmpWorkflowItem),
			@ROW INT = 1;

	-- copy each workflow item for each season year in style individually	
	WHILE @ROW <= @TOTAL
	BEGIN
		DECLARE @WorkflowItemID UNIQUEIDENTIFIER,
				@StyleID UNIQUEIDENTIFIER,
				@StyleSet INT,
				@StyleSeasonYearID UNIQUEIDENTIFIER,
				@CDate DATETIME = GETDATE();
				
		SELECT @WorkflowItemID = wfi.WorkFlowItemID, @StyleID = wfi.StyleID, @StyleSet = wfi.StyleSet, @StyleSeasonYearID = twfi.StyleSeasonYearID
		FROM @tmpWorkflowItem twfi INNER JOIN pWorkflowItem wfi ON twfi.WorkflowItemID = wfi.WorkFlowItemID
		WHERE twfi.ROWID = @ROW
		
		-- for first season year - just update StyleSeasonYearID field
		if NOT EXISTS(SELECT * FROM @ProcessedWorkflowItems WHERE WorkflowItemID = @WorkflowItemID)
		begin
			DECLARE @MasterID UNIQUEIDENTIFIER = NEWID()
			UPDATE pWorkFlowItem SET 
				StyleSeasonYearID = @StyleSeasonYearID, 
				WorkflowItemMasterID = @MasterID
			WHERE WorkFlowItemID = @WorkflowItemID
			INSERT INTO @ProcessedWorkflowItems(WorkflowItemID, MasterID) VALUES(@WorkflowItemID, @MasterID)
		end
		else -- for subsequent season years - copy all the data and update it to hold new StyleSeasonYearID
		begin	
			exec spx_WorkflowItem_COPY 
				@WorkflowID = '40000000-0000-0000-0000-000000000080',  
				@WorkFlowItemId = @WorkflowItemID,  
				@StyleID = @StyleID,  
				@CopyStyleID = @StyleID,  
				@StyleSet = @StyleSet,  
				@CopyStyleSet = @StyleSet,  
				@CUser = 'autoscript', 
				@CDate = @CDate	
			
			-- update StyleSeasonYearID for newly copied workflow item
			UPDATE pWorkFlowItem SET 
				StyleSeasonYearID = @StyleSeasonYearID,
				WorkflowItemMasterID = (SELECT MasterID FROM @ProcessedWorkflowItems WHERE WorkflowItemID = @WorkflowItemID)
			WHERE StyleID = @StyleID AND StyleSet = @StyleSet 
				AND WorkflowID = '40000000-0000-0000-0000-000000000080'
				AND StyleSeasonYearID IS NULL 
				AND WorkFlowItemID <> @WorkflowItemID			
		end

		SET @ROW = @ROW + 1
	END

	COMMIT
END TRY
BEGIN CATCH
	ROLLBACK
END CATCH
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05843', GetDate())
GO
