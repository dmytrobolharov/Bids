DELETE FROM pColorType WHERE ColorTypeID = 0
GO

DELETE FROM pColorFolder WHERE ColorTypeID = 0
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01992'))
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
			,'01992'
			,GetDate()
		)
END	
GO