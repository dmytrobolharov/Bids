/****** Object:  StoredProcedure [dbo].[dpx_StyleFolder_WHERECount_SELECT]    Script Date: 04/09/2013 13:37:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_StyleFolder_WHERECount_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_StyleFolder_WHERECount_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[dpx_StyleFolder_WHERECount_SELECT]    Script Date: 04/09/2013 13:37:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[dpx_StyleFolder_WHERECount_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
)

AS

DECLARE @StyleCount INT
DECLARE @ColorCount INT
DECLARE @SampleCount INT
DECLARE @SampleCountBOM INT
DECLARE @MaterialCount INT
DECLARE @CountryCount INT
DECLARE @TechPackCount INT
DECLARE @QuoteCount INT
DECLARE @CostingCount INT

SET @StyleCount = 0
SET @ColorCount = 0
SET @SampleCount = 0
SET @SampleCountBOM = 0
SET @MaterialCount = 0
SET @CountryCount = 0
SET @TechPackCount = 0
SET @QuoteCount = 0
SET @CostingCount = 0


IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
BEGIN 
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
END


-- Get Total # of Style
BEGIN
	
	SET @StyleCount = (
							SELECT     COUNT(*) AS StyleCount
							FROM  dbo.pStyleHeader LEFT OUTER JOIN  
							dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID LEFT OUTER JOIN  
							dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID  
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)

)
END

-- Get Total # of Color
BEGIN
	SET @ColorCount = (
						SELECT  COUNT(*) AS COUNT
						FROM pStyleHeader INNER JOIN
							pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID INNER JOIN
							pStyleColorwaySeasonYear ON pStyleSeasonYear.StyleSeasonYearID = pStyleColorwaySeasonYear.StyleSeasonYearID
						WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)
)
END

-- Get Total # of Sample
BEGIN
	SET @SampleCount = (
							SELECT COUNT(*)
							FROM pStyleHeader
								INNER JOIN pSampleRequestTrade srt ON pStyleHeader.StyleID = srt.StyleID
								INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
							WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
)     
END

-- Get Total # of BOM Sample
BEGIN
	SET @SampleCountBOM = (
							SELECT COUNT(*)
							FROM pStyleHeader
								INNER JOIN pSampleRequestBOMTrade srt ON pStyleHeader.StyleID = srt.StyleID
								INNER JOIN pStyleSeasonYear ON srt.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
							WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
)     
END

-- Get Total # of Material
BEGIN

							SELECT COUNT(*) AS COUNT
							INTO #tmpMaterialCount
							FROM pStyleHeader INNER JOIN
								pStyleSeasonYear ON pStyleHeader.StyleID = pStyleSeasonYear.StyleID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)
							GROUP BY pStyleHeader.MaterialID

								SET @MaterialCount = (SELECT COUNT(*) FROM #tmpMaterialCount)

							DROP TABLE #tmpMaterialCount
END

-- Get Total # of Tech Pack
BEGIN
	SET @TechPackCount = (
							SELECT COUNT(*) AS COUNT
							FROM pTechPack INNER JOIN
								pStyleSeasonYear ON pTechPack.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)
)
END


-- Get Total # of Costing
BEGIN
	SET @CostingCount = (
							SELECT  COUNT(*) 
							FROM pStyleSeasonYear INNER JOIN
							pStyleCostingHeader ON pStyleSeasonYear.StyleSeasonYearID = pStyleCostingHeader.StyleSeasonYearID
							WHERE (pStyleSeasonYear.SeasonYearID = @SeasonYearID)
)
END

-- Get Total # of Quotes
BEGIN
	SET @QuoteCount = (
							SELECT COUNT(DISTINCT StyleQuoteItemID) FROM
								pStyleQuoteItem
								INNER JOIN dbo.pStyleHeader ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID
								LEFT OUTER JOIN dbo.pStyleSeasonYear ON dbo.pStyleHeader.StyleID = dbo.pStyleSeasonYear.StyleID
								LEFT OUTER JOIN dbo.pSeasonYear ON dbo.pSeasonYear.SeasonYearID = dbo.pStyleSeasonYear.SeasonYearID
								INNER JOIN pSourcingHeader ON pStyleQuoteItem.SourcingHeaderID = pSourcingHeader.SourcingHeaderID
								WHERE pStyleSeasonYear.SeasonYearID = @SeasonYearID
)
END

BEGIN
	CREATE TABLE #tmpStyleCount(
		StyleCount int NULL,
		ColorCount int NULL,
		SampleCount int NULL,
		MaterialCount int NULL,
		CountryCount int NULL,
		TechPackCount int NULL,
		QuoteCount int NULL,
		CostingCount int NULL
	) 
END

BEGIN
	INSERT INTO #tmpStyleCount(StyleCount, ColorCount, SampleCount, MaterialCount, CountryCount, TechPackCount, QuoteCount, CostingCount)
		VALUES (@StyleCount, @ColorCount, ISNULL(@SampleCount,0)+ISNULL(@SampleCountBOM,0), @MaterialCount, @CountryCount, @TechPackCount, @QuoteCount, @CostingCount)
END

BEGIN
	SELECT TOP 1 * FROM #tmpStyleCount
END

BEGIN
	DROP TABLE #tmpStyleCount
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES	('DB_Version', '0.5.0000', '05512', GetDate())
GO
