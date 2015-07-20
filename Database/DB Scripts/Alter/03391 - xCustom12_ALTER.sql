ALTER TABLE xCustom12 ALTER COLUMN Custom NVARCHAR(200) NOT NULL;
GO

ALTER TABLE xCustom12 ALTER COLUMN CustomKey NVARCHAR(10) NULL;
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03391', GetDate())
GO