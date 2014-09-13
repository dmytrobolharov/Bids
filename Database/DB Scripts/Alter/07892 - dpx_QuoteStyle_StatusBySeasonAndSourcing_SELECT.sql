IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteStyle_StatusBySeasonAndSourcing_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteStyle_StatusBySeasonAndSourcing_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuoteStyle_StatusBySeasonAndSourcing_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
	, @SourcingHeaderID nvarchar(max) = NULL
	, @StyleID uniqueidentifier
)
AS

BEGIN

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	SELECT
		COUNT(DISTINCT sqi.StyleQuoteItemID) AS QuoteCount
		, sqis.Custom AS QuoteItemStatus
		, sqis.CustomKey AS QuoteItemStatusID
	FROM pStyleHeader sh
		INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
		INNER JOIN pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID
		INNER JOIN pStyleQuoteItem sqi ON sh.StyleID = sqi.StyleID
		INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sqi.StyleQuoteItemStatusId
		LEFT OUTER JOIN pSourcingHeader soh ON sqi.SourcingHeaderID = soh.SourcingHeaderID
	WHERE
		ssy.SeasonYearID = @SeasonYearID
		AND sh.StyleID = @StyleID
		AND soh.SourcingHeaderID = @SourcingHeaderID
	GROUP BY
		sqis.Custom
		, sqis.CustomKey
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07892', GetDate())
GO
