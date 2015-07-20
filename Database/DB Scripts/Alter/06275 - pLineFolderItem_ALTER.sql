IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pLineFolderItem' AND COLUMN_NAME = 'StyleBOMDimensionID') 
BEGIN
	ALTER TABLE pLineFolderItem ADD StyleBOMDimensionID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06275', GetDate())
GO
