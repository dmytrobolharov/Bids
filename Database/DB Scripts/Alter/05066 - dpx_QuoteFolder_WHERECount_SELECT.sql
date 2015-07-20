IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteFolder_WHERECount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteFolder_WHERECount_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuoteFolder_WHERECount_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
	, @SourcingHeaderID nvarchar(max) = NULL
)

AS

DECLARE @StyleCount INT = 0
DECLARE @StyleWithQuotesCount INT = 0
DECLARE @StyleWithoutQuotesCount INT = 0
DECLARE @StyleWithCommitsCount INT = 0
DECLARE @SampleCount INT = 0
DECLARE @TechPackCount INT = 0
DECLARE @HasBOMCount INT = 0

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

CREATE TABLE #tmpSoucingFolder (SourcingHeaderID UNIQUEIDENTIFIER)

IF @SourcingHeaderID IS NULL OR @SourcingHeaderID = ''
	INSERT INTO #tmpSoucingFolder SELECT SourcingHeaderID FROM pSourcingHeader
ELSE
	INSERT INTO #tmpSoucingFolder SELECT value FROM dbo.fnx_Split(@SourcingHeaderID, ',')

SET @StyleCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID = @SeasonYearID)

SET @StyleWithQuotesCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID= @SeasonYearID
		AND pStyleHeader.StyleID IN (SELECT pStyleQuoteItem.StyleID FROM pStyleQuoteItem INNER JOIN #tmpSoucingFolder ON pStyleQuoteItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID))

SET @StyleWithoutQuotesCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID= @SeasonYearID
		AND pStyleHeader.StyleID NOT IN (SELECT pStyleQuoteItem.StyleID FROM pStyleQuoteItem INNER JOIN #tmpSoucingFolder ON pStyleQuoteItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID))

SET @StyleWithCommitsCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID= @SeasonYearID
		AND pStyleHeader.StyleID IN (SELECT pSourcingCommitmentItem.StyleID FROM pSourcingCommitmentItem INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID))

SET @HasBOMCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID= @SeasonYearID
		AND pStyleHeader.StyleID IN (SELECT pStyleQuoteItem.StyleID FROM pStyleQuoteItem INNER JOIN #tmpSoucingFolder ON pStyleQuoteItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID WHERE pStyleQuoteItem.StyleQuoteItemID IN (SELECT pSourcingQuotationBOMOption.StyleQuoteItemID FROM pSourcingQuotationBOMOption)))

SET @SampleCount = (
	SELECT ISNULL(COUNT(*),0) AS COUNT
	FROM
		pStyleType
		INNER JOIN pStyleHeader ON pStyleType.StyleTypeID = pStyleHeader.StyleType
		INNER JOIN pSampleRequestWorkflow
			INNER JOIN pSampleRequestTrade ON pSampleRequestWorkflow.SampleRequestTradeID = pSampleRequestTrade.SampleRequestTradeID
			INNER JOIN pStyleSeasonYear ON pSampleRequestTrade.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		ON pStyleHeader.StyleID = pSampleRequestTrade.StyleID
	WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	GROUP BY pStyleSeasonYear.SeasonYearID)

SET @TechPackCount = (
	SELECT COUNT(*) AS COUNT
	FROM
		pTechPack
		INNER JOIN pStyleSeasonYear ON pTechPack.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
	WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
)

SELECT @StyleCount AS StyleCount, @StyleWithQuotesCount AS StyleWithQuotesCount, @StyleWithoutQuotesCount AS StyleWithoutQuotesCount, @StyleWithCommitsCount AS StyleWithCommitsCount, @SampleCount AS SampleCount, @TechPackCount AS TechPackCount, @HasBOMCount AS HasBOMCount

DROP TABLE #tmpSoucingFolder

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05066', GetDate())
GO
