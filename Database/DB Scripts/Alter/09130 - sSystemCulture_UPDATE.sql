UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = '.',
	DecimalValidationRegEx = '((\d{1,3})?(\.\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'pt-BR'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = ' ',
	DecimalValidationRegEx = '((\d{1,3})?([\u00A0\s]\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'fr-CA'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = '.',
	DecimalValidationRegEx = '((\d{1,3})?(\.\d{3})*\,?\d*|\d*\,?\d*)'
WHERE CultureName = 'da-DK'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = ' ',
	DecimalValidationRegEx = '((\d{1,3})?([\u00A0\s]\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'sv-FI'

UPDATE sSystemCulture 
SET DecimalValidationRegEx = '((\d{1,3})?([\u00A0\s]\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'fr-FR'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = ' ',
	DecimalValidationRegEx = '((\d{1,3})?([\u00A0\s]\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'nb-NO'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = ' ',
	DecimalValidationRegEx = '((\d{1,3})?([\u00A0\s]\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'pl-PL'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = '.',
	DecimalValidationRegEx = '((\d{1,3})?([.]\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'pt-PT'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = ' ',
	DecimalValidationRegEx = '((\d{1,3})?([\u00A0\s]\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'ru-RU'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = '.',
	DecimalValidationRegEx = '((\d{1,3})?([.]\d{3})*[,]?\d*|\d*[,]?\d*)'
WHERE CultureName = 'es-ES'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = ' ',
	DecimalValidationRegEx = '((\d{1,3})?([\u00A0\s]\d{3})*[,.]?\d*|\d*[,.]?\d*)'
WHERE CultureName = 'sv-SE'

UPDATE sSystemCulture 
SET NumberDecimalSymbol = ',',
	NumberDigitGroupingSymbol = '.',
	DecimalValidationRegEx = '((\d{1,3})?(\.\d{3})*\,?\d*|\d*\,?\d*)'
WHERE CultureName = 'nl-NL'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09130', GetDate())
GO
