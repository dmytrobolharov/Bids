ALTER TABLE pSampleRequestSpecSizeBOM ALTER COLUMN SizeRange NVARCHAR(200);
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09393', GetDate())
GO
