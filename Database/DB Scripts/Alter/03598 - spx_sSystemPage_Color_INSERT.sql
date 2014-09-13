-- =============================================
-- Author:		Rajul Radadia
-- =============================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	--sSystemPage
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_List_Grid.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_List_Grid.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteList.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteList.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteEdit.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteEdit.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteRGB.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteRGB.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteSeasonYear_List_Grid.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteSeasonYear_List_Grid.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteSeasonYear.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteSeasonYear.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteSort.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteSort.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_Copy_List.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_Copy_List.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_List_Log.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_List_Log.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_Where.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_Where.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteSeasonYearAdd.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteSeasonYearAdd.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteSeasonYearRemove.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteSeasonYearRemove.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteRemove.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteRemove.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_List_Main.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_List_Main.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_Library_RGB.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_Library_RGB.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_Library_Search.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_Library_Search.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_list_New.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_list_New.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03598', GetDate())

GO