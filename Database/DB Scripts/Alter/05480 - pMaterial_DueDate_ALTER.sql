IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pMaterial' AND COLUMN_NAME='DueDate')
BEGIN
	ALTER TABLE pMaterial ADD DueDate DATETIME
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05480', GetDate())
GO

