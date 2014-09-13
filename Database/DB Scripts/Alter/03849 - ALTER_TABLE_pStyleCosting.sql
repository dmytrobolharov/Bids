IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleNBOLHeaderID')
BEGIN 
	ALTER TABLE pStyleCosting 
	ADD StyleNBOLHeaderID uniqueidentifier NULL
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03849', GetDate())
GO
