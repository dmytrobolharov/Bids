-- regex for german CurrencyValidationRegEx
UPDATE sSystemCulture SET 
	NumberDecimalSymbol = ',', NumberDigitGroupingSymbol = '.', CurrencyDecimalSymbol = ',', CurrencyDigitGroupingSymbol = '.', 
	CurrencyValidationRegEx = '^\$?([1-9]{1}[0-9]{0,2}(\.[0-9]{3})*(\,[0-9]{0,2})?|[1-9]{1}[0-9]{0,}(\,[0-9]{0,2})?|0(\,[0-9]{0,2})?|(\,[0-9]{1,2})?)$'
WHERE CultureName = 'de-DE'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06087', GetDate())
GO
