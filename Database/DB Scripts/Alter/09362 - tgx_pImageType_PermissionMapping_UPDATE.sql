/****** Object:  Trigger [tgx_pImageType_PermissionMapping_UPDATE]    Script Date: 16.02.2015 15:15:09 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pImageType_PermissionMapping_UPDATE]'))
DROP TRIGGER [dbo].[tgx_pImageType_PermissionMapping_UPDATE]
GO

/****** Object:  Trigger [dbo].[tgx_pImageType_PermissionMapping_UPDATE]    Script Date: 16.02.2015 15:15:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[tgx_pImageType_PermissionMapping_UPDATE]
   ON [dbo].[pImageType]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		UPDATE ppt
		SET Active = it.Active, PermissionProductTypeName = it.ImageType
		FROM sPermissionProductType ppt
		INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId
		INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
		INNER JOIN inserted it ON it.ImageTypeID = ptm.GuidProductTypeId
		WHERE pf.PermissionFolderTypeId = 6
	END TRY
	BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09362', GetDate())
GO