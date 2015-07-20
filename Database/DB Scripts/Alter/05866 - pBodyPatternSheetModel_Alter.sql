

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBodyPatternSheetModel'
    AND  COLUMN_NAME = 'Model_Name')
	
	ALTER TABLE dbo.pBodyPatternSheetModel ALTER COLUMN Model_Name nvarchar(100)  NULL 
GO 
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBodyPatternSheetModel'
    AND  COLUMN_NAME = 'Model_SampleSize')
	
	ALTER TABLE dbo.pBodyPatternSheetModel ALTER COLUMN Model_SampleSize nvarchar(60) NULL 
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05866', GetDate())
GO