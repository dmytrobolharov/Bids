IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteFolder_WHERECount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteFolder_WHERECount_SELECT]
GO


CREATE PROCEDURE [dbo].[dpx_QuoteFolder_WHERECount_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
	, @SourcingHeaderID nvarchar(max)
	, @QuoteStatusID INT = NULL
)

AS

DECLARE @StyleCount INT = 0
DECLARE @StyleWithQuotesCount INT = 0
DECLARE @StyleWithoutQuotesCount INT = 0
DECLARE @StyleWithCommitsCount INT = 0
DECLARE @SampleCount INT = 0
DECLARE @SampleCountBOM INT = 0
DECLARE @TechPackCount INT = 0
DECLARE @HasBOMCount INT = 0

IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

CREATE TABLE #tmpSoucingFolder (SourcingHeaderID UNIQUEIDENTIFIER)
CREATE TABLE #tmpStyleID (StyleID UNIQUEIDENTIFIER)

IF EXISTS(SELECT value FROM dbo.fnx_Split(@SourcingHeaderID, ',') WHERE value = '00000000-0000-0000-0000-000000000000')
	BEGIN
		INSERT INTO #tmpStyleID SELECT StyleID FROM pStyleHeader
		INSERT INTO #tmpSoucingFolder SELECT SourcingHeaderID FROM pSourcingHeader
	END
ELSE
	BEGIN
		INSERT INTO #tmpSoucingFolder SELECT value FROM dbo.fnx_Split(@SourcingHeaderID, ',')
		INSERT INTO #tmpStyleID SELECT DISTINCT StyleID FROM pSourcingStyle INNER JOIN #tmpSoucingFolder ON pSourcingStyle.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID
	END

SET @StyleCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID = @SeasonYearID
		AND pStyleHeader.StyleID IN (SELECT StyleID FROM #tmpStyleID))

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
		INNER JOIN #tmpStyleID ON dbo.pStyleHeader.StyleID = #tmpStyleID.StyleID
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

IF @QuoteStatusID IS NULL
BEGIN
	SET @SampleCount = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID			
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	)
	SET @SampleCountBOM = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	)

	SET @TechPackCount = (
		SELECT COUNT(*) AS COUNT
		FROM pTechPack
			INNER JOIN pStyleSeasonYear ON pTechPack.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
		)
END

-- With Quotes
IF @QuoteStatusID = 100
BEGIN
	SET @SampleCount = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID			
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	)
	SET @SampleCountBOM = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	)

	SET @TechPackCount = (
		SELECT COUNT(DISTINCT pTechPack.TechPackID) AS COUNT
		FROM pTechPack
			INNER JOIN pStyleSeasonYear ON pTechPack.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pTechPack.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
		)
END
-- Has BOM Options
IF @QuoteStatusID = 200
BEGIN
	SET @SampleCount = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID			
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sqi.StyleID
			INNER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID			
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	)
	SET @SampleCountBOM = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sqi.StyleID
			INNER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID						
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	)

	SET @TechPackCount = (
		SELECT COUNT(DISTINCT pTechPack.TechPackID) AS COUNT
		FROM pTechPack
			INNER JOIN pStyleSeasonYear ON pTechPack.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pTechPack.StyleID = sqi.StyleID
			INNER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
		)
END
--Without Quotes
IF @QuoteStatusID = 42
BEGIN
	SET @SampleCount = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID			
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
		HAVING COUNT(DISTINCT sqi.StyleQuoteItemID)=0
	)
	SET @SampleCountBOM = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
		HAVING COUNT(DISTINCT sqi.StyleQuoteItemID)=0
	)

	SET @TechPackCount = (
		SELECT COUNT(DISTINCT pTechPack.TechPackID) AS COUNT
		FROM pTechPack
			INNER JOIN pStyleSeasonYear ON pTechPack.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pTechPack.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
		HAVING COUNT(DISTINCT sqi.StyleQuoteItemID)=0
		)
END
--With Commits
IF @QuoteStatusID = -1
BEGIN
	SET @SampleCount = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID			
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pSourcingCommitmentItem sci INNER JOIN #tmpSoucingFolder sf ON sci.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sci.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	)
	SET @SampleCountBOM = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pSourcingCommitmentItem sci INNER JOIN #tmpSoucingFolder sf ON sci.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sci.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
	)

	SET @TechPackCount = (
		SELECT COUNT(DISTINCT pTechPack.TechPackID) AS COUNT
		FROM pTechPack
			INNER JOIN pStyleSeasonYear ON pTechPack.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pSourcingCommitmentItem sci INNER JOIN #tmpSoucingFolder sf ON sci.SourcingHeaderID = sf.SourcingHeaderID ON pTechPack.StyleID = sci.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
		)
END		
IF @QuoteStatusID IN (SELECT CustomKey FROM pStyleQuoteItemStatus)
BEGIN
	SET @SampleCount = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID			
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND sqi.StyleQuoteItemStatusId = @QuoteStatusID
	)
	SET @SampleCountBOM = (
		SELECT COUNT(DISTINCT srt.SampleRequestTradeID)
		FROM pStyleHeader
			INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
			INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pStyleHeader.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND sqi.StyleQuoteItemStatusId = @QuoteStatusID
	)

	SET @TechPackCount = (
		SELECT COUNT(DISTINCT pTechPack.TechPackID) AS COUNT
		FROM pTechPack
			INNER JOIN pStyleSeasonYear ON pTechPack.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
			INNER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sf ON sqi.SourcingHeaderID = sf.SourcingHeaderID ON pTechPack.StyleID = sqi.StyleID
		WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID AND sqi.StyleQuoteItemStatusId = @QuoteStatusID
		)
END

SELECT @StyleCount AS StyleCount, @StyleWithQuotesCount AS StyleWithQuotesCount, @StyleWithoutQuotesCount AS StyleWithoutQuotesCount, @StyleWithCommitsCount AS StyleWithCommitsCount, ISNULL(@SampleCount, 0)+ISNULL(@SampleCountBOM, 0) AS SampleCount, ISNULL(@TechPackCount, 0) AS TechPackCount, @HasBOMCount AS HasBOMCount

DROP TABLE #tmpSoucingFolder
DROP TABLE #tmpStyleID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05405', GetDate())
GO
