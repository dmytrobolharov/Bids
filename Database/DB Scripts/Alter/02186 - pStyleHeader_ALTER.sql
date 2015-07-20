Alter Table pStyleHeader add UserCID int
Go

Alter Table pStyleHeader add UserMID int
Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02186'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02186', GetDate())
	END
GO