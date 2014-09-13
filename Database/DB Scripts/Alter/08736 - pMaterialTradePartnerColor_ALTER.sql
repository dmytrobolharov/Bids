IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialTradePartnerColor' AND COLUMN_NAME = 'Status')
BEGIN
	ALTER TABLE pMaterialTradePartnerColor ADD Status int NOT NULL CONSTRAINT Status DEFAULT 40
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08736', GetDate())
GO