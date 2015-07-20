/****** Object:  Trigger [tgx_rReportFolderItem_PermissionMapping_INSERT]    Script Date: 07/01/2014 11:26:10 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_rReportFolderItem_PermissionMapping_INSERT]'))
DROP TRIGGER [dbo].[tgx_rReportFolderItem_PermissionMapping_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_rReportFolderItem_PermissionMapping_INSERT]    Script Date: 07/01/2014 11:26:10 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_rReportFolderItem_PermissionMapping_INSERT]
   ON  [dbo].[rReportFolderItem]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		DECLARE @BIFolderTypeID INT = 17
		
		DECLARE @ReportProductTypeID INT = 2
		DECLARE @ProductTypeMapID INT
	    
		DECLARE @WorkflowID UNIQUEIDENTIFIER
		DECLARE @WorkflowName NVARCHAR(200)
		DECLARE @CUser NVARCHAR(200)
		DECLARE @CDate DATETIME
	    
		DECLARE InsertedBubbles CURSOR SCROLL
		FOR SELECT ReportFolderItemID, ReportItemName, 'System', CURRENT_TIMESTAMP FROM inserted
		OPEN InsertedBubbles
	    
		FETCH NEXT FROM InsertedBubbles INTO @WorkflowID, @WorkflowName, @CUser, @CDate
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Adding a respective product type ("Reports" subfolder of BI folder), if it does not exist already
			
			-- Inserting product type mapping for Report Folder
			IF NOT EXISTS(SELECT * FROM sPermissionProductTypeMap 
							WHERE PermissionFolderTypeId = @BIFolderTypeID AND IntProductTypeId = @ReportProductTypeID)
			BEGIN
				INSERT INTO sPermissionProductTypeMap(PermissionFolderTypeId, IntProductTypeId)
				VALUES(@BIFolderTypeID, @ReportProductTypeID)
			END
			
			SELECT @ProductTypeMapID = PermissionProductTypeMapId FROM sPermissionProductTypeMap 
			WHERE PermissionFolderTypeId = @BIFolderTypeID AND IntProductTypeId = @ReportProductTypeID
			
			-- Inserting subfolder for BI folder and all groups 
			INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId,
												CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
			SELECT PermissionFolderID, @ProductTypeMapID, 1, GroupId,
												@CUser, @CDate, @CUser, @CDate, 1, 'Report'
			FROM sPermissionFolder pf
			WHERE PermissionFolderTypeId = @BIFolderTypeID 
			AND NOT EXISTS(SELECT * FROM sPermissionProductType WHERE PermissionFolderId = pf.PermissionFolderId 
							AND PermissionProductTypeMapId = @ProductTypeMapID)
			
			-- Adding a bubble to the BI folder "Report" subfolder
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
				PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
				CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, @WorkflowID,
				0, 0, 0, 0, 0, 0, 0,
				@CUser, @CDate, @CUser, @CDate, @WorkflowName
			FROM sPermissionProductType ppt
			INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
			WHERE pf.PermissionFolderTypeId = @BIFolderTypeID AND PermissionProductTypeMapId = @ProductTypeMapID 
			AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = ppt.PermissionProductTypeId 
							AND WorkflowId = @WorkflowID)
			
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
VALUES ('DB_Version', '0.5.0000', '08149', GetDate())
GO
