IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ExchangeRateItemsBySeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ExchangeRateItemsBySeasonYear_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_ExchangeRateItemsBySeasonYear_SELECT]
	@SeasonYearID uniqueidentifier
AS
BEGIN

SELECT ExchangeRateItemID, CurrencyType, Rate, 
	(CurrencyType + ' (' + CAST(Rate AS NVARCHAR(20)) + ')') as CurrencyRate, 0 as Sort 
FROM sExchangeRateItem
	INNER JOIN sExchangeRate ON sExchangeRateItem.ExchangeRateID = sExchangeRate.ExchangeRateID
WHERE sExchangeRate.Season = (SELECT Season FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID)
AND sExchangeRate.Year = (SELECT Year FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID)
AND sExchangeRateItem.BaseCurrency = 1
UNION
SELECT ExchangeRateItemID, CurrencyType, Rate, 
	(CurrencyType + ' (' + CAST(Rate AS NVARCHAR(20)) + ')') as CurrencyRate, 1 as Sort 
FROM sExchangeRateItem
	INNER JOIN sExchangeRate ON sExchangeRateItem.ExchangeRateID = sExchangeRate.ExchangeRateID
WHERE sExchangeRate.Season = (SELECT Season FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID)
AND sExchangeRate.Year = (SELECT Year FROM pSeasonYear WHERE SeasonYearID = @SeasonYearID)
AND sExchangeRateItem.BaseCurrency = 0 
ORDER BY Sort, sExchangeRateItem.CurrencyType

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04556', GetDate())
GO
