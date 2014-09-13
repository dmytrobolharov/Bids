IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Commits_Count_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Commits_Count_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Commits_Count_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER = NULL
	, @SourcingHeaderID NVARCHAR(MAX)
	, @CommitsStatusID INT = NULL
)

AS

DECLARE @StyleCount INT = 0
DECLARE @StyleWithCommitsCount INT = 0
DECLARE @StyleWithoutCommitsCount INT = 0
DECLARE @StyleWithCommittedCount INT = 0
DECLARE @CommitsCount INT = 0
DECLARE @PartnerCount INT = 0
DECLARE @COOCount INT = 0

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

SET @StyleWithCommitsCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID= @SeasonYearID
		AND pStyleHeader.StyleID IN (SELECT pSourcingCommitmentItem.StyleID FROM pSourcingCommitmentItem INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID))
SET @StyleWithoutCommitsCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID= @SeasonYearID
		AND pStyleHeader.StyleID NOT IN (SELECT pSourcingCommitmentItem.StyleID FROM pSourcingCommitmentItem INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID))
SET @CommitsCount = (
	SELECT COUNT(DISTINCT SourcingCommitmentItemID)
	FROM
		pSourcingCommitmentItem
		INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON pSourcingCommitmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID = @SeasonYearID)
SET @PartnerCount = (
	SELECT COUNT(DISTINCT COALESCE(AgentID, VendorID, FactoryID))
	FROM
		pSourcingCommitmentItem
		INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID
		INNER JOIN pSourcingTradePartner ON pSourcingCommitmentItem.StyleQuoteTradePartnerID = pSourcingTradePartner.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL ON pSourcingTradePartner.TradePartnerLevelID = vwx_TradePartnerRelationshipLevels_SEL.TradePartnerRelationshipLevelID
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON pSourcingCommitmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID = @SeasonYearID)
SET @COOCount = (
	SELECT COUNT(DISTINCT uCountry.CountryCode)
	FROM
		pSourcingCommitmentItem
		INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID
		INNER JOIN pSourcingTradePartner ON pSourcingCommitmentItem.StyleQuoteTradePartnerID = pSourcingTradePartner.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL ON pSourcingTradePartner.TradePartnerLevelID = vwx_TradePartnerRelationshipLevels_SEL.TradePartnerRelationshipLevelID
		INNER JOIN uTradePartner ON COALESCE(FactoryID, VendorID, AgentID) = uTradePartner.TradePartnerID
		INNER JOIN uCountry ON uTradePartner.Country = uCountry.CountryCode
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON pSourcingCommitmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID = @SeasonYearID)
SET @StyleWithCommittedCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID= @SeasonYearID
		AND pStyleHeader.StyleID IN (SELECT pSourcingCommitmentItem.StyleID
									 FROM
										pSourcingCommitmentItem
										INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID
									 WHERE pSourcingCommitmentItem.StyleQuoteItemStatusId = 3))

IF @CommitsStatusID = 100 SET @StyleWithoutCommitsCount = 0
IF @CommitsStatusID = 42
	BEGIN
		SET @StyleWithCommitsCount = 0
		SET @CommitsCount = 0
		SET @PartnerCount = 0
		SET @COOCount = 0
		SET @StyleWithCommittedCount = 0
	END

IF @CommitsStatusID IN (SELECT CustomKey FROM pStyleQuoteItemStatus)
	BEGIN
		SET @StyleWithoutCommitsCount = 0
		SET @StyleWithCommittedCount = 0	
		SET @StyleWithCommitsCount = (
			SELECT	COUNT(*) AS StyleCount
			FROM
				dbo.pStyleHeader
				LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
				LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
			WHERE
				pStyleSeasonYear.SeasonYearID= @SeasonYearID
				AND pStyleHeader.StyleID IN (SELECT pSourcingCommitmentItem.StyleID FROM pSourcingCommitmentItem INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID WHERE pSourcingCommitmentItem.StyleQuoteItemStatusId = @CommitsStatusID))
		SET @CommitsCount = (
			SELECT COUNT(DISTINCT SourcingCommitmentItemID)
			FROM
				pSourcingCommitmentItem
				LEFT OUTER JOIN dbo.pStyleSeasonYear ON pSourcingCommitmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
				LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
			WHERE
				pStyleSeasonYear.SeasonYearID = @SeasonYearID
				AND pSourcingCommitmentItem.StyleQuoteItemStatusId = @CommitsStatusID)
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
				AND pSourcingCommitmentItem.StyleQuoteItemStatusId = @CommitsStatusID)
		SET @COOCount = (
			SELECT COUNT(DISTINCT uCountry.CountryCode)
			FROM
				pSourcingCommitmentItem
				INNER JOIN pSourcingTradePartner ON pSourcingCommitmentItem.StyleQuoteTradePartnerID = pSourcingTradePartner.SourcingTradePartnerID
				INNER JOIN vwx_TradePartnerRelationshipLevels_SEL ON pSourcingTradePartner.TradePartnerLevelID = vwx_TradePartnerRelationshipLevels_SEL.TradePartnerRelationshipLevelID
				INNER JOIN uTradePartner ON COALESCE(AgentID, VendorID, FactoryID) = uTradePartner.TradePartnerID
				INNER JOIN uCountry ON uTradePartner.Country = uCountry.CountryCode
				LEFT OUTER JOIN dbo.pStyleSeasonYear ON pSourcingCommitmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
				LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
			WHERE
				pStyleSeasonYear.SeasonYearID = @SeasonYearID
				AND pSourcingCommitmentItem.StyleQuoteItemStatusId = @CommitsStatusID)	
	END
IF @CommitsStatusID = 3
	SET @StyleWithCommittedCount = (
	SELECT	COUNT(*) AS StyleCount
	FROM
		dbo.pStyleHeader
		LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
		LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
	WHERE
		pStyleSeasonYear.SeasonYearID= @SeasonYearID
		AND pStyleHeader.StyleID IN (SELECT pSourcingCommitmentItem.StyleID
									 FROM
										pSourcingCommitmentItem
										INNER JOIN #tmpSoucingFolder ON pSourcingCommitmentItem.SourcingHeaderID = #tmpSoucingFolder.SourcingHeaderID
									 WHERE pSourcingCommitmentItem.StyleQuoteItemStatusId = @CommitsStatusID))

SELECT
	@StyleCount AS StyleCount
	, @StyleWithCommitsCount AS StyleWithCommitsCount
	, @StyleWithoutCommitsCount AS StyleWithoutCommitsCount
	, @StyleWithCommittedCount AS StyleWithCommittedCount
	, @CommitsCount AS CommitsCount
	, @PartnerCount AS PartnerCount
	, @COOCount AS COOCount

DROP TABLE #tmpSoucingFolder
DROP TABLE #tmpStyleID



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05234', GetDate())
GO
