DECLARE @ColumnType NVARCHAR(100)

SELECT @ColumnType = data_type
FROM information_schema.columns
WHERE table_name = 'pStyleCosting'
AND COLUMN_NAME = 'StyleCostingCurrency'

IF LOWER(@ColumnType) <> 'uniqueidentifier'
BEGIN
	IF EXISTS(SELECT StyleCostingCurrency FROM pStyleCosting WHERE StyleCostingCurrency IS NOT NULL)
	BEGIN
		UPDATE pStyleCosting SET StyleCostingCurrency = NULL
	END
	ALTER TABLE pStyleCosting ALTER COLUMN StyleCostingCurrency UNIQUEIDENTIFIER
END

SELECT @ColumnType = data_type
FROM information_schema.columns
WHERE table_name = 'pStyleCostingScenarioItems'
AND COLUMN_NAME = 'StyleCostingCurrency'

IF LOWER(@ColumnType) <> 'uniqueidentifier'
BEGIN
	IF EXISTS(SELECT StyleCostingCurrency FROM pStyleCostingScenarioItems WHERE StyleCostingCurrency IS NOT NULL)
	BEGIN
		UPDATE pStyleCostingScenarioItems SET StyleCostingCurrency = NULL
	END
	ALTER TABLE pStyleCostingScenarioItems ALTER COLUMN StyleCostingCurrency UNIQUEIDENTIFIER
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04032', GetDate())
GO 