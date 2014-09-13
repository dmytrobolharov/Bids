/****** Object:  Trigger [tgx_pStyleType_PermissionMapping_DELETE]    Script Date: 06/26/2014 10:26:24 ******/
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tgx_pStyleType_PermissionMapping_DELETE]'))
DROP TRIGGER [dbo].[tgx_pStyleType_PermissionMapping_DELETE]
GO

/****** Object:  Trigger [dbo].[tgx_pStyleType_PermissionMapping_DELETE]    Script Date: 06/26/2014 10:26:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[tgx_pStyleType_PermissionMapping_DELETE]
   ON  [dbo].[pStyleType] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	BEGIN TRY
	
		-- Related Permission Folders
		DECLARE @StyleFolderTypeID INT = 2
		DECLARE @QuotationFolderTypeID INT = 4
		DECLARE @SampleFolderTypeID INT = 5
		DECLARE @CostingFolderTypeID INT = 12
		DECLARE @OldSourcingFolderTypeID INT = 20
		
		-- Creating temp table for related folders -- this way it will be easier to delete product types
		DECLARE @RelatedFolders TABLE
		(
			FolderTypeID INT,
			FolderTypeName NVARCHAR(200),
			HasSubfolders INT
		)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@QuotationFolderTypeID, 'Quotation', 0)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@CostingFolderTypeID, 'Costing', 0)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@OldSourcingFolderTypeID, 'Old Sourcing', 0)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@StyleFolderTypeID, 'Style', 1)
		INSERT INTO @RelatedFolders (FolderTypeID, FolderTypeName, HasSubfolders) VALUES (@SampleFolderTypeID, 'Sample', 1)
		
		DECLARE @DeletedStyleType INT
		
		DECLARE DeletedRows CURSOR SCROLL
		FOR SELECT StyleTypeID FROM deleted
		
		OPEN DeletedRows
		FETCH NEXT FROM DeletedRows INTO @DeletedStyleType
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			-- Delete related workflows
			DELETE FROM sPermissionWorkflow WHERE PermissionProductTypeId 
			IN (
				SELECT PermissionProductTypeId FROM sPermissionProductType ppt
				INNER JOIN sPermissionProductTypeMap ptm ON ptm.PermissionProductTypeMapId = ppt.PermissionProductTypeMapId
				INNER JOIN sPermissionFolder pf ON pf.PermissionFolderId = ppt.PermissionFolderId
				INNER JOIN @RelatedFolders rf ON pf.PermissionFolderTypeId = rf.FolderTypeID AND ptm.PermissionFolderTypeId = rf.FolderTypeID
				WHERE ptm.IntProductTypeId = @DeletedStyleType
			)
			-- Delete related product types
			DELETE FROM sPermissionProductType WHERE PermissionProductTypeMapId
			IN (
				SELECT PermissionProductTypeMapId FROM sPermissionProductTypeMap ptm
				INNER JOIN @RelatedFolders rf ON ptm.PermissionFolderTypeId = rf.FolderTypeID
				WHERE ptm.IntProductTypeId = @DeletedStyleType
			)
			
			-- Delete related mappings from product type mapping
			DELETE FROM sPermissionProductTypeMap WHERE IntProductTypeId = @DeletedStyleType AND PermissionFolderTypeId IN
			(
				SELECT FolderTypeID FROM @RelatedFolders
			)
			
			FETCH NEXT FROM DeletedRows INTO @DeletedStyleType
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
VALUES ('DB_Version', '0.5.0000', '08108', GetDate())
GO