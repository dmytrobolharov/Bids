IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_CUser_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_CUser_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_NPM_Sample_Request_Shared_Comment_Summary_CUser_SELECT]
	@TradePartnerID nVARCHAR(MAX)
AS
BEGIN
	SET @TradePartnerID = REPLACE(@TradePartnerID, ' ', '')

SELECT DISTINCT src.CTeamID, src.CUser
FROM pSampleRequestTrade srt
	INNER JOIN pSampleRequestSubmit srs ON srt.SampleRequestTradeID = srs.SampleRequestTradeID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN pSampleRequestComment src ON srs.SampleRequestTradeID = src.SampleRequestTradeID
		AND srs.SampleRequestWorkflowID = src.SampleRequestWorkflowID
		AND srs.StyleID = src.StyleID
		AND srs.Submit = src.SampleSubmit
		AND srs.StyleSet = src.StyleSet
		AND src.SampleCommentType = 'S'
WHERE 
	tprl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')) 

UNION 

SELECT DISTINCT src.CTeamID, src.CUser
FROM pSampleRequestBOMTrade srbt
	INNER JOIN pSampleRequestSubmitBOM srsb ON srbt.SampleRequestTradeID = srsb.SampleRequestTradeID
	INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srbt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
	INNER JOIN pSampleRequestComment src ON srsb.SampleRequestTradeID = src.SampleRequestTradeID
		AND srsb.SampleRequestWorkflowID = src.SampleRequestWorkflowID
		AND srsb.StyleID = src.StyleID
		AND srsb.Submit = src.SampleSubmit
		AND srsb.StyleSet = src.StyleSet
		AND src.SampleCommentType = 'S'
WHERE 
	tprl.AgentID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.VendorID in (select value from dbo.fnx_Split(@TradePartnerID, ','))
	OR tprl.FactoryID in (select value from dbo.fnx_Split(@TradePartnerID, ',')) 

ORDER BY src.CUser
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06799', GetDate())
GO