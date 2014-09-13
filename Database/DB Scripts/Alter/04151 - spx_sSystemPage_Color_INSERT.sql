
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
	
	IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_Palette_SeasonYearAdd.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_Palette_SeasonYearAdd.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_Palette_SeasonYearDelete.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_Palette_SeasonYearDelete.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_PaletteSeasonYearRemove.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_PaletteSeasonYearRemove.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	
		IF NOT EXISTS(SELECT * FROM sSystemPage WHERE MappingPage='Color_Library_Search.aspx')
	BEGIN
		INSERT INTO [sSystemPage] (MappingPage, CDate, CUser, sSystemFolderID)
		VALUES ('Color_Library_Search.aspx', GETDATE(), 'Administrator', (SELECT sSystemFolderID from sSystemFolder where sSystemFolder='Color'))
	END
	GO
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04151', GetDate())
GO
	
		