IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pLineFolderFinancial' AND COLUMN_NAME='RangePlan')
BEGIN
	ALTER TABLE pLineFolderFinancial ADD RangePlan INT DEFAULT(0)
END

GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pLineFolderFinancial' AND COLUMN_NAME='AllowPercentInput')
BEGIN
	ALTER TABLE pLineFolderFinancial ADD AllowPercentInput INT DEFAULT(0)
END

GO

UPDATE pLineFolderFinancial SET RangePlan = 0 WHERE RangePlan IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05748', GetDate())
GO
