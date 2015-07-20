ALTER TABLE pStyleQuoteItem 
ALTER COLUMN StyleCostingCustomField23 decimal(18, 5)
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02470'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02470', GetDate())

END
GO