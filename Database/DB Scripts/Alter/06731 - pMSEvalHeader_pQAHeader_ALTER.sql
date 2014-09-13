ALTER TABLE pMSEvalHeader
ALTER COLUMN ProductType nvarchar(500)
GO

ALTER TABLE pQAHeader
ALTER COLUMN ProductType nvarchar(500)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06731', GetDate())
GO
