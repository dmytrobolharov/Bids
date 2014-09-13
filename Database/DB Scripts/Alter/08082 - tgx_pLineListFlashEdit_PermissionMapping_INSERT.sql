/****** Object:  Trigger [tgx_pLineListFlashEdit_PermissionMapping_INSERT]    Script Date: 06/26/2014 18:44:02 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pLineListFlashEdit_PermissionMapping_INSERT]'))
DROP TRIGGER [dbo].[tgx_pLineListFlashEdit_PermissionMapping_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_pLineListFlashEdit_PermissionMapping_INSERT]    Script Date: 06/26/2014 18:44:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pLineListFlashEdit_PermissionMapping_INSERT]
   ON [dbo].[pLineListFlashEdit]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	BEGIN TRY
		DECLARE @LineListFolderTypeID INT = 3
		DECLARE @ParentWorkflowID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000004' -- Should be under Flash Edit in permissions
	    
		DECLARE @WorkflowID UNIQUEIDENTIFIER
		DECLARE @WorkflowName NVARCHAR(200)
		DECLARE @CUser NVARCHAR(200)
		DECLARE @CDate DATETIME
	    
		DECLARE InsertedBubbles CURSOR SCROLL
		FOR SELECT LineListFlashEditID, LineListFlashEditName, 
			ISNULL(CUser, 'System'), ISNULL(CDate, CURRENT_TIMESTAMP) FROM inserted
		OPEN InsertedBubbles
	    
		FETCH NEXT FROM InsertedBubbles INTO @WorkflowID, @WorkflowName, @CUser, @CDate
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Adding new workflow to each Product Type in Style Folder
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
				PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
				CUser, CDate, MUser, MDate, PermissionWorkflowName, ParentWorkflowID)
			SELECT pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, @WorkflowID,
				0, 0, 0, 0, 0, 0, 0,
				@CUser, @CDate, @CUser, @CDate, @WorkflowName, @ParentWorkflowID
			FROM sPermissionProductType ppt 
			INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
			WHERE pf.PermissionFolderTypeId = @LineListFolderTypeID
			
			FETCH NEXT FROM InsertedBubbles INTO @WorkflowID, @WorkflowName, @CUser, @CDate
		END
	    
		CLOSE InsertedBubbles
		DEALLOCATE InsertedBubbles
    END TRY
    BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08082', GetDate())
GO