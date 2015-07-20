IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_CommitsStyle_WHERECount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_CommitsStyle_WHERECount_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_CommitsStyle_WHERECount_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @StyleID UNIQUEIDENTIFIER
)

AS

DECLARE @PartnerCount INT = 0
DECLARE @COOCount INT = 0

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

SET @PartnerCount = (
	SELECT COUNT(DISTINCT COALESCE(AgentID, VendorID, FactoryID))
	FROM
		pSourcingCommitmentItem
		INNER JOIN pSourcingTradePartner ON pSourcingCommitmentItem.StyleQuoteTradePartnerID = pSourcingTradePartner.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL ON pSourcingTradePartner.TradePartnerLevelID = vwx_TradePartnerRelationshipLevels_SEL.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON pSourcingCommitmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID = @SeasonYearID
		AND pSourcingCommitmentItem.StyleID = @StyleID)
		
SET @COOCount = (
	SELECT COUNT(DISTINCT uCountry.CountryCode)
	FROM
		pSourcingCommitmentItem
		INNER JOIN pSourcingTradePartner ON pSourcingCommitmentItem.StyleQuoteTradePartnerID = pSourcingTradePartner.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL ON pSourcingTradePartner.TradePartnerLevelID = vwx_TradePartnerRelationshipLevels_SEL.TradePartnerRelationshipLevelID
		INNER JOIN uTradePartner ON COALESCE(FactoryID, VendorID, AgentID) = uTradePartner.TradePartnerID
		INNER JOIN uCountry ON uTradePartner.Country = uCountry.CountryCode
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON pSourcingCommitmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID = @SeasonYearID
		AND pSourcingCommitmentItem.StyleID = @StyleID)

SELECT
	sh.StyleNo
	, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation	
	, sc.StyleCategory
	, sh.Description
	, ISNULL(COUNT (sci.SourcingCommitmentItemID),0) AS CommitsCount
	, ISNULL(@PartnerCount, 0) AS PartnerCount
	, ISNULL(@COOCount, 0) AS COOCount
FROM pStyleHeader sh
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
	LEFT OUTER JOIN pSourcingCommitmentItem sci ON sh.StyleID = sci.StyleID
WHERE sh.StyleID = @StyleID
GROUP BY
	sh.StyleNo
	, sdi.StyleDevelopmentName
	, sdi.Variation
	, sc.StyleCategory
	, sh.Description


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05236', GetDate())
GO
