ALTER TABLE pStyleQuoteItem ADD BOMCost DECIMAL(18,3) NULL
ALTER TABLE pStyleQuoteItem ADD BOLCost DECIMAL(18,3) NULL
ALTER TABLE pStyleQuoteItem ADD BOLCurr NVARCHAR(5) NULL
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02277'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02277', GetDate())
END
GO