IF NOT EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'ColorClassID' ) AND name='pColorPalette')
BEGIN
	ALTER TABLE pColorPalette ADD [ColorClassID] uniqueidentifier NULL
END
GO

IF NOT EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'ColorClassID' ) AND name='ColorLibraryPending')
BEGIN
	ALTER TABLE ColorLibraryPending ADD [ColorClassID] uniqueidentifier NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07625', GetDate())
GO