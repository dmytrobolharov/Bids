IF OBJECT_ID(N'[dbo].[spx_SourcingStyle_Editor_Commits_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SourcingStyle_Editor_Commits_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SourcingStyle_Editor_Commits_SELECT]
	@SourcingHeaderID UNIQUEIDENTIFIER
	, @SearchCond NVARCHAR(MAX) = ''
AS
BEGIN
	SELECT DISTINCT
		sci.SourcingCommitmentItemID
		, sci.StyleSourcingID
		, sci.SourcingHeaderID
		, sci.StyleCommitmentNo
		, p.AgentName
		, p.VendorName
		, p.FactoryName
		, sh.StyleNo
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation as nVARCHAR(5))) as VariationName
		, sh.Description
		, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
		, CASE WHEN COUNT(scbd.SourcingCommitmentBOMDetailsID) > 0 THEN 1 ELSE 0 END AS isBOMDetail
		, p.AgentID
		, p.VendorID
		, p.FactoryID
		, sci.StyleQuoteItemID
		, sci.StyleQuoteItemStatusId
	INTO #tmpCommits
	FROM pSourcingCommitmentItem sci
		INNER JOIN pSourcingTradePartner stp ON stp.SourcingTradePartnerID = sci.StyleQuoteTradePartnerID
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID
		INNER JOIN pStyleHeader sh ON sci.StyleID = sh.StyleID 
		LEFT OUTER JOIN pStyleDevelopmentItem sdi ON sci.StyleID = sdi.StyleID 
		LEFT OUTER JOIN pSourcingCommitmentBOMDetails scbd ON sci.StyleColorID = scbd.StyleBOMDimensionID
			AND sci.SourcingCommitmentItemID = scbd.SourcingCommitmentItemID
			AND scbd.ItemDim1Active=1
			AND scbd.ItemDim2Active=1
			AND scbd.ItemDim3Active=1
		LEFT JOIN pSizeClass sc ON sc.Custom = sh.SizeClass
	WHERE
		sci.SourcingHeaderID = @SourcingHeaderID
	GROUP BY
		sci.SourcingCommitmentItemID
		, sci.StyleSourcingID
		, sci.SourcingHeaderID
		, sci.StyleCommitmentNo
		, p.AgentName
		, p.VendorName
		, p.FactoryName
		, sh.StyleNo
		, sdi.StyleDevelopmentName
		, sdi.Variation
		, sh.Description
		, COALESCE(sc.Custom, sh.SizeClass)
		, p.AgentID
		, p.VendorID
		, p.FactoryID
		, sci.StyleQuoteItemID
		, sci.StyleQuoteItemStatusId
	
	EXEC('SELECT * FROM #tmpCommits ' + @SearchCond + ' ORDER BY StyleCommitmentNo DESC ' )
	
	DROP TABLE #tmpCommits
   
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09783', GetDate())
GO
