IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSizeClass' and COLUMN_NAME = N'CustomKey')
BEGIN 
	ALTER TABLE pSizeClass ALTER COLUMN CustomKey NVARCHAR(5) NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03450', GetDate())
GO