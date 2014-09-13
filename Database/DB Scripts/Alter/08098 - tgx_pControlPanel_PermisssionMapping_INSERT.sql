/****** Object:  Trigger [tgx_pControlPanel_PermisssionMapping_INSERT]    Script Date: 06/26/2014 11:10:54 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pControlPanel_PermisssionMapping_INSERT]'))
DROP TRIGGER [dbo].[tgx_pControlPanel_PermisssionMapping_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_pControlPanel_PermisssionMapping_INSERT]    Script Date: 06/26/2014 11:10:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pControlPanel_PermisssionMapping_INSERT]
   ON  [dbo].[pControlPanel]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @ControlPanelFolderTypeID INT = 10
		
		DECLARE @ControlPanelID INT
		DECLARE @ControlPanelName NVARCHAR(200)
		DECLARE @CUser NVARCHAR(200)
		DECLARE @CDate DATETIME
		DECLARE @Active INT
		DECLARE @ProductTypeMapID INT
		
		DECLARE InsertedRows CURSOR SCROLL
	    FOR SELECT ControlPanelID, ControlPanelName, 'System', CURRENT_TIMESTAMP, 1
	    FROM inserted
	    
	    OPEN InsertedRows
	    FETCH NEXT FROM InsertedRows INTO @ControlPanelID, @ControlPanelName, @CUser, @CDate, @Active
	    
		WHILE @@FETCH_STATUS = 0
	    BEGIN
			-- Inserting product type mapping for Image Folder
			IF NOT EXISTS(SELECT * FROM sPermissionProductTypeMap 
							WHERE PermissionFolderTypeId = @ControlPanelFolderTypeID AND IntProductTypeId = @ControlPanelID)
			BEGIN
				INSERT INTO sPermissionProductTypeMap(PermissionFolderTypeId, IntProductTypeId)
				VALUES(@ControlPanelFolderTypeID, @ControlPanelID)
			END
			
			SELECT @ProductTypeMapID = PermissionProductTypeMapID FROM sPermissionProductTypeMap 
			WHERE PermissionFolderTypeId = @ControlPanelFolderTypeID AND IntProductTypeId = @ControlPanelID
		    
			-- Inserting product types for current folder and all groups 
			INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId,
												CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
			SELECT PermissionFolderID, @ProductTypeMapID, 1, GroupId,
												@CUser, @CDate, @CUser, @CDate, @Active, @ControlPanelName
			FROM sPermissionFolder pf
			WHERE PermissionFolderTypeId = @ControlPanelFolderTypeID 
			AND NOT EXISTS(SELECT * FROM sPermissionProductType WHERE PermissionFolderId = pf.PermissionFolderId 
							AND PermissionProductTypeMapId = @ProductTypeMapID)
		    
			-- Inserting workflow with permissions for product types    
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
											PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete,
											PermissionPrint, CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT PermissionFolderId, PermissionProductTypeId, @ProductTypeMapID, GroupId, '00000000-0000-0000-0000-000000000000',
					0, 0, 0, 0, 0, 0, 0, @CUser, @CDate, @CUser, @CDate, ''
			FROM sPermissionProductType pt
			WHERE PermissionProductTypeMapId = @ProductTypeMapID
			AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = pt.PermissionProductTypeId 
							AND WorkflowId='00000000-0000-0000-0000-000000000000')
			
			FETCH NEXT FROM InsertedRows INTO @ControlPanelID, @ControlPanelName, @CUser, @CDate, @Active		
		END
		
		CLOSE InsertedRows
		DEALLOCATE InsertedRows
		
	END TRY
	BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08098', GetDate())
GO