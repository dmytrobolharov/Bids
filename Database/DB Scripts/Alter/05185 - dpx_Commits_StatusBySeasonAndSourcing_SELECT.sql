IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Commits_StatusBySeasonAndSourcing_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Commits_StatusBySeasonAndSourcing_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Commits_StatusBySeasonAndSourcing_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @SourcingHeaderID NVARCHAR(MAX)
)
AS

BEGIN

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	CREATE TABLE #tmpSoucingFolder (SourcingHeaderID UNIQUEIDENTIFIER)
	IF EXISTS(SELECT value FROM dbo.fnx_Split(@SourcingHeaderID, ',') WHERE value = '00000000-0000-0000-0000-000000000000')
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
			INNER JOIN dbo.pSourcingCommitmentItem INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID ON dbo.pStyleHeader.StyleID = dbo.pSourcingCommitmentItem.StyleID
			INNER JOIN dbo.pStyleQuoteItemStatus ON dbo.pStyleQuoteItemStatus.CustomKey = dbo.pSourcingCommitmentItem.StyleQuoteItemStatusId
		WHERE
			pStyleSeasonYear.SeasonYearID = @SeasonYearID
		GROUP BY
			dbo.pStyleQuoteItemStatus.Custom
			, dbo.pStyleQuoteItemStatus.CustomKey
		
		UNION			
		
		SELECT
			COUNT(*) AS QuoteCount
			, 'No Commitments' AS QuoteItemStatus
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
VALUES ('DB_Version', '5.0.0000', '05185', GetDate())
GO
