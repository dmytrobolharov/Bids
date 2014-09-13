IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPM_SampleRequest_TradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPM_SampleRequest_TradePartner_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_NPM_SampleRequest_TradePartner_SELECT] 
	@SampleRequestTradeID UNIQUEIDENTIFIER, 
	@FlagBOM INT
AS
BEGIN

	IF @FlagBOM = 1
	BEGIN
		SELECT 
			tpm.AgentID, tpm.AgentCode, tpm.AgentName, tpm.AgentActive, 
			tpm.VendorID, tpm.VendorCode, tpm.VendorName, tpm.VendorActive, 
			tpm.FactoryID, tpm.FactoryCode, tpm.FactoryName, tpm.FactoryActive 
		FROM pSampleRequestBOMTrade srt
			INNER JOIN vwx_TradePartnerMgmt_SEL tpm ON srt.TradePartnerRelationshipLevelID = tpm.RelationshipLevelID
		WHERE SampleRequestTradeID = @SampleRequestTradeID
	END
	ELSE
	BEGIN
		SELECT 
			tpm.AgentID, tpm.AgentCode, tpm.AgentName, tpm.AgentActive, 
			tpm.VendorID, tpm.VendorCode, tpm.VendorName, tpm.VendorActive, 
			tpm.FactoryID, tpm.FactoryCode, tpm.FactoryName, tpm.FactoryActive 
		FROM pSampleRequestTrade srt
			INNER JOIN vwx_TradePartnerMgmt_SEL tpm ON srt.TradePartnerRelationshipLevelID = tpm.RelationshipLevelID
		WHERE SampleRequestTradeID = @SampleRequestTradeID
	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04879', GetDate())
GO
