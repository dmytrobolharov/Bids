UPDATE sSystemCulture SET PercentValidationRegEx = '[0-9]+[,]?[0-9]*[\ ]*[\%]?' WHERE CultureName = 'fr-FR'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04758', GetDate())
GO
