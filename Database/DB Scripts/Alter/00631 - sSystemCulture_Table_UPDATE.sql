
update sSystemCulture
set culturename='zh-CHS'
where CultureCountry='Chinese (Simplified)'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '631', GetDate())
GO