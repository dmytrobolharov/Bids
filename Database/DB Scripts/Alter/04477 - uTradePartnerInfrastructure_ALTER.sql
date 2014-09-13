IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'TradePartnerInfrastructureTypeID')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [TradePartnerInfrastructureTypeID] [int] NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField9')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField9] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField10')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField10] [nvarchar](200) NULL
END
GO


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField11')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField11] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField12')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField12] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField13')
BEGIN 	
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField13] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField14')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField14] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField15')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField15] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField16')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField16] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField17')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField17] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField18')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField18] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField19')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField19] [nvarchar](200) NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'uTradePartnerInfrastructure' AND COLUMN_NAME = N'CustomField20')
BEGIN 
	ALTER TABLE uTradePartnerInfrastructure ADD [CustomField20] [nvarchar](200) NULL
END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04477', GetDate())
GO