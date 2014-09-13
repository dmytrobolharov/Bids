IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSourcingQuotationBOMMaterials' AND COLUMN_NAME = 'Comments')
BEGIN
	ALTER TABLE pSourcingQuotationBOMMaterials ADD Comments NVARCHAR(400) NULL
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04430', GetDate())
GO