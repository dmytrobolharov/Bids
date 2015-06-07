IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'ColorLibrary') AND name = N'ImageID')
ALTER TABLE dbo.ColorLibrary ADD ImageID UNIQUEIDENTIFIER NULL
	,ImageVersion INT NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09329', GetDate())
GO

