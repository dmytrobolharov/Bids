UPDATE Users
SET PreferredLang = 'en-US'
WHERE UserName = 'administrator'

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01102', GetDate())
GO