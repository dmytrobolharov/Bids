CREATE TABLE #tmpExchangeRates (
	Row_ID INT IDENTITY (1, 1),
	ExchangeRateID UNIQUEIDENTIFIER
)

INSERT INTO #tmpExchangeRates
SELECT DISTINCT ExchangeRateID FROM sExchangeRateItem

DECLARE @Rows INT = (SELECT COUNT (*) FROM #tmpExchangeRates)
DECLARE @Row INT = 1
DECLARE @ExchangeRateID UNIQUEIDENTIFIER

WHILE @Row <= @Rows
BEGIN	
	SELECT @ExchangeRateID = ExchangeRateID FROM #tmpExchangeRates WHERE Row_ID = @Row
	
	CREATE TABLE #tmpExchangeRateItemsDup (
		Row_ID INT IDENTITY (1, 1),
		ExchangeRateItemID UNIQUEIDENTIFIER,
		CurrencyType NVARCHAR (5),
		Number INT
	)
	
	INSERT INTO #tmpExchangeRateItemsDup
	SELECT ExchangeRateItemID, CurrencyType, ROW_NUMBER() OVER(PARTITION BY CurrencyType ORDER BY CurrencyType) Number 
	FROM sExchangeRateItem WHERE ExchangeRateID = @ExchangeRateID

	DELETE FROM sExchangeRateItem WHERE ExchangeRateItemID IN (
		SELECT ExchangeRateItemID FROM #tmpExchangeRateItemsDup WHERE Number > 1)
		
	DROP TABLE #tmpExchangeRateItemsDup
	
	SET @Row = @Row + 1	
END

DROP TABLE #tmpExchangeRates
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08252', GetDate())
GO
