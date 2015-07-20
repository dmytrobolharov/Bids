

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBodyMarker'
    AND  COLUMN_NAME = 'Marker_Name')
	
	ALTER TABLE dbo.pBodyMarker ALTER COLUMN Marker_Name nvarchar(100) NULL 
GO 
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pBodyMarker'
    AND  COLUMN_NAME = 'Sizes')
	
	ALTER TABLE dbo.pBodyMarker ALTER COLUMN Sizes nvarchar(max) NULL 
GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05859', GetDate())
GO