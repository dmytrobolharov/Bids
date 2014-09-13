/****** Object:  Trigger [tgx_rDashFolderItem_PermissionMapping_DELETE]    Script Date: 06/27/2014 18:52:23 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_rDashFolderItem_PermissionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_rDashFolderItem_PermissionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_rDashFolderItem_PermissionMapping_DELETE]    Script Date: 06/27/2014 18:52:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_rDashFolderItem_PermissionMapping_DELETE]
   ON [dbo].[rDashFolderItem]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		DECLARE @PlanningFolderTypeID INT = 22
		DECLARE @BIFolderTypeID INT = 17
		DECLARE @BIDashboardProductTypeID INT = 1
		
		DECLARE @WorkflowID UNIQUEIDENTIFIER
	    
		DECLARE DeletedBubbles CURSOR SCROLL
		FOR SELECT DashFolderItemID FROM deleted
		OPEN DeletedBubbles
	    
		FETCH NEXT FROM DeletedBubbles INTO @WorkflowID 
		WHILE @@FETCH_STATUS = 0
		BEGIN
			
			DELETE FROM sPermissionWorkflow WHERE WorkflowId = @WorkflowID
			AND PermissionProductTypeId IN (
				SELECT ppt.PermissionProductTypeId FROM sPermissionProductType ppt 
				INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
				INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId 
				WHERE pf.PermissionFolderTypeId = @PlanningFolderTypeID 
				OR (pf.PermissionFolderTypeId = @BIFolderTypeID AND ptm.IntProductTypeId = @BIDashboardProductTypeID)
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
VALUES ('DB_Version', '0.5.0000', '08140', GetDate())
GO