UPDATE sSystemCulture
SET CultureCountry = 'United States'
WHERE CultureIndentifierID = '0x0409'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '114', GetDate())
GO