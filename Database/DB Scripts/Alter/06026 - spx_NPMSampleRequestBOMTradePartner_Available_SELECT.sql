IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleRequestBOMTradePartner_Available_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleRequestBOMTradePartner_Available_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_NPMSampleRequestBOMTradePartner_Available_SELECT]
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER,
	@Level INT
AS
BEGIN
	
	if @Level = 1
	begin
		SELECT DISTINCT AgentID AS TradePartnerID, AgentName AS TradePartnerName
		FROM pSampleRequestBOMTrade srt
		LEFT JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		WHERE srt.StyleID IN (
			SELECT StyleID FROM pStyleDevelopmentItem WHERE StyleDevelopmentID = @StyleDevelopmentID
			UNION
			SELECT wi.StyleID FROM pWorkFlowItemLinked link
			INNER JOIN pWorkflowItem wi ON wi.WorkFlowItemID = link.WorkFlowItemID
			INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = link.StyleID
			WHERE wi.WorkflowID = '40000000-0000-0000-0000-000000000050'
			AND sdi.StyleDevelopmentID = @StyleDevelopmentID
			) 
			AND ssy.SeasonYearID = @SeasonYearID 
			AND AgentID IS NOT NULL
	end
	else if @Level = 2
	begin
		SELECT DISTINCT VendorID AS TradePartnerID, VendorName AS TradePartnerName
		FROM pSampleRequestBOMTrade srt
		LEFT JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		WHERE srt.StyleID IN (
			SELECT StyleID FROM pStyleDevelopmentItem WHERE StyleDevelopmentID = @StyleDevelopmentID
			UNION
			SELECT wi.StyleID FROM pWorkFlowItemLinked link
			INNER JOIN pWorkflowItem wi ON wi.WorkFlowItemID = link.WorkFlowItemID
			INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = link.StyleID
			WHERE wi.WorkflowID = '40000000-0000-0000-0000-000000000050'
			AND sdi.StyleDevelopmentID = @StyleDevelopmentID
			) 
			AND ssy.SeasonYearID = @SeasonYearID 
			AND VendorID IS NOT NULL
	end
	else -- @Level = 3
	begin
		SELECT DISTINCT FactoryID AS TradePartnerID, FactoryName AS TradePartnerName
		FROM pSampleRequestBOMTrade srt
		LEFT JOIN pStyleSeasonYear ssy ON srt.StyleSeasonYearID = ssy.StyleSeasonYearID
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON srt.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		WHERE srt.StyleID IN (
			SELECT StyleID FROM pStyleDevelopmentItem WHERE StyleDevelopmentID = @StyleDevelopmentID
			UNION
			SELECT wi.StyleID FROM pWorkFlowItemLinked link
			INNER JOIN pWorkflowItem wi ON wi.WorkFlowItemID = link.WorkFlowItemID
			INNER JOIN pStyleDevelopmentItem sdi ON sdi.StyleID = link.StyleID
			WHERE wi.WorkflowID = '40000000-0000-0000-0000-000000000050'
			AND sdi.StyleDevelopmentID = @StyleDevelopmentID
			) 
			AND ssy.SeasonYearID = @SeasonYearID 
			AND FactoryID IS NOT NULL
	end
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06026', GetDate())
GO
