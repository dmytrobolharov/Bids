ALTER TABLE pAMLMeasHdr ALTER COLUMN ProductType NVARCHAR(200) NULL
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06787', GetDate())
GO
