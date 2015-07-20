/****** Object:  Trigger [tgx_pSourcingType_PermisssionMapping_DELETE]    Script Date: 06/25/2014 19:43:58 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pSourcingType_PermisssionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_pSourcingType_PermisssionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_pSourcingType_PermisssionMapping_DELETE]    Script Date: 06/25/2014 19:43:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pSourcingType_PermisssionMapping_DELETE]
   ON  [dbo].[pSourcingType]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @SourcingFolderTypeID INT = 19
		
		DECLARE @DeletedProductTypeID UNIQUEIDENTIFIER
		DECLARE @DeletedProductTypeMapping INT
		
		DECLARE DeletedRows CURSOR SCROLL FOR
		SELECT SourcingTypeID FROM deleted
		
		OPEN DeletedRows
		FETCH NEXT FROM DeletedRows INTO @DeletedProductTypeID
		WHILE @@FETCH_STATUS = 0
	    BEGIN
			SELECT @DeletedProductTypeMapping = PermissionProductTypeMapId FROM sPermissionProductTypeMap
			WHERE GuidProductTypeId = @DeletedProductTypeID AND PermissionFolderTypeId = @SourcingFolderTypeID
		    
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
VALUES ('DB_Version', '0.5.0000', '08110', GetDate())
GO