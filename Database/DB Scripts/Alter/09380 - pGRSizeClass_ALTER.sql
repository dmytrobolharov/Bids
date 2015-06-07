ALTER TABLE pGRSizeClass ALTER COLUMN SizeClass NVARCHAR(400) NOT NULL;
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09380', GetDate())
GO

