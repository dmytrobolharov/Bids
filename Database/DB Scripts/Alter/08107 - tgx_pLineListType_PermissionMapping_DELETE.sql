/****** Object:  Trigger [tgx_pLineListType_PermissionMapping_DELETE]    Script Date: 06/26/2014 10:37:45 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pLineListType_PermissionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_pLineListType_PermissionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_pLineListType_PermissionMapping_DELETE]    Script Date: 06/26/2014 10:37:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pLineListType_PermissionMapping_DELETE]
   ON  [dbo].[pLineListType]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
    BEGIN TRY
		DECLARE @LineListFolderTypeID INT = 3
		DECLARE @DeletedProductTypeID UNIQUEIDENTIFIER
		DECLARE @DeletedProductTypeMapping INT
		
		DECLARE DeletedRows CURSOR SCROLL FOR
		SELECT LineListTypeID FROM deleted
		
		OPEN DeletedRows
		FETCH NEXT FROM DeletedRows INTO @DeletedProductTypeID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @DeletedProductTypeMapping = PermissionProductTypeMapId FROM sPermissionProductTypeMap
			WHERE GuidProductTypeId = @DeletedProductTypeID AND PermissionFolderTypeId = @LineListFolderTypeID
		    
			DELETE FROM sPermissionWorkflow WHERE PermissionProductTypeMapId = @DeletedProductTypeMapping
			DELETE FROM sPermissionProductType WHERE PermissionProductTypeMapId = @DeletedProductTypeMapping
			DELETE FROM sPermissionProductTypeMap WHERE PermissionProductTypeMapId = @DeletedProductTypeMapping
			
			FETCH NEXT FROM DeletedRows INTO @DeletedProductTypeID
		END
		CLOSE DeletedRows
		DEALLOCATE DeletedRows
		
	END TRY
	BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08107', GetDate())
GO