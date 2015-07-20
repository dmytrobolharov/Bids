IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerEquipment' AND COLUMN_NAME='MachineClassName')
BEGIN
ALTER TABLE uTradePartnerEquipment
ADD MachineClassName nvarchar(200) NULL
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerEquipment' AND COLUMN_NAME='MachineTypeName')
BEGIN
ALTER TABLE uTradePartnerEquipment
ADD MachineTypeName nvarchar(200) NULL
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04016', GetDate())
GO