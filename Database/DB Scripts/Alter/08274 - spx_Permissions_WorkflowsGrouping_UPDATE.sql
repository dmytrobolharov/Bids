IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Permissions_WorkflowsGrouping_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Permissions_WorkflowsGrouping_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_Permissions_WorkflowsGrouping_UPDATE]
	@PermissionFolderTypeID INT = NULL
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @StyleFolderTypeID INT = 2
	DECLARE @LineListFolderTypeID INT = 3
	DECLARE @PlanningFolderTypeID INT = 22
	
	IF @PermissionFolderTypeID IS NULL OR @PermissionFolderTypeID = @StyleFolderTypeID
	BEGIN
		-- Style Folder permissions. This has only "Measurements" group.
		DECLARE @MeasurementWorkflowID UNIQUEIDENTIFIER = '40000000-0000-0000-0000-000000000050'

		UPDATE sPermissionWorkflow SET ParentWorkflowID=@MeasurementWorkflowID
		WHERE WorkflowId IN (
			SELECT WorkflowID FROM pWorkFlow WHERE WorkflowTypeID = '0'
		)
		AND PermissionFolderId IN
		(
			SELECT PermissionFolderId FROM sPermissionFolder WHERE PermissionFolderTypeId = @StyleFolderTypeID
		)
	END
	
	IF @PermissionFolderTypeID IS NULL OR @PermissionFolderTypeID = @LineListFolderTypeID
	BEGIN
		-- Line List Folder has three groups -- Palette Edit, Flash Edit and Line List Planning
		DECLARE @LinePaletteEditWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000002'
		DECLARE @LineFlashEditWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000004'
		DECLARE @LineLineListPlanningWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000001'
		
		UPDATE sPermissionWorkflow SET ParentWorkflowID=@LinePaletteEditWorkflowID
		WHERE WorkflowId IN (
			SELECT LineFolderFlashEditId FROM pLineFolderFlashEdit
		)
		AND PermissionFolderId IN
		(
			SELECT PermissionFolderId FROM sPermissionFolder WHERE PermissionFolderTypeId = @LineListFolderTypeID
		)
		
		UPDATE sPermissionWorkflow SET ParentWorkflowID=@LineFlashEditWorkflowID
		WHERE WorkflowId IN (
			SELECT LineListFlashEditId FROM pLineListFlashEdit
		)
		AND PermissionFolderId IN
		(
			SELECT PermissionFolderId FROM sPermissionFolder WHERE PermissionFolderTypeId = @LineListFolderTypeID
		)
		
		UPDATE sPermissionWorkflow SET ParentWorkflowID=@LineLineListPlanningWorkflowID
		WHERE WorkflowId IN ( 
			'00000000-0000-0000-0000-000000000020', '00000000-0000-0000-0000-000000000021', 
			'00000000-0000-0000-0000-000000000022', '00000000-0000-0000-0000-000000000023',
			'00000000-0000-0000-0000-000000000024'
		)
		AND PermissionFolderId IN
		(
			SELECT PermissionFolderId FROM sPermissionFolder WHERE PermissionFolderTypeId = @LineListFolderTypeID
		)
	END
	
	IF @PermissionFolderTypeID IS NULL OR @PermissionFolderTypeID = @PlanningFolderTypeID
	BEGIN
		-- Planning Folder also has three groups -- Flash Edit, BI and Development Tracker
		DECLARE @PlanningFlashEditWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000006'
		DECLARE @PlanningBIWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000008'
		DECLARE @PlanningDevTrackerWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000002'
		
		UPDATE sPermissionWorkflow SET ParentWorkflowID=@PlanningFlashEditWorkflowID
		WHERE WorkflowId IN (
			 SELECT PlanningFlashEditId FROM pPlanningFlashEdit
		)
		AND PermissionFolderId IN
		(
			SELECT PermissionFolderId FROM sPermissionFolder WHERE PermissionFolderTypeId = @PlanningFolderTypeID
		)
		
		UPDATE sPermissionWorkflow SET ParentWorkflowID=@PlanningBIWorkflowID
		WHERE WorkflowId IN (
			SELECT dfi.DashFolderItemID
			FROM rDashFolderItem dfi INNER JOIN rDashFolder df ON dfi.DashFolderID = df.DashFolderID
			WHERE df.DashFolderName = 'Planning'
		)
		AND PermissionFolderId IN
		(
			SELECT PermissionFolderId FROM sPermissionFolder WHERE PermissionFolderTypeId = @PlanningFolderTypeID
		)
		
		UPDATE sPermissionWorkflow SET ParentWorkflowID=@PlanningDevTrackerWorkflowID
		WHERE WorkflowId IN ( 
			  '00000000-0000-0000-0000-000000000020'
			, '00000000-0000-0000-0000-000000000021'
			, '00000000-0000-0000-0000-000000000022')
		AND PermissionFolderId IN (
			SELECT PermissionFolderId FROM sPermissionFolder WHERE PermissionFolderTypeId = @PlanningFolderTypeID)
	END
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08274', GetDate())
GO
