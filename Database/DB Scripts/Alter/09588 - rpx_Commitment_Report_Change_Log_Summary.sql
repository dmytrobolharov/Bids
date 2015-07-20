IF OBJECT_ID(N'[dbo].[rpx_Commitment_Report_Change_Log_Summary]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Commitment_Report_Change_Log_Summary]
GO

CREATE PROCEDURE [dbo].[rpx_Commitment_Report_Change_Log_Summary] 
	@BeginDate AS DATETIME
	, @EndDate AS DATETIME
	, @Status AS INT
AS
BEGIN
	SELECT
		CAST(sci.StyleCommitmentNo AS nVARCHAR(5)) AS StyleCommitmentNo, sci.StyleQuoteItemNo, ssy.SeasonYearID
		, soh.SourcingName, sh.StyleNo, sh.Description
		, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, sh.StyleCategory AS StyleCategoryID, sc.StyleCategory
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS nVARCHAR(5))) AS StyleDevelopmentName
		, dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N'200') AS ImagePath
		, tprl.AgentName, tprl.VendorName, tprl.FactoryName
		, COUNT(*) AS NoOfChanges
		, sh.StyleID, soh.SourcingHeaderID, sci.SourcingCommitmentItemID, sci.StyleQuoteItemID, sci.TradePartnerID, sci.StyleDevelopmentID, sci.StyleSourcingID, ISNULL(tprl.AgentId, '00000000-0000-0000-0000-000000000000') AS AgentId, ISNULL(tprl.VendorId, '00000000-0000-0000-0000-000000000000') AS VendorId, ISNULL(tprl.FactoryId, '00000000-0000-0000-0000-000000000000') AS FactoryId
	FROM pSourcingCommitmentItem sci
		INNER JOIN vwx_ChangeLogItem_SEL cli ON sci.SourcingCommitmentItemID = cli.ChangeTablePKID AND cli.ChangeTableID = '9038A3FD-0580-422F-A3A6-895CA0223A81'
		INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pSourcingHeader soh ON sci.SourcingHeaderID = soh.SourcingHeaderID
		INNER JOIN pStyleHeader sh ON sci.StyleID = sh.StyleID
		INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
		INNER JOIN pSourcingTradePartner stp ON sci.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
		LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
	WHERE
		(cli.ChangeDate BETWEEN DATEADD(day, -1, @BeginDate) AND DATEADD(day, 1, @EndDate))
		AND (sci.StyleQuoteItemStatusId = @Status OR @Status IS NULL)
	GROUP BY
		sci.StyleCommitmentNo, sci.StyleQuoteItemNo, ssy.SeasonYearID
		, soh.SourcingName, sh.StyleNo, sh.Description
		, COALESCE(scc.Custom, sh.SizeClass), sh.StyleCategory, sh.DesignSketchID
		, sh.DesignSketchVersion, sdi.StyleDevelopmentName, sdi.Variation, sc.StyleCategory
		, tprl.AgentName, tprl.VendorName, tprl.FactoryName
		, sh.StyleID, soh.SourcingHeaderID, sci.SourcingCommitmentItemID, sci.StyleQuoteItemID, sci.TradePartnerID, sci.StyleDevelopmentID, sci.StyleSourcingID, tprl.AgentId, tprl.VendorId, tprl.FactoryId
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09588', GetDate())
GO
