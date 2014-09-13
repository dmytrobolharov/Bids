IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pCompliance' and COLUMN_NAME = N'ComplianceFileName')
	BEGIN 
		ALTER TABLE pCompliance ALTER COLUMN ComplianceFileName nvarchar(500)
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03442', GetDate())
GO
