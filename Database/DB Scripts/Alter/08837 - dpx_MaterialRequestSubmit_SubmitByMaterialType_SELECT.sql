IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_MaterialRequestSubmit_SubmitByMaterialType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_MaterialRequestSubmit_SubmitByMaterialType_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_MaterialRequestSubmit_SubmitByMaterialType_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER
	, @MaterialTypeID INT
)
AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	SELECT COUNT(*) AS COUNT
		, CASE WHEN mrss.StatusID = 0 AND mrsw.Submit <> 1 THEN 1 ELSE mrss.StatusID END AS StatusID
		, CASE WHEN mrss.StatusID = 0 AND mrsw.Submit <> 1 THEN 'Resubmit' ELSE mrss.STATUS END AS STATUS
		, tprl.TradePartnerFullName
		, m.MaterialType
		, mtp.TradePartnerRelationshipLevelID
	FROM pMaterialRequestSubmitWorkflow mrsw
		INNER JOIN pMaterialRequestSubmitStatus mrss ON mrsw.STATUS = mrss.StatusID
		INNER JOIN pMaterialTradePartner mtp ON mrsw.MaterialTradePartnerID = mtp.MaterialTradePartnerId
		INNER JOIN vwx_TradePartnerRelationshipLevels_SEL tprl ON mtp.TradePartnerRelationshipLevelID = tprl.TradePartnerRelationshipLevelID
		INNER JOIN pMaterial m ON mrsw.MaterialID = m.MaterialID
	WHERE mtp.SeasonYearID = @SeasonYearID
		AND (m.MaterialType = @MaterialTypeID)
	GROUP BY mrss.STATUS
		, mrss.StatusID
		, mrsw.Submit
		, tprl.TradePartnerFullName
		, m.MaterialType
		, mtp.TradePartnerRelationshipLevelID
	ORDER BY mrss.StatusID
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08837', GetDate())
GO
