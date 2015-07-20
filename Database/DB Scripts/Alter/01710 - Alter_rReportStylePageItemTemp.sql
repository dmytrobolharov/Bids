IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'rReportStylePageItemTemp' and COLUMN_NAME = N'WorkFlowItemId')
       BEGIN 
            ALTER TABLE rReportStylePageItemTemp ADD WorkFlowItemId uniqueidentifier NULL
       END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01710'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.3000', '01710', GetDate())
	END
GO