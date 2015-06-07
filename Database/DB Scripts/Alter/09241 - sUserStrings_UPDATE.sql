UPDATE sUserStrings SET en_GB = NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09241', GetDate())
GO
