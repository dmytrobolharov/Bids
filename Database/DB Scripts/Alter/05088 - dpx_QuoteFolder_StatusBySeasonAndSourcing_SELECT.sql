IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteFolder_StatusBySeasonAndSourcing_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteFolder_StatusBySeasonAndSourcing_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuoteFolder_StatusBySeasonAndSourcing_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
	, @SourcingHeaderID nvarchar(max) = NULL
)
AS

BEGIN

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	CREATE TABLE #tmpSoucingFolder (SourcingHeaderID UNIQUEIDENTIFIER)

	IF @SourcingHeaderID IS NULL OR @SourcingHeaderID = ''
		INSERT INTO #tmpSoucingFolder SELECT SourcingHeaderID FROM pSourcingHeader
	ELSE
		INSERT INTO #tmpSoucingFolder SELECT value FROM dbo.fnx_Split(@SourcingHeaderID, ',')
	
	SELECT * FROM (
		SELECT
			COUNT(DISTINCT pStyleHeader.StyleID) AS QuoteCount
			, dbo.pStyleQuoteItemStatus.Custom AS QuoteItemStatus
			, dbo.pStyleQuoteItemStatus.CustomKey AS QuoteItemStatusID
		FROM
			dbo.pStyleHeader
			INNER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
			INNER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
			INNER JOIN dbo.pStyleQuoteItem INNER JOIN #tmpSoucingFolder ON pStyleQuoteItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID ON dbo.pStyleHeader.StyleID = dbo.pStyleQuoteItem.StyleID
			INNER JOIN dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItemStatus.CustomKey = dbo.pStyleQuoteItem.StyleQuoteItemStatusId
		WHERE
			pStyleSeasonYear.SeasonYearID = @SeasonYearID
			AND pStyleQuoteItemStatus.CustomKey <> 3
		GROUP BY
			dbo.pStyleQuoteItemStatus.Custom
			, dbo.pStyleQuoteItemStatus.CustomKey
		
		UNION
		
		SELECT
			COUNT(*) AS QuoteCount
			, 'Committed' AS QuoteItemStatus
			, -1 AS QuoteItemStatusID
		FROM
			dbo.pStyleHeader
			LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
		WHERE
			pStyleSeasonYear.SeasonYearID= @SeasonYearID
			AND pStyleHeader.StyleID IN (SELECT pSourcingCommitmentItem.StyleID FROM pSourcingCommitmentItem INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID)
			
		UNION			
		
		SELECT
			COUNT(*) AS QuoteCount
			, 'No Quotes' AS QuoteItemStatus
			, 42 AS QuoteItemStatusID
		FROM
			dbo.pStyleHeader
			LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
		WHERE
			pStyleSeasonYear.SeasonYearID= @SeasonYearID
			AND pStyleHeader.StyleID NOT IN (SELECT pStyleQuoteItem.StyleID FROM pStyleQuoteItem INNER JOIN #tmpSoucingFolder ON pStyleQuoteItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID)
					
	) AS qCount WHERE qcount.QuoteCount>0 ORDER BY qCount.QuoteItemStatusID
	
	DROP TABLE #tmpSoucingFolder

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05088', GetDate())
GO
