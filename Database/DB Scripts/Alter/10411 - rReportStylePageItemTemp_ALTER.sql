IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'rReportStylePageItemTemp') AND name = N'MapID')
ALTER TABLE dbo.rReportStylePageItemTemp ADD MapID UNIQUEIDENTIFIER NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10411', GetDate())
GO

