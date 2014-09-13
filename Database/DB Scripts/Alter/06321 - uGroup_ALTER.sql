IF NOT EXISTS (SELECT name FROM sysobjects WHERE id IN ( SELECT id FROM syscolumns WHERE name = 'WorkflowGroupID' ) AND name='uGroup')
BEGIN
	ALTER TABLE uGroup ADD [WorkflowGroupID] int IDENTITY(9000,1) NOT NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06321', GetDate())
GO
