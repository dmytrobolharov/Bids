

ALTER TABLE Users ADD PreferredLang varchar(50) NULL
GO

UPDATE Users
   SET PreferredLang = 'EN-US'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '002', GetDate())

GO
