ALTER TABLE pStyleQuoteVariation ADD BOMCost DECIMAL(18,3) NULL
ALTER TABLE pStyleQuoteVariation ADD BOLCost DECIMAL(18,3) NULL
ALTER TABLE pStyleQuoteVariation ADD BOLCurr NVARCHAR(5) NULL
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02275'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02275', GetDate())
END
GO