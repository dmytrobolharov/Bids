IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_CommitsStyle_StatusBySeasonAndSourcing_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_CommitsStyle_StatusBySeasonAndSourcing_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_CommitsStyle_StatusBySeasonAndSourcing_SELECT]
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
		COUNT(DISTINCT sci.StyleQuoteItemID) AS QuoteCount
		, sqis.Custom AS QuoteItemStatus
		, sqis.CustomKey AS QuoteItemStatusID
	FROM pStyleHeader sh
		INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
		INNER JOIN pSeasonYear sy ON sy.SeasonYearID = ssy.SeasonYearID
		INNER JOIN pSourcingCommitmentItem sci ON sh.StyleID = sci.StyleID
		INNER JOIN pStyleQuoteItemStatus sqis ON sqis.CustomKey = sci.StyleQuoteItemStatusId
	WHERE
		ssy.SeasonYearID = @SeasonYearID
		AND sh.StyleID = @StyleID
	GROUP BY
		sqis.Custom
		, sqis.CustomKey

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05235', GetDate())
GO
