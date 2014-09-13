


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteVariationGroupSeasonal_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteVariationGroupSeasonal_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteVariationGroupSeasonal_SELECT]
(
@StyleDevelopmentID uniqueidentifier,
@StyleQuoteID uniqueidentifier,
@SeasonYearID uniqueidentifier,
@TradePartnerID uniqueidentifier
)
AS 

BEGIN
	SELECT DISTINCT 
	  pStyleDevelopmentItem.Variation, pStyleDevelopmentItem.StyleDevelopmentID, pStyleQuoteVariation.StyleQuoteID, pStyleQuoteVariation.StyleQuotaDutyID, 
	  pStyleQuoteVariation.StyleCostingID, pStyleQuoteVariation.StyleCostingType, pStyleQuoteVariation.StyleCostingFreightTypeID, 
	  pStyleQuoteVariation.StyleID, pStyleQuoteVariation.StyleQuoteVariationID
	FROM pStyleDevelopmentItem INNER JOIN
	  pStyleQuoteVariation ON pStyleDevelopmentItem.StyleID = pStyleQuoteVariation.StyleID INNER JOIN
	  pStyleSeasonYear ON pStyleQuoteVariation.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
	WHERE  (pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID)
				AND (pStyleSeasonYear.SeasonYearID = @SeasonYearID)
				AND (pStyleQuoteVariation.TradePartnerID = @TradePartnerID)
	ORDER BY pStyleDevelopmentItem.Variation
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '904', GetDate())
GO 

