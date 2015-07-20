UPDATE Users
   SET PreferredLang = 'en-US'
WHERE PreferredLang is NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '101', GetDate())
GO
