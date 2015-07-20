

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartner' and COLUMN_NAME = N'Direct')
       BEGIN 
			
            ALTER TABLE uTradePartner ADD Direct int NULL

       END

Go
IF NOT EXISTS (SELECT Direct FROM uTradePartner WHERE Direct = 1)
       BEGIN 
			Update uTradePartner set Direct = 1

       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04327', GetDate())
GO