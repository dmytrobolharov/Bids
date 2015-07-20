IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Quote_Report_Change_Log_Summary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Quote_Report_Change_Log_Summary]
GO

CREATE PROCEDURE [dbo].[rpx_Quote_Report_Change_Log_Summary] 
	@BeginDate AS DATETIME
	, @EndDate AS DATETIME
	, @Status AS INT
AS
BEGIN
	SELECT
		CAST(sqi.StyleQuoteItemNo AS NVARCHAR(5)) AS StyleQuoteItemNo
		, soh.SourcingName
		, sh.StyleNo, sh.Description, sh.SizeClass, sh.StyleCategory AS StyleCategoryID, sc.StyleCategory
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS NVARCHAR(5))) AS StyleDevelopmentName
		, dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N'200') AS ImagePath
		, tprl.AgentName, tprl.VendorName, tprl.FactoryName
		, COUNT(*) AS NoOfChanges
		, sh.StyleID, soh.SourcingHeaderID, sqi.StyleQuoteItemID, sqi.TradePartnerID, sqi.StyleDevelopmentID, sqi.StyleSourcingID, ssy.SeasonYearID
		, ISNULL(tprl.AgentId, '00000000-0000-0000-0000-000000000000') AS AgentId, ISNULL(tprl.VendorId, '00000000-0000-0000-0000-000000000000') AS VendorId, ISNULL(tprl.FactoryId, '00000000-0000-0000-0000-000000000000') AS FactoryId
	FROM pStyleQuoteItem sqi
		INNER JOIN vwx_ChangeLogItem_SEL cli ON sqi.StyleQuoteItemID = cli.ChangeTablePKID AND cli.ChangeTableID = '8038A3FD-0580-422F-A3A6-895CA0223A81'
		INNER JOIN pStyleSeasonYear ssy ON sqi.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pSourcingHeader soh ON sqi.SourcingHeaderID = soh.SourcingHeaderID
		INNER JOIN pStyleHeader sh ON sqi.StyleID = sh.StyleID
		INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
		INNER JOIN pSourcingTradePartner stp ON sqi.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
	WHERE
		(cli.ChangeDate BETWEEN DATEADD(day, -1, @BeginDate) AND DATEADD(day, 1, @EndDate))
		AND (sqi.StyleQuoteItemStatusId = @Status OR @Status IS NULL)
	GROUP BY
		sqi.StyleQuoteItemNo, ssy.SeasonYearID
		, soh.SourcingName
		, sh.StyleNo, sh.Description, sh.SizeClass, sh.StyleCategory, sh.DesignSketchID, sh.DesignSketchVersion, sdi.StyleDevelopmentName, sdi.Variation, sc.StyleCategory
		, tprl.AgentName, tprl.VendorName, tprl.FactoryName
		, sh.StyleID, soh.SourcingHeaderID, sqi.StyleQuoteItemID, sqi.TradePartnerID, sqi.StyleDevelopmentID, sqi.StyleSourcingID, tprl.AgentId, tprl.VendorId, tprl.FactoryId
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07510', GetDate())
GO