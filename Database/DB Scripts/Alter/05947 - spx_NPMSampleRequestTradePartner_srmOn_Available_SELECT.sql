IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestTradePartner_srmOn_Available_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestTradePartner_srmOn_Available_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleRequestTradePartner_srmOn_Available_SELECT]
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@TradePartnerID UNIQUEIDENTIFIER,
	@Level INT
AS
BEGIN
	
	if @Level = 1
	begin
		SELECT DISTINCT AgentID AS TradePartnerID, AgentName AS TradePartnerName
		FROM pSampleRequestTrade srt
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pSampleRequestShare srs ON srt.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerID
		WHERE srt.StyleID IN (SELECT StyleID FROM pStyleDevelopmentItem WHERE StyleDevelopmentID = @StyleDevelopmentID) 
			AND @TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
			AND AgentID IS NOT NULL
	end
	else if @Level = 2
	begin
		SELECT DISTINCT VendorID AS TradePartnerID, VendorName AS TradePartnerName
		FROM pSampleRequestTrade srt
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pSampleRequestShare srs ON srt.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerID
		WHERE srt.StyleID IN (SELECT StyleID FROM pStyleDevelopmentItem WHERE StyleDevelopmentID = @StyleDevelopmentID) 
			AND @TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
			AND VendorID IS NOT NULL
	end
	else -- @Level = 3
	begin
		SELECT DISTINCT FactoryID AS TradePartnerID, FactoryName AS TradePartnerName
		FROM pSampleRequestTrade srt
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pSampleRequestShare srs ON srt.SampleRequestTradeID = srs.SampleRequestTradeID AND srs.TradePartnerID = @TradePartnerID
		WHERE srt.StyleID IN (SELECT StyleID FROM pStyleDevelopmentItem WHERE StyleDevelopmentID = @StyleDevelopmentID) 
			AND @TradePartnerID IN (tprl.AgentID, tprl.VendorID, tprl.FactoryID)
			AND FactoryID IS NOT NULL
	end
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05947', GetDate())
GO
