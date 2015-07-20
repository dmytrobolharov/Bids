/****** Object:  Trigger [tgx_pControlPanel_PermisssionMapping_DELETE]    Script Date: 06/26/2014 11:11:01 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pControlPanel_PermisssionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_pControlPanel_PermisssionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_pControlPanel_PermisssionMapping_DELETE]    Script Date: 06/26/2014 11:11:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pControlPanel_PermisssionMapping_DELETE]
   ON  [dbo].[pControlPanel]
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @ControlPanelFolderTypeID INT = 10
		
		DECLARE @DeletedProductTypeID INT
		DECLARE @DeletedProductTypeMapping INT
	    
		DECLARE DeletedRows CURSOR SCROLL FOR
		SELECT ControlPanelID FROM deleted
		
		OPEN DeletedRows
		FETCH NEXT FROM DeletedRows INTO @DeletedProductTypeID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT @DeletedProductTypeMapping = PermissionProductTypeMapId FROM sPermissionProductTypeMap
			WHERE IntProductTypeId = @DeletedProductTypeID AND PermissionFolderTypeId = @ControlPanelFolderTypeID
		    
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
VALUES ('DB_Version', '0.5.0000', '08097', GetDate())
GO