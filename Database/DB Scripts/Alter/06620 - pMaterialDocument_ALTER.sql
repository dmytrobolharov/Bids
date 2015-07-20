IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialDocument' AND COLUMN_NAME = '3D')
BEGIN
	ALTER TABLE pMaterialDocument ADD [3D] INT NOT NULL DEFAULT(0)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06620', GetDate())
GO