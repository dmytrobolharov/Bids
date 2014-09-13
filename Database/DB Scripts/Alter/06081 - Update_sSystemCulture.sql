-- regex for german DecimalValidationRegEx and PercentValidationRegEx
UPDATE sSystemCulture 
SET DecimalValidationRegEx = '[0-9]+[,]?[0-9]*',
PercentValidationRegEx = '[0-9]+[,]?[0-9]*[\ ]*[\%]?'
WHERE CultureName = 'de-DE'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06081', GetDate())
GO
