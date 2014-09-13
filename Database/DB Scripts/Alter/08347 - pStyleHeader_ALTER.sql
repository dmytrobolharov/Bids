GO
IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleHeader' AND COLUMN_NAME = 'EnableProductPages')
BEGIN
	ALTER TABLE pStyleHeader ADD EnableProductPages int
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08347', GetDate())
GO
