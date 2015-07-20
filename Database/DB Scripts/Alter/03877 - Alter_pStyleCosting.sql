--OOTB New Costing
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingHeaderId')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingHeaderId uniqueidentifier NULL
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingName')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingName nvarchar(100) NULL
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCurrency')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCurrency nvarchar(20) NULL
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingConvertedCurr')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingConvertedCurr decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingHTS')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingHTS nvarchar(50) NULL
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'AdditionalCost')
BEGIN 	
	ALTER TABLE pStyleCosting add AdditionalCost decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingComments')
BEGIN 	
	ALTER TABLE pStyleCosting add  StyleCostingComments nvarchar(500) NULL
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingScenarioItemsId')
BEGIN	
	ALTER TABLE pStyleCosting add  StyleCostingScenarioItemsId uniqueidentifier NULL
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingScenarioNo')
BEGIN	
	ALTER TABLE pStyleCosting add  StyleCostingScenarioNo int NULL
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField36')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField36 decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField37')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField37 decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField38')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField38 decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField39')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField39 decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField40')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField40 decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField41')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField41 decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField42')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField42 decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField43')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField43 decimal(18,3) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField44')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField44 decimal(18,5) null
END
IF  Not EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleCostingCustomField45')
BEGIN 	
	ALTER TABLE pStyleCosting add StyleCostingCustomField45 decimal(18,3) null
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03877', GetDate())
GO
