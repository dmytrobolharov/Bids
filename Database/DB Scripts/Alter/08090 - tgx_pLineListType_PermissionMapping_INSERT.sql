/****** Object:  Trigger [tgx_pLineListType_PermissionMapping_INSERT]    Script Date: 06/26/2014 12:15:35 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pLineListType_PermissionMapping_INSERT]'))
DROP TRIGGER [dbo].[tgx_pLineListType_PermissionMapping_INSERT]
GO

/****** Object:  Trigger [dbo].[tgx_pLineListType_PermissionMapping_INSERT]    Script Date: 06/26/2014 12:15:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pLineListType_PermissionMapping_INSERT]
   ON  [dbo].[pLineListType]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    BEGIN TRY
		DECLARE @LineListFolderTypeID INT = 3
		
		DECLARE @LineListTypeID UNIQUEIDENTIFIER
		DECLARE @LineListTypeName NVARCHAR(200)
		DECLARE @CUser NVARCHAR(200)
		DECLARE @CDate DATETIME
		DECLARE @Active INT
		DECLARE @ProductTypeMapID INT
		
		-- Select Line List workflows in a table
		DECLARE @TempPaletteList TABLE 
		( 
			LinePaletteID UNIQUEIDENTIFIER,
			LinePaletteName NVARCHAR(500),
			LinePaletteDescription NVARCHAR(500),
			LinePaletteSort nVARCHAR(5), 
			Child INT
		)  
		INSERT INTO @TempPaletteList 
		EXEC spx_LineFolderPalette_SELECT 
		
		DECLARE InsertedRows CURSOR SCROLL FOR
		SELECT LineListTypeID, LineListType, ISNULL(CUser, 'System'), ISNULL(CDate, CURRENT_TIMESTAMP), Active
		FROM inserted
		
		OPEN InsertedRows
		FETCH NEXT FROM InsertedRows INTO @LineListTypeID, @LineListTypeName, @CUser, @CDate, @Active
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Inserting product type mapping for Line List Folder
			IF NOT EXISTS(SELECT * FROM sPermissionProductTypeMap 
							WHERE PermissionFolderTypeId = @LineListFolderTypeID AND GuidProductTypeId = @LineListTypeID)
			BEGIN
				INSERT INTO sPermissionProductTypeMap(PermissionFolderTypeId, GuidProductTypeId)
				VALUES(@LineListFolderTypeID, @LineListTypeID)
			END
			
			SELECT @ProductTypeMapID = PermissionProductTypeMapId FROM sPermissionProductTypeMap 
			WHERE PermissionFolderTypeId = @LineListFolderTypeID AND GuidProductTypeId = @LineListTypeID
			
			-- Inserting product types for current folder and all groups 
			INSERT INTO sPermissionProductType (PermissionFolderId, PermissionProductTypeMapId, PermissionProductTypeNotLocked, GroupId,
												CUser, CDate, MUser, MDate, Active, PermissionProductTypeName)
			SELECT PermissionFolderID, @ProductTypeMapID, 1, GroupId,
												@CUser, @CDate, @CUser, @CDate, @Active, @LineListTypeName
			FROM sPermissionFolder pf
			WHERE PermissionFolderTypeId = @LineListFolderTypeID 
			AND NOT EXISTS(SELECT * FROM sPermissionProductType WHERE PermissionFolderId = pf.PermissionFolderId 
							AND PermissionProductTypeMapId = @ProductTypeMapID)
							
			-- Inserting workflow with permissions for product types    
			INSERT INTO sPermissionWorkflow (PermissionFolderId, PermissionProductTypeId, PermissionProductTypeMapId, GroupId, WorkflowId,
											PermissionRoleId, PermissionView, PermissionCreate, PermissionRemove, PermissionModify, PermissionDelete,
											PermissionPrint, CUser, CDate, MUser, MDate, PermissionWorkflowName)
			SELECT PermissionFolderId, PermissionProductTypeId, @ProductTypeMapID, GroupId, tpl.LinePaletteID,
					0, 0, 0, 0, 0, 0, 0, @CUser, @CDate, @CUser, @CDate, tpl.LinePaletteName
			FROM sPermissionProductType pt
			CROSS JOIN @TempPaletteList tpl 
			WHERE PermissionProductTypeMapId = @ProductTypeMapID
			AND NOT EXISTS(SELECT * FROM sPermissionWorkflow WHERE PermissionProductTypeId = pt.PermissionProductTypeId 
							AND WorkflowId = tpl.LinePaletteID)
		
			FETCH NEXT FROM InsertedRows INTO @LineListTypeID, @LineListTypeName, @CUser, @CDate, @Active				
		END
		
    END TRY
    BEGIN CATCH
		PRINT 'An error has occured in trigger ' + ERROR_PROCEDURE() + '. '
		PRINT ERROR_MESSAGE()
	END CATCH

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08090', GetDate())
GO