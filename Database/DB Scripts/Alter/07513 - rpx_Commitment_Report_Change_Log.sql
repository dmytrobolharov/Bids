IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Commitment_Report_Change_Log]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Commitment_Report_Change_Log]
GO

CREATE PROCEDURE [dbo].[rpx_Commitment_Report_Change_Log]
	@BeginDate AS DATETIME
	, @EndDate AS DATETIME
	, @Status AS INT
AS
BEGIN
	SELECT
		CAST(sci.StyleCommitmentNo AS NVARCHAR(5)) AS StyleCommitmentNo
		, soh.SourcingName
		, sh.StyleNo, sh.Description, sh.SizeClass, sh.StyleCategory AS StyleCategoryID, sc.StyleCategory
		, ISNULL(sdi.StyleDevelopmentName, 'Variation ' + CAST(sdi.Variation AS NVARCHAR(5))) AS StyleDevelopmentName
		, dbo.fnx_GetStreamingImagePathChangeLogReport(sh.DesignSketchID, sh.DesignSketchVersion, N'200') AS ImagePath
		, SUBSTRING(ISNULL('/' + tprl.AgentName, '') + ISNULL('/' + tprl.VendorName,'') + ISNULL ('/' + tprl.FactoryName, ''), 2,1000) AS PartnerName
		, cli.ChangeFieldAlias, cli.ActionType, cli.ChangeUserName, cli.ChangeDate, cli.ChangeBeforeText, cli.ChangeAfterText
		, sh.StyleID, soh.SourcingHeaderID, sci.SourcingCommitmentItemID, sci.StyleQuoteItemID, ssy.SeasonYearID, sci.TradePartnerID, sci.StyleDevelopmentID, sci.StyleSourcingID
		, ISNULL(tprl.AgentId, '00000000-0000-0000-0000-000000000000') AS AgentId, ISNULL(tprl.VendorId, '00000000-0000-0000-0000-000000000000') AS VendorId, ISNULL(tprl.FactoryId, '00000000-0000-0000-0000-000000000000') AS FactoryId
	FROM pSourcingCommitmentItem sci
		INNER JOIN vwx_ChangeLogItem_SEL cli ON sci.SourcingCommitmentItemID = cli.ChangeTablePKID AND cli.ChangeTableID = '9038A3FD-0580-422F-A3A6-895CA0223A81'
		INNER JOIN pStyleSeasonYear ssy ON sci.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN pSourcingHeader soh ON sci.SourcingHeaderID = soh.SourcingHeaderID
		INNER JOIN pStyleHeader sh ON sci.StyleID = sh.StyleID
		INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID
		INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId
		INNER JOIN pSourcingTradePartner stp ON sci.StyleQuoteTradePartnerID = stp.SourcingTradePartnerID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON stp.TradePartnerLevelID = tprl.TradePartnerRelationshipLevelID
	WHERE
		(cli.ChangeDate BETWEEN DATEADD(day, -1, @BeginDate) AND DATEADD(day, 1, @EndDate))
		AND (sci.StyleQuoteItemStatusId = @Status OR @Status IS NULL)

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07513', GetDate())
GO