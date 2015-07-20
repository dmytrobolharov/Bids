ALTER TABLE pQASampLbl ALTER COLUMN ColLabel NVARCHAR(200);

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10015', GetUTCDate())
GO
