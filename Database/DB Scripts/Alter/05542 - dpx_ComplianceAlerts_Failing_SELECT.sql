IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_ComplianceAlerts_Failing_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_ComplianceAlerts_Failing_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_ComplianceAlerts_Failing_SELECT]

AS
BEGIN

	DECLARE @tmpCount TABLE (TradePartnerID UNIQUEIDENTIFIER, AllCount INT)
	
	INSERT INTO @tmpCount
	SELECT
		tp.TradePartnerID
		, COUNT(cnt.CountID) AS AllCount
	FROM uTradePartner tp
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON tprl.AgentID = tp.TradePartnerID OR tprl.VendorID = tp.TradePartnerID OR tprl.FactoryID = tp.TradePartnerID
		LEFT JOIN (
			SELECT sqi.StyleQuoteItemID AS CountID, stp.TradePartnerLevelID AS LevelID from pSourcingTradePartner stp
				LEFT JOIN pStyleQuoteItem sqi ON stp.SourcingTradePartnerID = sqi.StyleQuoteTradePartnerID
			UNION
			SELECT SampleRequestTradeID AS CountID, TradePartnerRelationshipLevelID AS LevelID FROM pSampleRequestBOMTrade
			UNION
			SELECT SampleRequestTradeID AS CountID, TradePartnerRelationshipLevelID AS LevelID FROM pSampleRequestTrade
			UNION
			SELECT mrs.MaterialTradePartnerColorID AS CountID, mtp.TradePartnerRelationshipLevelID AS LevelID FROM pMaterialTradePartner mtp
				LEFT JOIN pMaterialRequestSubmit mrs ON mrs.MaterialTradePartnerID = mtp.MaterialTradePartnerId
		) cnt ON tprl.TradePartnerRelationshipLevelID = cnt.LevelID
	GROUP BY tp.TradePartnerID

	SELECT
		tp.TradePartnerName
		, tps.Status
		, tpcl.ComplianceName
		, tpcl.ComplianceType
		, tpcas.AuditStandardDesc
		, tpcl.Auditors
		, tpcl.FinalDate
		, tc.AllCount
		, tp.TradePartnerID
		, tpcl.TradePartnerComplianceId
	FROM uTradePartner tp
		LEFT JOIN uTradePartnerStatus tps ON tp.TradePartnerStatusID = tps.StatusID
		INNER JOIN uTradePartnerCompliance tpcl ON tp.TradePartnerID = tpcl.TradePartnerId
		INNER JOIN uTradePartnerComplianceAuditStandard tpcas ON tpcl.AuditStandardId = tpcas.AuditStandardId
		INNER JOIN @tmpCount tc ON tp.TradePartnerID = tc.TradePartnerID
	WHERE tp.Active = 1
		AND tpcl.Active = 1
		AND tpcl.StatusId = '00000000-0000-0000-0000-000000000001'
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05542', GetDate())
GO
