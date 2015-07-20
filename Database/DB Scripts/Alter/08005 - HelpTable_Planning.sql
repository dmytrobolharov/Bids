SET ANSI_NULLS ON

GO

IF NOT EXISTS(SELECT * FROM sSystemFolder WHERE sSystemFolder='Planning')
	BEGIN
		INSERT INTO [sSystemFolder] (sSystemFolder, CDate, CUser)
		VALUES ('Planning', GETDATE(), 'Administrator')
	END	
	GO
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Color_WhereUsed.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_Color_WhereUsed.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_FlashEdit_Color.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_FlashEdit_Color.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO
	
IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_FlashEdit_Color_Dropped.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_FlashEdit_Color_Dropped.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO
	
IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_FlashEdit_Image.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_FlashEdit_Image.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_FlashEdit_Material.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_FlashEdit_Material.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_FlashEdit_Style.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_FlashEdit_Style.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Color.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Color.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Color_AddColor.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Color_AddColor.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Color_ColorPalette.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Color_ColorPalette.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Color_ColorReplace.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Color_ColorReplace.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Color_Import.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Color_Import.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Color_Missing.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Color_Missing.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Color_Plan.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Color_Plan.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Configuration.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Configuration.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_DevelopmentTracker.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_DevelopmentTracker.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_FinancialPlan.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_FinancialPlan.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_FinancialPlan_Edit.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_FinancialPlan_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_FlashEditList.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_FlashEditList.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_FlashEditPage.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_FlashEditPage.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_LineList.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_LineList.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_LineList_AddExisting.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_LineList_AddExisting.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_LineList_Configuration.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_LineList_Configuration.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_LineList_Edit.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_LineList_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_LineList_New.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_LineList_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_LineListStyles_Dropped.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_LineListStyles_Dropped.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_LineListStyles_Missing.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_LineListStyles_Missing.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Material.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Material.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Material_Add.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Material_Add.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Material_Import.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Material_Import.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Material_MaterialReplace.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Material_MaterialReplace.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Material_Missing.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Material_Missing.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Material_Plan.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Material_Plan.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_SKUPlan.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_SKUPlan.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_SKUPlan_Edit.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_SKUPlan_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_SKUPlan_List.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_SKUPlan_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_SKUPlan_List_Edit.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_SKUPlan_List_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Style_Import.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Style_Import.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Folder_Style_Search.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_Folder_Style_Search.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Grid.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_Grid.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_History.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_History.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_Material_WhereUsed.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_Material_WhereUsed.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO
	
IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_New.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_SavedSearch_Edit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Planning_SavedSearch_Edit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
	END
	GO
	
IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_SavedSearch_List.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_SavedSearch_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_SavedSearch_New.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_SavedSearch_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_SKUPlan_New.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_SKUPlan_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Planning_StyleProperty.aspx')
BEGIN
	INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
	VALUES ('Planning_StyleProperty.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning'))
END
GO

SET QUOTED_IDENTIFIER ON
GO

DECLARE @HelpTable TABLE
(
	ID				INT IDENTITY (1, 1) PRIMARY KEY NOT NULL,
	DesignString	NVARCHAR(200),
	sSystemPageID	UNIQUEIDENTIFIER,
	CDate			DATETIME,
	CUser			NVARCHAR(50)
)

DECLARE @theCount int
DECLARE @theMax int

INSERT INTO @HelpTable (DesignString, sSystemPageID, CDate, CUser)
SELECT MappingPage, sSystemPageID, GETDATE(), 'Administrator' FROM sSystemPage
WHERE sSystemFolderID = (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Planning')

SET @theCount = 1
SELECT @theMax = COUNT(ID) FROM @HelpTable

WHILE (@theCount <= @theMax)
BEGIN
	IF NOT EXISTS(SELECT * FROM sSystemHelp WHERE DesignString=(SELECT DesignString FROM @HelpTable WHERE ID = @theCount))
	BEGIN
		INSERT INTO sSystemHelp (DesignString, sSystemPageID, CDate, CUser)
		SELECT DesignString, sSystemPageID, CDate, CUser FROM @HelpTable
		WHERE ID = @theCount
	END
	SET @theCount = @theCount + 1
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08005', GetDate())
GO
