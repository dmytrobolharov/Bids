IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerEquipment' AND COLUMN_NAME='MachineName')
BEGIN
ALTER TABLE uTradePartnerEquipment
ADD MachineName nvarchar(200) NULL
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04010', GetDate())
GO