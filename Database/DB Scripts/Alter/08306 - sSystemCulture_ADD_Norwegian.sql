IF NOT EXISTS(SELECT CultureIndentifierID FROM sSystemCulture WHERE CultureIndentifierID=N'0x0414')  
BEGIN
	INSERT INTO sSystemCulture(
				CultureIndentifierID
			   ,CultureName
			   ,CultureCountry
			   ,CultureLanguage
			   ,Active
			   ,Unicode
			   ,DecimalValidationRegEx
			   ,DateValidationRegEx
			   ,CurrencyValidationRegEx
			   ,DateShortFormat
			   ,DateLongFormat
			   ,TimeShortFormat
			   ,TimeLongFormat
			   ,NumberDecimalSymbol
			   ,NumberDigitGroupingSymbol
			   ,CurrencySymbol
			   ,CurrencyDecimalSymbol
			   ,CurrencyDigitGroupingSymbol
			   ,DateTimeShortFormat
			   ,DateTimeLongFormat
			   ,CurrencyFormat
			   ,PercentFormat
			   ,PercentValidationRegEx
			   ,DecimalFormat
			   ,SystemCultureId)
		 VALUES(
				N'0x0414'
			   ,N'nb-NO'
			   ,N'Norway'
			   ,N'Norwegian'
			   ,1
			   ,0
			   ,N'((\d{1,3})?(\.\d{3})*[,]?\d*|\d*[,]?\d*)'
			   ,N'^(?=\d)(?:(?!(?:(?:0?[5-9]|1[0-4])(?:\.|-|\/)10(?:\.|-|\/)(?:1582))|(?:(?:0?[3-9]|1[0-3])(?:\.|-|\/)0?9(?:\.|-|\/)(?:1752)))(31(?!(?:\.|-|\/)(?:0?[2469]|11))|30(?!(?:\.|-|\/)0?2)|(?:29(?:(?!(?:\.|-|\/)0?2(?:\.|-|\/))|(?=\D0?2\D(?:(?!000[04]|(?:(?:1[^0-6]|[2468][^048]|[3579][^26])00))(?:(?:(?:\d\d)(?:[02468][048]|[13579][26])(?!\x20BC))|(?:00(?:42|3[0369]|2[147]|1[258]|09)\x20BC))))))|2[0-8]|1\d|0?[1-9])([-.\/])(1[012]|(?:0?[1-9]))\2((?=(?:00(?:4[0-5]|[0-3]?\d)\x20BC)|(?:\d{4}(?:$|(?=\x20\d)\x20)))\d{4}(?:\x20BC)?)(?:$|(?=\x20\d)\x20))?((?:(?:0?[1-9]|1[012])(?::[0-5]\d){0,2}(?:\x20[aApP][mM]))|(?:[01]\d|2[0-3])(?::[0-5]\d){1,2})?$'
			   ,N'^\$?([1-9]{1}[0-9]{0,2}(\s[0-9]{3})*(\,[0-9]{0,2})?|[1-9]{1}[0-9]{0,}(\,[0-9]{0,2})?|0(\,[0-9]{0,2})?|(\,[0-9]{1,2})?)$'
			   ,N'd'
			   ,N'D'
			   ,N't'
			   ,N'T'
			   ,N','
			   ,N'.'
			   ,N'Ј'
			   ,N','
			   ,N'.'
			   ,N'g'
			   ,N'G'
			   ,N'C'
			   ,N'{0:p}'           
			   ,N'[0-9]+[,]?[0-9]*[\ ]*[\%]?'
			   ,N'0.000'
			   ,NEWID())
	END


IF not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sSystemButtons' and COLUMN_NAME = N'nb_NO')
BEGIN
	ALTER TABLE sSystemButtons ADD nb_NO nvarchar(30) NULL
END

IF not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sSystemStrings' and COLUMN_NAME = N'nb_NO')
BEGIN
	ALTER TABLE sSystemStrings ADD nb_NO nvarchar(4000) NULL
END
	
IF not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'sUserStrings' and COLUMN_NAME = N'nb_NO')
BEGIN
	ALTER TABLE sUserStrings ADD nb_NO nvarchar(4000) NULL
END
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08306', GetDate())
GO
