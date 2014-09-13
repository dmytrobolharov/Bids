IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'uTradePartnerTemplateItem' AND COLUMN_NAME = 'PartnerAccessType')
BEGIN
	ALTER TABLE uTradePartnerTemplateItem ADD PartnerAccessType INT
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'uTradePartnerTemplateItemShare' AND COLUMN_NAME = 'PartnerAccessType')
BEGIN
	ALTER TABLE uTradePartnerTemplateItemShare ADD PartnerAccessType INT
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06588', GetDate())
GO
