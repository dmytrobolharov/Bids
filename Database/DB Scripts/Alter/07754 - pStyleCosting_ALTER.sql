/* ALTER TABLE pStyleCosting */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCosting' AND COLUMN_NAME = 'StyleCosting_EcomUnits')
BEGIN
	ALTER TABLE pStyleCosting ADD StyleCosting_EcomUnits INT
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCosting' AND COLUMN_NAME = 'StyleCosting_EcomPriceUnit')
BEGIN
	ALTER TABLE pStyleCosting ADD StyleCosting_EcomPriceUnit DECIMAL(18,4)
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCosting' AND COLUMN_NAME = 'StyleCosting_EcomExtended')
BEGIN
	ALTER TABLE pStyleCosting ADD StyleCosting_EcomExtended DECIMAL(18,4)
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCosting' AND COLUMN_NAME = 'StyleCosting_EcomMarginUnit')
BEGIN
	ALTER TABLE pStyleCosting ADD StyleCosting_EcomMarginUnit DECIMAL(18,4)
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCosting' AND COLUMN_NAME = 'StyleCosting_EcomMarginExtended')
BEGIN
	ALTER TABLE pStyleCosting ADD StyleCosting_EcomMarginExtended DECIMAL(18,4)
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCosting' AND COLUMN_NAME = 'StyleCosting_EcomMargin')
BEGIN
	ALTER TABLE pStyleCosting ADD StyleCosting_EcomMargin DECIMAL(18,4)
END


/* ALTER TABLE pStyleCostingScenarioItems */
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingScenarioItems' AND COLUMN_NAME = 'StyleCosting_EcomUnits')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ADD StyleCosting_EcomUnits INT
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingScenarioItems' AND COLUMN_NAME = 'StyleCosting_EcomPriceUnit')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ADD StyleCosting_EcomPriceUnit DECIMAL(18,4)
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingScenarioItems' AND COLUMN_NAME = 'StyleCosting_EcomExtended')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ADD StyleCosting_EcomExtended DECIMAL(18,4)
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingScenarioItems' AND COLUMN_NAME = 'StyleCosting_EcomMarginUnit')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ADD StyleCosting_EcomMarginUnit DECIMAL(18,4)
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingScenarioItems' AND COLUMN_NAME = 'StyleCosting_EcomMarginExtended')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ADD StyleCosting_EcomMarginExtended DECIMAL(18,4)
END
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleCostingScenarioItems' AND COLUMN_NAME = 'StyleCosting_EcomMargin')
BEGIN
	ALTER TABLE pStyleCostingScenarioItems ADD StyleCosting_EcomMargin DECIMAL(18,4)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07754', GetDate())
GO
