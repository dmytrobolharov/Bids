ALTER TABLE pStyleQuoteVariation 
ALTER COLUMN StyleCostingCustomField23 decimal(18, 5)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02469'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02469', GetDate())

END
GO