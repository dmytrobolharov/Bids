UPDATE sSystemCulture SET CurrencyValidationRegEx='^\$?([1-9]{1}[0-9]{0,2}(\,[0-9]{3})*(\.[0-9]{0,2})?|[1-9]{1}[0-9]{0,}(\.[0-9]{0,2})?|0(\.[0-9]{0,2})?|(\.[0-9]{1,2})?)$' WHERE CurrencyValidationRegEx='[0-9]+[.]?[0-9][0-9]'
UPDATE sSystemCulture SET PercentValidationRegEx='[0-9]+[.]?[0-9]*[\ ]*[\%]?' WHERE PercentValidationRegEx='[0-9]+[.]?[0-9]*'

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04020', GetDate())
GO 