/****** Object:  Trigger [tgx_pComponentType_PermisssionMapping_INSERT]    Script Date: 08/21/2014 15:20:46 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pComponentType_PermisssionMapping_INSERT]'))
DROP TRIGGER [dbo].[tgx_pComponentType_PermisssionMapping_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_pComponentType_PermisssionMapping_INSERT]    Script Date: 08/21/2014 15:20:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [dbo].[tgx_pComponentType_PermisssionMapping_INSERT]
   ON  [dbo].[pComponentType]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @MaterialFolderTypeID INT = 8
		DECLARE @MaterialRequestFolderTypeID INT = 24
		
		DECLARE @ComponentTypeID INT
		DECLARE @ComponentTypeName NVARCHAR(200)
		DECLARE @CUser NVARCHAR(200)
		DECLARE @CDate DATETIME
		DECLARE @Active INT
		
		DECLARE @RelatedFolders TABLE
		(
			FolderTypeID INT,
			FolderTypeName NVARCHAR(200),
			HasSubfolders INT
		)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@MaterialFolderTypeID, 'Material', 0)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@MaterialRequestFolderTypeID, 'Material Request', 1)

		DECLARE InsertedRows CURSOR SCROLL
	    FOR SELECT ComponentTypeID, ComponentDescription, ISNULL(CUser, 'System'), ISNULL(CDate, CURRENT_TIMESTAMP), Active
	    FROM inserted
	    
	    OPEN InsertedRows
	    FETCH NEXT FROM InsertedRows INTO @ComponentTypeID, @ComponentTypeName, @CUser, @CDate, @Active
	    
		WHILE @@FETCH_STATUS = 0
	    BEGIN

			-- Inserting product type mapping for Material and Material Request folders
			INSERT INTO sPermissionProductTypeMap (PermissionFolderTypeId, IntProductTypeId)
			SELECT FolderTypeID, @ComponentTypeID
			FROM @RelatedFolders pf
			WHERE NOT EXISTS(SELECT * FROM sPermissionProductTypeMap 
								WHERE PermissionFolderTypeId = pf.FolderTypeID AND IntProductTypeId = @ComponentTypeID)
								
			-- Insert permission product types for all PermissionFolder for respective folders
			INSERT INTO sPermissionProductType(PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId,
						CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
			SELECT PermissionFolderID, PermissionProductTypeMapID, 1, GroupID, 
					@CUser, @CDate, @CUser, @CDate, 1, @ComponentTypeName
			FROM sPermissionFolder pf
			CROSS JOIN sPermissionProductTypeMap ptm
			INNER JOIN @RelatedFolders rf ON pf.PermissionFolderTypeId = rf.FolderTypeID AND ptm.PermissionFolderTypeId = pf.PermissionFolderTypeId
			WHERE ptm.IntProductTypeId = @ComponentTypeID
			AND NOT EXISTS(SELECT * FROM sPermissionProductType 
							WHERE PermissionProductTypeMapId = ptm.PermissionProductTypeMapId AND PermissionFolderId = pf.PermissionFolderId)
		    
			-- Insert empty workflows for product types in Material Folder
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
								PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
								CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT pf.PermissionFolderId, PermissionProductTypeId, ptm.PermissionProductTypeMapID, pf.GroupId, '00000000-0000-0000-0000-000000000000',
						0, 0, 0, 0, 0, 0, 0, @CUser, @CDate, @CUser, @CDate, ''
			FROM sPermissionProductType ppt
			INNER JOIN sPermissionProductTypeMap ptm ON ppt.PermissionProductTypeMapId = ptm.PermissionProductTypeMapId
			INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
			INNER JOIN @RelatedFolders rf ON ptm.PermissionFolderTypeId = rf.FolderTypeID AND pf.PermissionFolderTypeId = rf.FolderTypeID AND rf.HasSubfolders = 0
			WHERE ptm.IntProductTypeId = @ComponentTypeID
			AND NOT EXISTS (SELECT * FROM sPermissionWorkflow 
						WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = '00000000-0000-0000-0000-000000000000')
						
			-- Insert workflows for product types in Material Request folder
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
								PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
								CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT pf.PermissionFolderId, PermissionProductTypeId, ptm.PermissionProductTypeMapID, pf.GroupId, mrw.MaterialRequestWorkflowGUIDID,
						0, 0, 0, 0, 0, 0, 0, @CUser, @CDate, @CUser, @CDate, mrw.MaterialRequestWorkflow
			FROM sPermissionProductType ppt
			INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId AND pf.PermissionFolderTypeId = @MaterialRequestFolderTypeID
			INNER JOIN sPermissionProductTypeMap ptm ON ppt.PermissionProductTypeMapId = ptm.PermissionProductTypeMapId
			CROSS JOIN pMaterialRequestWorkflow mrw
			WHERE ptm.IntProductTypeId = @ComponentTypeID AND ptm.PermissionFolderTypeId = @MaterialRequestFolderTypeID
			AND NOT EXISTS (SELECT * FROM sPermissionWorkflow 
						WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = mrw.MaterialRequestWorkflowGUIDID)
						
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
				PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
				CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT pf.PermissionFolderId, PermissionProductTypeId, ptm.PermissionProductTypeMapId, pf.GroupId, '00000000-0000-0000-0000-000000000001',
				0, 0, 0, 0, 0, 0, 0,
				@CUser, @CDate, @CUser, @CDate, 'Trade Partner Header'
			FROM sPermissionProductType ppt 
			INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId AND pf.PermissionFolderTypeId = @MaterialRequestFolderTypeID
			INNER JOIN sPermissionProductTypeMap ptm ON ppt.PermissionProductTypeMapId = ptm.PermissionProductTypeMapId
			WHERE ptm.PermissionFolderTypeId = @MaterialRequestFolderTypeID AND ptm.IntProductTypeId = @ComponentTypeID
			AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = '00000000-0000-0000-0000-000000000001')
							
			FETCH NEXT FROM InsertedRows INTO @ComponentTypeID, @ComponentTypeName, @CUser, @CDate, @Active
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
VALUES ('DB_Version', '6.0.0000', '08941', GetDate())
GO
