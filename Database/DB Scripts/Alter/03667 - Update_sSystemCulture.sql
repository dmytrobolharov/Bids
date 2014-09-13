UPDATE sSystemCulture SET DateTimeLongFormat = 'yyyy/M/d HH:mm:ss'
WHERE CultureName IN ('zh-CHS', 'zh-CHT')
GO

UPDATE sSystemCulture SET DateTimeShortFormat = 'yyyy/M/d HH:mm'
WHERE CultureName IN ('zh-CHS', 'zh-CHT')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03667', GetDate())
GO