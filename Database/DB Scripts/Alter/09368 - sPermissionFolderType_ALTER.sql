IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='sPermissionFolderType' AND COLUMN_NAME='Sort')
BEGIN
	ALTER TABLE sPermissionFolderType
	ADD Sort INT
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09368', GetDate())
GO