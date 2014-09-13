/****** Object:  Trigger [tgx_pStyleType_PermissionMapping_INSERT]    Script Date: 06/26/2014 10:26:15 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pStyleType_PermissionMapping_INSERT]'))
DROP TRIGGER [dbo].[tgx_pStyleType_PermissionMapping_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_pStyleType_PermissionMapping_INSERT]    Script Date: 06/26/2014 10:26:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pStyleType_PermissionMapping_INSERT]
   ON [dbo].[pStyleType]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @StyleTypeID INT
		DECLARE @StyleTypeDescription NVARCHAR(200)
		DECLARE @CUser NVARCHAR(200)
		DECLARE @CDate DATETIME
		DECLARE @Active INT
		
		-- Related Permission Folders
		DECLARE @StyleFolderTypeID INT = 2
		DECLARE @QuotationFolderTypeID INT = 4
		DECLARE @SampleFolderTypeID INT = 5
		DECLARE @CostingFolderTypeID INT = 12
		DECLARE @OldSourcingFolderTypeID INT = 20
		
		-- Creating temp table for related folders -- this way it will be easier to insert product types
		DECLARE @RelatedFolders TABLE
		(
			FolderTypeID INT,
			FolderTypeName NVARCHAR(200),
			HasSubfolders INT
		)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@QuotationFolderTypeID, 'Quotation', 0)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@CostingFolderTypeID, 'Costing', 0)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@OldSourcingFolderTypeID, 'Old Sourcing', 0)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@StyleFolderTypeID, 'Style', 1)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@SampleFolderTypeID, 'Sample', 1)
		
		DECLARE InsertedRows CURSOR SCROLL
		FOR SELECT StyleTypeID, StyleTypeDescription, ISNULL(CUser, 'System'), ISNULL(CDate, CURRENT_TIMESTAMP), Active
		FROM inserted
		
		OPEN InsertedRows
		FETCH NEXT FROM InsertedRows INTO @StyleTypeID, @StyleTypeDescription, @CUser, @CDate, @Active
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Insert permission mappings for new style types for respective folders
			INSERT INTO sPermissionProductTypeMap (PermissionFolderTypeId, IntProductTypeId)
			SELECT FolderTypeID, @StyleTypeID
			FROM @RelatedFolders pf
			WHERE NOT EXISTS(SELECT * FROM sPermissionProductTypeMap 
								WHERE PermissionFolderTypeId = pf.FolderTypeID AND IntProductTypeId = @StyleFolderTypeID)
			
			-- Insert permission product types for all PermissionFolder for respective folders
			INSERT INTO sPermissionProductType(PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId,
						CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
			SELECT PermissionFolderID, PermissionProductTypeMapID, 1, GroupID, 
					@CUser, @CDate, @CUser, @CDate, 1, @StyleTypeDescription
			FROM sPermissionFolder pf
			CROSS JOIN sPermissionProductTypeMap ptm
			INNER JOIN @RelatedFolders rf ON pf.PermissionFolderTypeId = rf.FolderTypeID AND ptm.PermissionFolderTypeId = pf.PermissionFolderTypeId
			WHERE ptm.IntProductTypeId = @StyleTypeID
			AND NOT EXISTS(SELECT * FROM sPermissionProductType 
							WHERE PermissionProductTypeMapId = ptm.PermissionProductTypeMapId AND PermissionFolderId = pf.PermissionFolderId)

			-- Insert empty workflows for folders without subfolders
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
								PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
								CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT pf.PermissionFolderId, PermissionProductTypeId, ptm.PermissionProductTypeMapID, pf.GroupId, '00000000-0000-0000-0000-000000000000',
						0, 0, 0, 0, 0, 0, 0, @CUser, @CDate, @CUser, @CDate, ''
			FROM sPermissionProductType ppt
			INNER JOIN sPermissionProductTypeMap ptm ON ppt.PermissionProductTypeMapId = ptm.PermissionProductTypeMapId
			INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
			INNER JOIN @RelatedFolders rf ON ptm.PermissionFolderTypeId = rf.FolderTypeID AND pf.PermissionFolderTypeId = rf.FolderTypeID AND rf.HasSubfolders = 0
			WHERE ptm.IntProductTypeId = @StyleTypeID
			AND NOT EXISTS (SELECT * FROM sPermissionWorkflow 
						WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = '00000000-0000-0000-0000-000000000000')
						
			-- Insert REAL workflows for Style folder
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
								PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
								CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT pf.PermissionFolderId, PermissionProductTypeId, ptm.PermissionProductTypeMapID, pf.GroupId, WorkflowID,
						0, 0, 0, 0, 0, 0, 0, @CUser, @CDate, @CUser, @CDate, Workflow
			FROM sPermissionProductType ppt
			INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId AND pf.PermissionFolderTypeId = @StyleFolderTypeID
			INNER JOIN sPermissionProductTypeMap ptm ON ppt.PermissionProductTypeMapId = ptm.PermissionProductTypeMapId
			CROSS JOIN pWorkflow w
			WHERE ptm.IntProductTypeId = @StyleTypeID AND ptm.PermissionFolderTypeId = @StyleFolderTypeID
			AND w.Active = 1 OR w.WorkflowTypeID = '0'
			AND NOT EXISTS (SELECT * FROM sPermissionWorkflow 
						WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = w.WorkflowID)
			
			-- Insert workflows for Sample folder
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
								PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
								CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT pf.PermissionFolderId, PermissionProductTypeId, ptm.PermissionProductTypeMapID, pf.GroupId, sw.SampleWorkflowGUID,
						0, 0, 0, 0, 0, 0, 0, @CUser, @CDate, @CUser, @CDate, sw.SampleWorkflow
			FROM sPermissionProductType ppt
			INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId AND pf.PermissionFolderTypeId = @SampleFolderTypeID
			INNER JOIN sPermissionProductTypeMap ptm ON ppt.PermissionProductTypeMapId = ptm.PermissionProductTypeMapId
			CROSS JOIN pSampleWorkflow sw
			WHERE ptm.IntProductTypeId = @StyleTypeID AND ptm.PermissionFolderTypeId = @SampleFolderTypeID
			AND NOT EXISTS (SELECT * FROM sPermissionWorkflow 
						WHERE PermissionProductTypeId = ppt.PermissionProductTypeId AND WorkflowId = sw.SampleWorkflowGUID)
			
			FETCH NEXT FROM InsertedRows INTO @StyleTypeID, @StyleTypeDescription, @CUser, @CDate, @Active
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
VALUES ('DB_Version', '0.5.0000', '08109', GetDate())
GO