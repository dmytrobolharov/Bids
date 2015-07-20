IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCategory' AND COLUMN_NAME = 'StyleCategoryFabricRequired')
BEGIN
	ALTER TABLE pStyleCategory ALTER COLUMN StyleCategoryFabricRequired INT
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05399', GetDate())
GO
