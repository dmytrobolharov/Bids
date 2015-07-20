IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleQuote' and COLUMN_NAME = N'StyleQuotaDutyID')
	BEGIN 
		ALTER TABLE pStyleQuote ADD StyleQuotaDutyID uniqueIdentifier NULL
	END
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01988'))
BEGIN
	INSERT INTO sVersion
		(
			AppName
			,[Version]
			,LastScriptRun
			,[TimeStamp]
		)
	VALUES     
		(
			'DB_Version'
			,'4.1.0000'
			,'01988'
			,GetDate()
		)
END	
GO


 