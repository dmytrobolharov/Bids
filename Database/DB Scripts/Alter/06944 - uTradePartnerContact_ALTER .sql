IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerContact' and COLUMN_NAME = N'MobileNumber')
       BEGIN 
            ALTER TABLE uTradePartnerContact ALTER COLUMN MobileNumber nvarchar(50) NULL
       END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '06944', GetDate())
GO