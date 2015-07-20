IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingHeader' and COLUMN_NAME = N'StyleCostingCustomField3')
       BEGIN 
            ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField3 decimal(18, 3) NULL
       END
GO

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingHeader' and COLUMN_NAME = N'StyleCostingCustomField4')
       BEGIN 
            ALTER TABLE pStyleCostingHeader ALTER COLUMN StyleCostingCustomField4 decimal(18, 3) NULL
       END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01768'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01768', GetDate())
	END
GO