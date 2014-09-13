UPDATE sSystemCulture
SET CultureLanguage='Chinese (Simplified)'
WHERE CultureName='zh-CHS'
GO

UPDATE sSystemCulture
SET CultureLanguage='Chinese (Traditional)'
WHERE CultureName='zh-CHT'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03948', GetDate())
GO