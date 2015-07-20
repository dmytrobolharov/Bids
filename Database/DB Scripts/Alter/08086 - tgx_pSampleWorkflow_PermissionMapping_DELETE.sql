/****** Object:  Trigger [tgx_pSampleWorkflow_PermissionMapping_DELETE]    Script Date: 06/26/2014 16:00:48 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pSampleWorkflow_PermissionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_pSampleWorkflow_PermissionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_pSampleWorkflow_PermissionMapping_DELETE]    Script Date: 06/26/2014 16:00:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pSampleWorkflow_PermissionMapping_DELETE]
   ON [dbo].[pSampleWorkflow]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	BEGIN TRY
		DECLARE @SampleFolderTypeID INT = 5
		
		DECLARE @WorkflowID UNIQUEIDENTIFIER
	    
		DECLARE DeletedBubbles CURSOR SCROLL
		FOR SELECT SampleWorkflowGUID FROM deleted
		OPEN DeletedBubbles
	    
		FETCH NEXT FROM DeletedBubbles INTO @WorkflowID 
		WHILE @@FETCH_STATUS = 0
		BEGIN
			
			DELETE FROM sPermissionWorkflow WHERE WorkflowId = @WorkflowID
			AND PermissionProductTypeId IN (
				SELECT ppt.PermissionProductTypeId FROM sPermissionProductType ppt 
				INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
				WHERE pf.PermissionFolderTypeId = @SampleFolderTypeID
			)
			
			FETCH NEXT FROM DeletedBubbles INTO @WorkflowID 
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
VALUES ('DB_Version', '0.5.0000', '08086', GetDate())
GO