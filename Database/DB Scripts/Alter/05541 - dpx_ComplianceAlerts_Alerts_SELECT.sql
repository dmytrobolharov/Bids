IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_ComplianceAlerts_Alerts_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_ComplianceAlerts_Alerts_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_ComplianceAlerts_Alerts_SELECT]

AS
BEGIN
	SELECT
		tp.TradePartnerName
		, tps.Status
		, tpcl.ComplianceName
		, tpcl.ComplianceType
		, tpcas.AuditStandardDesc
		, tpcl.Auditors
		, tpcl.ScheduleDate
		, tp.TradePartnerID
		, tpcl.TradePartnerComplianceId
	FROM uTradePartner tp
		LEFT JOIN uTradePartnerStatus tps ON tp.TradePartnerStatusID = tps.StatusID
		INNER JOIN uTradePartnerCompliance tpcl ON tp.TradePartnerID = tpcl.TradePartnerId
		INNER JOIN uTradePartnerComplianceAuditStandard tpcas ON tpcl.AuditStandardId = tpcas.AuditStandardId
	WHERE tp.Active = 1
		AND tpcl.Active = 1
		AND tpcl.AlertDate <= GETDATE()
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05541', GetDate())
GO
