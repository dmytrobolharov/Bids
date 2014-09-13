IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSourcingQuotationBOMOption' AND COLUMN_NAME = 'OptionName')
BEGIN
	ALTER TABLE pSourcingQuotationBOMOption ADD OptionName NVARCHAR(100) NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04428', GetDate())
GO