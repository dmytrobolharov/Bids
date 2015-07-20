ALTER TABLE sExchangeRateItem
ADD BaseCurrency int DEFAULT(0) WITH VALUES
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02116'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02116', GetDate())
	END
GO