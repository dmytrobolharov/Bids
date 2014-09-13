
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSourcingAdditionalCost' and COLUMN_NAME = N'TeamID')
       BEGIN 
			
            ALTER TABLE pSourcingAdditionalCost ADD TeamID uniqueidentifier NULL
       END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04296', GetDate())
GO