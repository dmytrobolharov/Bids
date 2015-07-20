IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ColorLibraryPending' AND COLUMN_NAME = 'isUpload')
BEGIN
	ALTER TABLE ColorLibraryPending ADD isUpload INT NULL DEFAULT(0)
END
GO

UPDATE ColorLibraryPending SET isUpload = 0
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07897', GetDate())
GO
