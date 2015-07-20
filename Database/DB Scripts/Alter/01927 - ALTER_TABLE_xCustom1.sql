IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'xCustom1' and COLUMN_NAME = N'Active')
       BEGIN 
            ALTER TABLE xCustom1 ALTER COLUMN Active INT 
       END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01927'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01927', GetDate())
	END
GO