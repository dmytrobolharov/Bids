/****** Object:  Trigger [tgx_pBatchQueue_PermissionMapping_INSERT]    Script Date: 07/01/2014 12:47:20 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pBatchQueue_PermissionMapping_INSERT]'))
DROP TRIGGER [dbo].[tgx_pBatchQueue_PermissionMapping_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_pBatchQueue_PermissionMapping_INSERT]    Script Date: 07/01/2014 12:47:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pBatchQueue_PermissionMapping_INSERT]
   ON [dbo].[pBatchQueue]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		DECLARE @BatchQueueFolderType INT = 18
		
		DECLARE @BatchQueueTypeID UNIQUEIDENTIFIER
		DECLARE @BatchQueueTypeName NVARCHAR(200)
		DECLARE @ProductTypeMapID INT
	    
		DECLARE @WorkflowID UNIQUEIDENTIFIER
		DECLARE @WorkflowName NVARCHAR(200)
		DECLARE @CUser NVARCHAR(200)
		DECLARE @CDate DATETIME
	    
		DECLARE InsertedBubbles CURSOR SCROLL
		FOR SELECT BatchQueueID, BatchQueueName, BatchQueueTypeID, CUser, CDate FROM inserted
		OPEN InsertedBubbles
	    
		FETCH NEXT FROM InsertedBubbles INTO @WorkflowID, @WorkflowName, @BatchQueueTypeID, @CUser, @CDate
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Adding a respective product type for BatchQ folder, if it isn't exist already
			SELECT @BatchQueueTypeName = BatchQueueTypeName FROM pBatchQueueType WHERE BatchQueueTypeID = @BatchQueueTypeID
			
			IF NOT @BatchQueueTypeName IS NULL
			BEGIN
				-- Inserting product type mapping for Report Folder
				IF NOT EXISTS(SELECT * FROM sPermissionProductTypeMap 
								WHERE PermissionFolderTypeId = @BatchQueueFolderType AND GuidProductTypeId = @BatchQueueTypeID)
				BEGIN
					INSERT INTO sPermissionProductTypeMap(PermissionFolderTypeId, GuidProductTypeId)
					VALUES(@BatchQueueFolderType, @BatchQueueTypeID)
				END
				
				SELECT @ProductTypeMapID = PermissionProductTypeMapId FROM sPermissionProductTypeMap 
				WHERE PermissionFolderTypeId = @BatchQueueFolderType AND GuidProductTypeId = @BatchQueueTypeID
				
				-- Inserting subfolder for Batch Queue folder and all groups 
				INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId,
													CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
				SELECT PermissionFolderID, @ProductTypeMapID, 1, GroupId,
													@CUser, @CDate, @CUser, @CDate, 1, @BatchQueueTypeName
				FROM sPermissionFolder pf
				WHERE PermissionFolderTypeId = @BatchQueueFolderType 
				AND NOT EXISTS(SELECT * FROM sPermissionProductType WHERE PermissionFolderId = pf.PermissionFolderId 
								AND PermissionProductTypeMapId = @ProductTypeMapID)
				
				-- Adding a bubble to the given subfolder
				INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
					PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete, PermissionPrint,
					CUser, CDate, MUser, MDate, PermissionWorkflowName)
				SELECT pf.PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, pf.GroupId, @WorkflowID,
					0, 0, 0, 0, 0, 0, 0,
					@CUser, @CDate, @CUser, @CDate, @WorkflowName
				FROM sPermissionProductType ppt
				INNER JOIN sPermissionFolder pf ON ppt.PermissionFolderId = pf.PermissionFolderId
				WHERE pf.PermissionFolderTypeId = @BatchQueueFolderType AND ppt.PermissionProductTypeMapId = @ProductTypeMapID 
				AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = ppt.PermissionProductTypeId 
								AND WorkflowId = @WorkflowID)
			END
			ELSE
			BEGIN
				RAISERROR('The Batch Queue Type with given BatchQueueTypeID does not exist or has NULL name', 16, 1)
			END
				
			FETCH NEXT FROM InsertedBubbles INTO @WorkflowID, @WorkflowName, @BatchQueueTypeID, @CUser, @CDate
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
VALUES ('DB_Version', '0.5.0000', '08151', GetDate())
GO
