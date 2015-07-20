IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerEquipment' AND COLUMN_NAME='IsLinked')
BEGIN
ALTER TABLE uTradePartnerEquipment
ADD IsLinked int NULL
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04013', GetDate())
GO