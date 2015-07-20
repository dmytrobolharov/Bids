IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pColorType') AND name = N'ColorPaletteSchemaImageSearch')
BEGIN
ALTER TABLE dbo.pColorType ADD
	ColorPaletteSchemaImageSearch nvarchar(200) NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09332', GetDate())
GO
