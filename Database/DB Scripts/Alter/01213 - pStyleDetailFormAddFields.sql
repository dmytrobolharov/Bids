	
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailForm'
    AND  COLUMN_NAME = 'StyleDetailFormLinkID')
	ALTER TABLE pStyleDetailForm ADD  StyleDetailFormLinkID UNIQUEIDENTIFIER
GO
	
IF NOT EXISTS( SELECT * FROM INFORMATION_SCHEMA.COLUMNS 
	WHERE TABLE_NAME = 'pStyleDetailForm'
    AND  COLUMN_NAME = 'SessionItemTempID')
	ALTER TABLE pStyleDetailForm ADD  SessionItemTempID UNIQUEIDENTIFIER
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01213', GetDate())

GO