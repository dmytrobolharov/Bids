update sSystemCulture set 
	CurrencyValidationRegEx = '^\$?([1-9]{1}[0-9]{0,2}(\s[0-9]{3})*(\,[0-9]{0,2})?|[1-9]{1}[0-9]{0,}(\,[0-9]{0,2})?|0(\,[0-9]{0,2})?|(\,[0-9]{1,2})?)$', 
	DecimalValidationRegEx='[0-9]+[,]?[0-9]*' 
where CultureName='fr-FR' or CultureName='el-GR'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05397', GetDate())
GO