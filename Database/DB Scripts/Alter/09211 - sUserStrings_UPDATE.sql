UPDATE sUserStrings SET en_GB = NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09211', GetDate())
GO
