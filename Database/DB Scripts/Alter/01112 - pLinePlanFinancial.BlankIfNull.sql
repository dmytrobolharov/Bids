
IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pLinePlanFinancial' 
    AND  COLUMN_NAME = 'BlankIfNull')
	ALTER TABLE pLinePlanFinancial ADD  BlankIfNull INT 
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01112', GetDate())
GO
	
	
	