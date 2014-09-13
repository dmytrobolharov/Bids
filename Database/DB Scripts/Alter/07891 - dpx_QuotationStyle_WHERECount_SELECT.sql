IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuotationStyle_WHERECount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuotationStyle_WHERECount_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuotationStyle_WHERECount_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @StyleID UNIQUEIDENTIFIER
	, @SourcingHeaderID NVARCHAR(MAX)
)

AS

DECLARE @SampleCount INT = 0
DECLARE @SampleCountBOM INT = 0

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

SET @SampleCount = (
	SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
	FROM pStyleHeader
		INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID			
		INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
	WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND pStyleHeader.StyleID = @StyleID
)
SET @SampleCountBOM = (
	SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
	FROM pStyleHeader
		INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
		INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
	WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND pStyleHeader.StyleID = @StyleID
)

SELECT
	sh.StyleNo
	, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation	
	, sc.StyleCategory
	, sh.Description
	, ISNULL(COUNT (sqi.StyleQuoteItemID),0) AS QuoteCount
	, ISNULL(COUNT (sqiBOMo.StyleOptionID),0) AS BOMOptionCount
	, ISNULL(@SampleCount, 0) + ISNULL(@SampleCountBOM, 0) AS SampleCount
FROM pStyleHeader sh
	INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
	INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
	LEFT OUTER JOIN pStyleQuoteItem sqi ON sh.StyleID = sqi.StyleID
	LEFT OUTER JOIN pSourcingQuotationBOMOption sqiBOMo ON sqi.StyleQuoteItemID = sqiBOMo.StyleQuoteItemID
	LEFT OUTER JOIN pSourcingHeader soh ON sqi.SourcingHeaderID = soh.SourcingHeaderID
WHERE sh.StyleID = @StyleID AND soh.SourcingHeaderId = @SourcingHeaderID
GROUP BY
	sh.StyleNo
	, sdi.StyleDevelopmentName
	, sdi.Variation
	, sc.StyleCategory
	, sh.Description


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07891', GetDate())
GO
