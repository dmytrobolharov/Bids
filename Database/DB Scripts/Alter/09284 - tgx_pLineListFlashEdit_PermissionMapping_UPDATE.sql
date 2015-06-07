/****** Object:  Trigger [tgx_pLineListFlashEdit_PermissionMapping_UPDATE]    Script Date: 24.01.2015 13:56:44 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pLineListFlashEdit_PermissionMapping_UPDATE]'))
DROP TRIGGER [dbo].[tgx_pLineListFlashEdit_PermissionMapping_UPDATE]
GO

/****** Object:  Trigger [dbo].[tgx_pLineListFlashEdit_PermissionMapping_UPDATE]    Script Date: 24.01.2015 13:56:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[tgx_pLineListFlashEdit_PermissionMapping_UPDATE]
   ON  [dbo].[pLineListFlashEdit]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		BEGIN TRY
		UPDATE pw
		SET Active = llfe.LineListFlashEditActive, PermissionWorkflowName=llfe.LineListFlashEditName
		FROM sPermissionWorkflow pw
		INNER JOIN sPermissionProductType ppt ON ppt.PermissionProductTypeId = pw.PermissionProductTypeId
		INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
		INNER JOIN inserted llfe ON pw.WorkflowId = llfe.LineListFlashEditID
		WHERE pf.PermissionFolderTypeId = 3
	END TRY
	BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09284', GetDate())
GO
