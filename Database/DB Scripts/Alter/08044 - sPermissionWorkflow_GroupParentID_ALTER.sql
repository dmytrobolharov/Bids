IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'sPermissionWorkflow' AND COLUMN_NAME = 'ParentWorkflowID')
BEGIN
	ALTER TABLE sPermissionWorkflow ADD ParentWorkflowID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08044', GetDate())
GO
