IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_QuoteToDoStyle_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_QuoteToDoStyle_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_QuoteToDoStyle_SELECT]
(
	@SeasonYearID uniqueidentifier = NULL
	, @QuoteStatusID INT = NULL
)
AS
BEGIN

	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
	SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	IF @QuoteStatusID IS NULL
		SELECT
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
			, (CASE WHEN COUNT(sci.SourcingCommitmentItemID)>0 THEN 'Yes' END) AS isCommited
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
			INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
			LEFT OUTER JOIN pStyleQuoteItem sqi ON sh.StyleID = sqi.StyleID
			LEFT OUTER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
			LEFT OUTER JOIN pSourcingCommitmentItem sci ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
		GROUP BY
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation)
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID
			
	-- With Quotes
	IF @QuoteStatusID = 100
		SELECT
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
			, (CASE WHEN COUNT(sci.SourcingCommitmentItemID)>0 THEN 'Yes' END) AS isCommited
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
			INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
			INNER JOIN pStyleQuoteItem sqi ON sh.StyleID = sqi.StyleID
			LEFT OUTER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
			LEFT OUTER JOIN pSourcingCommitmentItem sci ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
		GROUP BY
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation)
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID

	-- Has BOM Options
	IF @QuoteStatusID = 200
		SELECT
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
			, (CASE WHEN COUNT(sci.SourcingCommitmentItemID)>0 THEN 'Yes' END) AS isCommited
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
			INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
			INNER JOIN pStyleQuoteItem sqi ON sh.StyleID = sqi.StyleID
			INNER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
			LEFT OUTER JOIN pSourcingCommitmentItem sci ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
		GROUP BY
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation)
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID
	
	--Without Quotes
	IF @QuoteStatusID = 42
		SELECT
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
			, (CASE WHEN COUNT(sci.SourcingCommitmentItemID)>0 THEN 'Yes' END) AS isCommited
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
			INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
			LEFT OUTER JOIN pStyleQuoteItem sqi ON sh.StyleID = sqi.StyleID
			LEFT OUTER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
			LEFT OUTER JOIN pSourcingCommitmentItem sci ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
		GROUP BY
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation)
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID
		HAVING
			COUNT(DISTINCT sqi.StyleQuoteItemID)=0		

	--With Commits
	IF @QuoteStatusID = -1
		SELECT
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
			, (CASE WHEN COUNT(sci.SourcingCommitmentItemID)>0 THEN 'Yes' END) AS isCommited
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
			INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
			LEFT OUTER JOIN pStyleQuoteItem sqi ON sh.StyleID = sqi.StyleID
			LEFT OUTER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
			INNER JOIN pSourcingCommitmentItem sci ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
		GROUP BY
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation)
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID

	IF @QuoteStatusID IN (SELECT CustomKey FROM pStyleQuoteItemStatus)
		SELECT
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation) AS Variation
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3 AS StyleStatus
			, (CASE WHEN COUNT(DISTINCT sqi.StyleQuoteItemID)>0 THEN COUNT(DISTINCT sqi.StyleQuoteItemID) END) AS StyleQuoteCount
			, (CASE WHEN COUNT(sqboi.StyleQuoteItemID)>0 THEN 'Yes' END) AS HasBOMOption
			, (CASE WHEN COUNT(sci.SourcingCommitmentItemID)>0 THEN 'Yes' END) AS isCommited
			, (CASE WHEN sh.TechPackDate<GETDATE() THEN DATEDIFF(d, sh.TechPackDate, GETDATE()) END) AS DaysLate
			, sh.StyleID
		FROM
			pStyleHeader sh
			INNER JOIN pStyleDevelopmentItem sdi ON sh.DevelopmentID = sdi.StyleDevelopmentID
			INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
			INNER JOIN pStyleQuoteItem sqi ON sh.StyleID = sqi.StyleID
			INNER JOIN pStyleQuoteItemStatus sqis ON sqi.StyleQuoteItemStatusId = sqis.CustomKey
			LEFT OUTER JOIN pSourcingQuotationBOMOption sqboi ON sqi.StyleQuoteItemID = sqboi.StyleQuoteItemID
			LEFT OUTER JOIN pSourcingCommitmentItem sci ON sh.StyleID = sci.StyleID
			LEFT OUTER JOIN dbo.pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			LEFT OUTER JOIN dbo.pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
		WHERE
			ssy.SeasonYearID = @SeasonYearID
		GROUP BY
			sh.StyleNo
			, ISNULL(sdi.StyleDevelopmentName, sdi.Variation)
			, sh.Description
			, sc.StyleCategory
			, sh.SizeClass
			, sh.CustomField3
			, sh.TechPackDate
			, sh.StyleID
			
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05068', GetDate())
GO
