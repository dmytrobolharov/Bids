/****** Object:  Trigger [tgx_pComplianceType_PermisssionMapping_DELETE]    Script Date: 06/26/2014 11:02:19 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pComplianceType_PermisssionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_pComplianceType_PermisssionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_pComplianceType_PermisssionMapping_DELETE]    Script Date: 06/26/2014 11:02:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pComplianceType_PermisssionMapping_DELETE]
   ON  [dbo].[pComplianceType]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @ResourceFolderTypeID INT = 9
		
		DECLARE @DeletedProductTypeID INT
		DECLARE @DeletedProductTypeMapping INT
	    
		DECLARE DeletedRows CURSOR SCROLL FOR
		SELECT ComplianceTypeID FROM deleted
		
		OPEN DeletedRows
		FETCH NEXT FROM DeletedRows INTO @DeletedProductTypeID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @DeletedProductTypeMapping = PermissionProductTypeMapId FROM sPermissionProductTypeMap
			WHERE IntProductTypeId = @DeletedProductTypeID AND PermissionFolderTypeId = @ResourceFolderTypeID
		    
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
VALUES ('DB_Version', '0.5.0000', '08099', GetDate())
GO