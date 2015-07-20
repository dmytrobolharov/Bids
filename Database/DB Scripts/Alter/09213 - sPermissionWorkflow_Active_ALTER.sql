IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sPermissionWorkflow' AND COLUMN_NAME = N'Active')
BEGIN
	ALTER TABLE sPermissionWorkflow 
	ADD Active INT DEFAULT 1
END
GO

UPDATE sPermissionWorkflow SET Active = 1 WHERE Active IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09213', GetDate())
GO
