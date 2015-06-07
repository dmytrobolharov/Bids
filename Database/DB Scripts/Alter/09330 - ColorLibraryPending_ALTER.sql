IF NOT EXISTS(SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'ColorLibraryPending') AND name = N'ImageID')
ALTER TABLE dbo.ColorLibraryPending ADD
	ImageID uniqueidentifier NULL,
	ImageVersion int NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09330', GetDate())
GO
