IF OBJECT_ID(N'[dbo].[rpx_Quote_Report_Change_Log]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Quote_Report_Change_Log]
GO

CREATE PROCEDURE [dbo].[rpx_Quote_Report_Change_Log]
	@BeginDate AS DATETIME
	, @EndDate AS DATETIME
	, @Status AS INT
AS
BEGIN
	SELECT
		CAST(sqi.StyleQuoteItemNo AS NVARCHAR(5)) AS StyleQuoteItemNo
		, soh.SourcingName, sh.StyleNo, sh.Description, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass
		, sh.StyleCategory AS StyleCategoryID, sc.StyleCategory
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS NVARCHAR(5))) AS StyleDevelopmentName
		, dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N'200') AS ImagePath
		, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL ('/' + tprl.FactoryName, ''), 2,1000) AS PartnerName
		, cli.ChangeFieldAlias, cli.ActionType, cli.ChangeUserName, cli.ChangeDate, cli.ChangeBeforeText, cli.ChangeAfterText
		, sh.StyleID, soh.SourcingHeaderID, sqi.StyleQuoteItemID, ssy.SeasonYearID, sqi.TradePartnerID, sqi.StyleDevelopmentID, sqi.StyleSourcingID
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
		LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
	WHERE
		(cli.ChangeDate BETWEEN DATEADD(day, -1, @BeginDate) AND DATEADD(day, 1, @EndDate))
		AND (sqi.StyleQuoteItemStatusId = @Status OR @Status IS NULL)

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09605', GetDate())
GO
