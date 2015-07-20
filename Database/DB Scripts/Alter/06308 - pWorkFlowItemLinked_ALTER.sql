IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pWorkFlowItemLinked' AND COLUMN_NAME = 'Sort')
BEGIN
	ALTER TABLE pWorkFlowItemLinked ALTER COLUMN Sort [nvarchar](4)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06308', GetDate())
GO
