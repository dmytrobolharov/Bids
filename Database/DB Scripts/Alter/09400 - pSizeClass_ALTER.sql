ALTER TABLE pSizeClass ALTER COLUMN Custom NVARCHAR(400) NOT NULL;
ALTER TABLE pSizeClass ALTER COLUMN CustomKey NVARCHAR(200);
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09400', GetDate())
GO
