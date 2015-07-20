/****** Object:  Trigger [tgx_rReportFolderItem_PermissionMapping_UPDATE]    Script Date: 24.01.2015 14:13:50 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_rReportFolderItem_PermissionMapping_UPDATE]'))
DROP TRIGGER [dbo].[tgx_rReportFolderItem_PermissionMapping_UPDATE]
GO

/****** Object:  Trigger [dbo].[tgx_rReportFolderItem_PermissionMapping_UPDATE]    Script Date: 24.01.2015 14:13:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[tgx_rReportFolderItem_PermissionMapping_UPDATE]
   ON  [dbo].[rReportFolderItem]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
		BEGIN TRY
		UPDATE pw
		SET Active = rfi.ReportFolderItemActive, PermissionWorkflowName=rfi.ReportItemName
		FROM sPermissionWorkflow pw
		INNER JOIN sPermissionProductType ppt ON ppt.PermissionProductTypeId = pw.PermissionProductTypeId
		INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
		INNER JOIN inserted rfi ON pw.WorkflowId = rfi.ReportFolderItemID
		WHERE pf.PermissionFolderTypeId = 17
	END TRY
	BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09290', GetDate())
GO
