IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
				WHERE TABLE_NAME='pImage' AND COLUMN_NAME='Unversioned')
BEGIN
	ALTER TABLE pImage ADD Unversioned INT DEFAULT 0
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08344', GetDate())
GO