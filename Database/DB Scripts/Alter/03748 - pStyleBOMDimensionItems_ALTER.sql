IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pStyleBOMDimensionItems' AND COLUMN_NAME = 'SKUcost')
BEGIN
	ALTER TABLE pStyleBOMDimensionItems ADD SKUcost decimal(19,3) 
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03748', GetDate())
GO
