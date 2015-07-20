UPDATE sSystemCulture
SET CurrencyValidationRegEx = '^\$?([1-9]{1}[0-9]{0,2}([\u00A0\s][0-9]{3})*([.,][0-9]{0,2})?|[1-9]{1}[0-9]{0,}([,.][0-9]{0,2})?|0([,.][0-9]{0,2})?|([,.][0-9]{1,2})?)$'
	, PercentValidationRegEx = '[0-9]+[,.]?[0-9]*[\s]*[\%]?'
WHERE CultureName = 'sv-SE'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.1.0000', '09155', GetDate())
GO
