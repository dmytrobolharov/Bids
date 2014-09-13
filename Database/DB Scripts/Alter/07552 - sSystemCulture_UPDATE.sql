/*--- WI #24140 - changed decimal validator to allow input values like '.75' that means '0.75'  ---*/

UPDATE sSystemCulture SET DecimalValidationRegEx = '[0-9]*[.]?[0-9]*' WHERE DecimalValidationRegEx = '[0-9]+[.]?[0-9]*'
UPDATE sSystemCulture SET DecimalValidationRegEx = '[0-9]*[,]?[0-9]*' WHERE DecimalValidationRegEx = '[0-9]+[,]?[0-9]*'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07552', GetDate())
GO
