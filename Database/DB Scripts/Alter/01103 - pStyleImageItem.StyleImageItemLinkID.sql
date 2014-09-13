
IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleImageItem' 
    AND  COLUMN_NAME = 'StyleImageItemLinkID')
	ALTER TABLE pStyleImageItem ADD  StyleImageItemLinkID UNIQUEIDENTIFIER
GO
	
IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleImageItem' 
    AND  COLUMN_NAME = 'SessionItemTempID')
	ALTER TABLE pStyleImageItem ADD  SessionItemTempID UNIQUEIDENTIFIER
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01103', GetDate())
