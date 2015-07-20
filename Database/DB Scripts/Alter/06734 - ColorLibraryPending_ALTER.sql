--WI # 21576 : Color Folder - Create New Unique ID for pColorPalette

IF NOT EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'ColorLibraryID' ) AND name='ColorLibraryPending')
BEGIN
	ALTER TABLE ColorLibraryPending ADD [ColorLibraryID] uniqueidentifier NULL
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06734', GetDate())
GO
