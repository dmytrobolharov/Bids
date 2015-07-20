/****** Object:  Trigger [tgx_iCustom1_PermissionMapping_DELETE]    Script Date: 16.02.2015 15:11:31 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_iCustom1_PermissionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_iCustom1_PermissionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_iCustom1_PermissionMapping_DELETE]    Script Date: 16.02.2015 15:11:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE TRIGGER [dbo].[tgx_iCustom1_PermissionMapping_DELETE]
   ON  [dbo].[iCustom1]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
		DECLARE @DivisionFolderTypeID INT = 26
		DECLARE @DeletedProductTypeID UNIQUEIDENTIFIER
		DECLARE @DeletedProductTypeMapping INT
		
		DECLARE DeletedRows CURSOR SCROLL FOR
		SELECT CustomID FROM deleted
		
		OPEN DeletedRows
		FETCH NEXT FROM DeletedRows INTO @DeletedProductTypeID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @DeletedProductTypeMapping = PermissionProductTypeMapId FROM sPermissionProductTypeMap
			WHERE GuidProductTypeId = @DeletedProductTypeID AND PermissionFolderTypeId = @DivisionFolderTypeID
		    
			DELETE FROM sPermissionWorkflow WHERE PermissionProductTypeMapId = @DeletedProductTypeMapping
			DELETE FROM sPermissionProductType WHERE PermissionProductTypeMapId = @DeletedProductTypeMapping
			DELETE FROM sPermissionProductTypeMap WHERE PermissionProductTypeMapId = @DeletedProductTypeMapping
			
			FETCH NEXT FROM DeletedRows INTO @DeletedProductTypeID
		END
		CLOSE DeletedRows
		DEALLOCATE DeletedRows
	END TRY
	BEGIN CATCH
		PRINT 'An error has occured in ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH
    
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09360', GetDate())
GO