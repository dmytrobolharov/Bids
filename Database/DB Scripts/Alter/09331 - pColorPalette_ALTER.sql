IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'pcolorpalette') AND name = N'ImageID')
ALTER TABLE dbo.pcolorpalette ADD ImageID UNIQUEIDENTIFIER NULL
	,ImageVersion INT NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09331', GetDate())
GO

