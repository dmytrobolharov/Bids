/****** Object:  Trigger [tgx_pSourcingType_PermissionMapping_UPDATE]    Script Date: 24.01.2015 13:38:27 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pSourcingType_PermissionMapping_UPDATE]'))
DROP TRIGGER [dbo].[tgx_pSourcingType_PermissionMapping_UPDATE]
GO

/****** Object:  Trigger [dbo].[tgx_pSourcingType_PermissionMapping_UPDATE]    Script Date: 24.01.2015 13:38:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[tgx_pSourcingType_PermissionMapping_UPDATE]
   ON  [dbo].[pSourcingType]
   AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		UPDATE ppt
		SET Active = st.Active, PermissionProductTypeName = st.SourcingTypeName
		FROM sPermissionProductType ppt
		INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId
		INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
		INNER JOIN inserted st ON st.SourcingTypeId = ptm.GuidProductTypeId
		WHERE pf.PermissionFolderTypeId = 19
	END TRY
	BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09288', GetDate())
GO
