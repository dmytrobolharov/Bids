IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSourcingQuotationBOMOption' and COLUMN_NAME = N'XFactoryDate')
BEGIN 
	ALTER TABLE pSourcingQuotationBOMOption ADD XFactoryDate datetime NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSourcingQuotationBOMOption' and COLUMN_NAME = N'OptionQuantity')
BEGIN 
	ALTER TABLE pSourcingQuotationBOMOption ADD OptionQuantity decimal(18, 4) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pSourcingQuotationBOMOption' and COLUMN_NAME = N'OptionCost')
BEGIN 
	ALTER TABLE pSourcingQuotationBOMOption ADD OptionCost decimal(18, 4) NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04453', GetDate())
GO