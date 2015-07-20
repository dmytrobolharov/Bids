
update sSystemCulture
set DateShortFormat= 'yyyy/MM/dd'
where CultureName = 'zh-CHS'

GO

update sSystemCulture
set DateShortFormat= 'yyyy/MM/dd'
where CultureName = 'zh-CHT'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01323', GetDate())

GO