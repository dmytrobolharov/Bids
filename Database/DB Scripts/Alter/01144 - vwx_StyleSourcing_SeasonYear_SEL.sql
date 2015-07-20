IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSourcing_SeasonYear_SEL]') AND type = N'V' )
	DROP VIEW  [dbo].[vwx_StyleSourcing_SeasonYear_SEL]
GO

CREATE VIEW [dbo].[vwx_StyleSourcing_SeasonYear_SEL]
AS
SELECT a.StyleSourcingID, a.StyleID, a.SourcingName, a.CDate, a.CUser, a.MDate, a.MUser, a.Custom1, 
	c.Description AS Custom2, a.Active, 
	a.TradePartnerID, a.TradePartnerVendorID, a.StyleSeasonYearID, b.SeasonYearID, b.StyleSeason + ' - ' + b.StyleYear AS SeasonYear, 
    CASE 
		WHEN a.TradePartnerVendorID = b.TradePartnerVendorID THEN 1 
		ELSE 0 END 
	AS MostLikelyVendor
FROM dbo.pStyleSourcing a WITH(NOLOCK)
	INNER JOIN dbo.pStyleSeasonYear b ON a.StyleSeasonYearID = b.StyleSeasonYearID
	LEFT OUTER JOIN sExchangeRate c ON CAST(c.ExchangeRateID AS NVARCHAR(40)) = a.Custom2
	


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01144', GetDate())
GO

