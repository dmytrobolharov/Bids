ALTER TABLE UOM ALTER COLUMN UOMValue NVARCHAR(50)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06794', GetDate())
GO
