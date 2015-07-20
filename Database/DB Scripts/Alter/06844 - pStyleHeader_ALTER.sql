IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleHeader' AND COLUMN_NAME = 'SubCategory')
BEGIN
	ALTER TABLE pStyleHeader ADD SubCategoryId NVARCHAR(50)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06844', GetDate())
GO
