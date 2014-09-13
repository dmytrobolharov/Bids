IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerContact' and COLUMN_NAME = N'PreferredLang')
       BEGIN 
             ALTER TABLE uTradePartnerContact ADD PreferredLang NVARCHAR(50) NULL
       END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01287', GetDate())
GO