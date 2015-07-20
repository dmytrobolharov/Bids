IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_CommitsToDoStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_CommitsToDoStyle_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_CommitsToDoStyle_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @CommitsStatusID INT = NULL
	, @SourcingHeaderID NVARCHAR(MAX)
)
AS
BEGIN

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

	IF @CommitsStatusID IS NULL
		SELECT
			sh.StyleNo
			, sh.Description
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(DISTINCT sci.SourcingCommitmentItemID)>0 THEN COUNT(DISTINCT sci.SourcingCommitmentItemID) END) AS StyleCommitsCount
			, (CASE WHEN COUNT(DISTINCT scia.SourcingCommitmentItemID)>0 THEN COUNT(DISTINCT scia.SourcingCommitmentItemID) END) AS StyleCommitedCount
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			LEFT OUTER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sfq ON sqi.SourcingHeaderID = sfq.SourcingHeaderID ON sh.StyleID = sqi.StyleID
			LEFT OUTER JOIN pSourcingCommitmentItem sci INNER JOIN #tmpSoucingFolder sf ON sci.SourcingHeaderID = sf.SourcingHeaderID ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN pSourcingCommitmentItem scia INNER JOIN #tmpSoucingFolder sfa ON scia.SourcingHeaderID = sfa.SourcingHeaderID ON sh.StyleID = scia.StyleID AND scia.StyleQuoteItemStatusId = 3
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
			AND sh.StyleID IN (SELECT StyleID FROM #tmpStyleID)
		GROUP BY
			sh.StyleNo
			, sh.Description
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID
		ORDER BY DaysLate DESC
			
	-- With Commits
	IF @CommitsStatusID = 100
		SELECT
			sh.StyleNo
			, sh.Description
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(DISTINCT sci.SourcingCommitmentItemID)>0 THEN COUNT(DISTINCT sci.SourcingCommitmentItemID) END) AS StyleCommitsCount
			, (CASE WHEN COUNT(DISTINCT scia.SourcingCommitmentItemID)>0 THEN COUNT(DISTINCT scia.SourcingCommitmentItemID) END) AS StyleCommitedCount
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			LEFT OUTER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sfq ON sqi.SourcingHeaderID = sfq.SourcingHeaderID ON sh.StyleID = sqi.StyleID
			INNER JOIN pSourcingCommitmentItem sci INNER JOIN #tmpSoucingFolder sf ON sci.SourcingHeaderID = sf.SourcingHeaderID ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN pSourcingCommitmentItem scia INNER JOIN #tmpSoucingFolder sfa ON scia.SourcingHeaderID = sfa.SourcingHeaderID ON sh.StyleID = scia.StyleID AND scia.StyleQuoteItemStatusId = 3
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
		GROUP BY
			sh.StyleNo
			, sh.Description
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID
		ORDER BY DaysLate DESC

	--Without Commits
	IF @CommitsStatusID = 42
		SELECT
			sh.StyleNo
			, sh.Description
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(DISTINCT sci.SourcingCommitmentItemID)>0 THEN COUNT(DISTINCT sci.SourcingCommitmentItemID) END) AS StyleCommitsCount
			, (CASE WHEN COUNT(DISTINCT scia.SourcingCommitmentItemID)>0 THEN COUNT(DISTINCT scia.SourcingCommitmentItemID) END) AS StyleCommitedCount
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			LEFT OUTER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sfq ON sqi.SourcingHeaderID = sfq.SourcingHeaderID ON sh.StyleID = sqi.StyleID
			LEFT OUTER JOIN pSourcingCommitmentItem sci INNER JOIN #tmpSoucingFolder sf ON sci.SourcingHeaderID = sf.SourcingHeaderID ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN pSourcingCommitmentItem scia INNER JOIN #tmpSoucingFolder sfa ON scia.SourcingHeaderID = sfa.SourcingHeaderID ON sh.StyleID = scia.StyleID AND scia.StyleQuoteItemStatusId = 3
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
			AND sh.StyleID IN (SELECT StyleID FROM #tmpStyleID)
		GROUP BY
			sh.StyleNo
			, sh.Description
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID
		HAVING
			COUNT(DISTINCT sqi.StyleQuoteItemID)=0		
		ORDER BY DaysLate DESC

	IF @CommitsStatusID IN (SELECT CustomKey FROM pStyleQuoteItemStatus)
		SELECT
			sh.StyleNo
			, sh.Description
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(DISTINCT sci.SourcingCommitmentItemID)>0 THEN COUNT(DISTINCT sci.SourcingCommitmentItemID) END) AS StyleCommitsCount
			, (CASE WHEN COUNT(DISTINCT scia.SourcingCommitmentItemID)>0 THEN COUNT(DISTINCT scia.SourcingCommitmentItemID) END) AS StyleCommitedCount
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			LEFT OUTER JOIN pStyleQuoteItem sqi INNER JOIN #tmpSoucingFolder sfq ON sqi.SourcingHeaderID = sfq.SourcingHeaderID ON sh.StyleID = sqi.StyleID
			INNER JOIN pSourcingCommitmentItem sci INNER JOIN #tmpSoucingFolder sf ON sci.SourcingHeaderID = sf.SourcingHeaderID ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN pSourcingCommitmentItem scia INNER JOIN #tmpSoucingFolder sfa ON scia.SourcingHeaderID = sfa.SourcingHeaderID ON sh.StyleID = scia.StyleID AND scia.StyleQuoteItemStatusId = 3
			INNER JOIN pStyleQuoteItemStatus sqis ON sci.StyleQuoteItemStatusId = sqis.CustomKey
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID AND sci.StyleQuoteItemStatusId = @CommitsStatusID
		GROUP BY
			sh.StyleNo
			, sh.Description
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID
		ORDER BY DaysLate DESC
END




GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05560', GetDate())
GO
