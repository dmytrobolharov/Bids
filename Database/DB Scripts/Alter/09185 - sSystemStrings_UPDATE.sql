UPDATE sSystemStrings SET en_GB = NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0001', '09185', GetDate())
GO
