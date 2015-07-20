--WI # 21576 : Color Folder - Create New Unique ID for pColorPalette

IF NOT EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'ColorLibraryID' ) AND name='ColorLibrary')
BEGIN
	ALTER TABLE ColorLibrary ADD [ColorLibraryID] uniqueidentifier NULL
	ALTER TABLE ColorLibrary ADD CONSTRAINT [DF_ColorLibrary_ColorLibraryID]  DEFAULT (newid()) FOR [ColorLibraryID]
	
	EXEC('UPDATE ColorLibrary SET ColorLibraryID = newid() WHERE ColorLibraryID IS NULL')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06732', GetDate())
GO
