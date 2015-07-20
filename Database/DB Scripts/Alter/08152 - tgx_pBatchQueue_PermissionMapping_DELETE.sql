/****** Object:  Trigger [tgx_pBatchQueue_PermissionMapping_DELETE]    Script Date: 07/01/2014 12:47:27 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pBatchQueue_PermissionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_pBatchQueue_PermissionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_pBatchQueue_PermissionMapping_DELETE]    Script Date: 07/01/2014 12:47:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pBatchQueue_PermissionMapping_DELETE]
   ON [dbo].[pBatchQueue]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		DECLARE @BatchQueueFolderType INT = 18
		
		DECLARE @ProductTypeID UNIQUEIDENTIFIER
		DECLARE @WorkflowID UNIQUEIDENTIFIER
	    
		DECLARE DeletedBubbles CURSOR SCROLL
		FOR SELECT BatchQueueID, BatchQueueTypeID FROM deleted
		OPEN DeletedBubbles
	    
		FETCH NEXT FROM DeletedBubbles INTO @WorkflowID, @ProductTypeID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			
			DELETE FROM sPermissionWorkflow WHERE WorkflowId = @WorkflowID
			AND PermissionProductTypeId IN (
				SELECT ppt.PermissionProductTypeId FROM sPermissionProductType ppt 
				INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
				INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId 
				WHERE pf.PermissionFolderTypeId = @BatchQueueFolderType AND ptm.GuidProductTypeId = @ProductTypeID
			)
			
			FETCH NEXT FROM DeletedBubbles INTO @WorkflowID , @ProductTypeID
		END
	    
		CLOSE DeletedBubbles
		DEALLOCATE DeletedBubbles
    END TRY
    BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08152', GetDate())
GO
