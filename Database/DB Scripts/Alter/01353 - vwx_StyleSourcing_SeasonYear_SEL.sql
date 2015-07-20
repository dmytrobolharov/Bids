
IF EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_StyleSourcing_SeasonYear_SEL]'))
DROP VIEW [dbo].[vwx_StyleSourcing_SeasonYear_SEL]
GO
/****** Object:  View [dbo].[vwx_StyleSourcing_SeasonYear_SEL]    Script Date: 04/05/2011 15:15:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


Create VIEW [dbo].[vwx_StyleSourcing_SeasonYear_SEL]
AS
SELECT a.StyleSourcingID, a.StyleID, a.SourcingName, a.CDate, a.CUser, a.MDate, a.MUser, a.Custom1, 
	a.Custom2, a.Active, 
	a.TradePartnerID, a.TradePartnerVendorID, a.StyleSeasonYearID, b.SeasonYearID, b.StyleSeason + ' - ' + b.StyleYear AS SeasonYear, 
    CASE 
		WHEN a.TradePartnerVendorID = b.TradePartnerVendorID THEN 1 
		ELSE 0 END 
	AS MostLikelyVendor
FROM dbo.pStyleSourcing a WITH(NOLOCK)
	INNER JOIN dbo.pStyleSeasonYear b ON a.StyleSeasonYearID = b.StyleSeasonYearID		
	--LEFT OUTER JOIN sExchangeRate c ON CAST(c.ExchangeRateID AS NVARCHAR(40)) = a.Custom2

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01353', GetDate())

GO