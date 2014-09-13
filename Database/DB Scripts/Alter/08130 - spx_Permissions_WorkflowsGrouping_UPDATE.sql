/****** Object:  StoredProcedure [dbo].[spx_Permissions_WorkflowsGrouping_UPDATE]    Script Date: 06/27/2014 16:10:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Permissions_WorkflowsGrouping_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Permissions_WorkflowsGrouping_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Permissions_WorkflowsGrouping_UPDATE]    Script Date: 06/27/2014 16:10:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
		-- Line List Folder has two groups -- Palette Edit and Flash Edit
		DECLARE @LinePaletteEditWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000002'
		DECLARE @LineFlashEditWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000004'
		
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
	END
	
	IF @PermissionFolderTypeID IS NULL OR @PermissionFolderTypeID = @PlanningFolderTypeID
	BEGIN
		-- Planning Folder also has two groups -- Flash Edit and BI
		DECLARE @PlanningFlashEditWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000006'
		DECLARE @PlanningBIWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000008'
		
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
	END
    
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08130', GetDate())
GO
