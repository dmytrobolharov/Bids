IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_DashMaterial_MaterialRequest_List_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_DashMaterial_MaterialRequest_List_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_DashMaterial_MaterialRequest_List_SELECT]
(
	@SeasonYearID UNIQUEIDENTIFIER
	, @MaterialTypeID INT
	, @TradePartnerRelationshipLevelID UNIQUEIDENTIFIER
)
AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	SELECT
		m.MaterialNo
		, m.MaterialName
		, mtpc.ColorName
		, ms.MaterialSize
		, mrw.MaterialRequestWorkflow
		, mrss.Status
		, 'javascript:window.open (''' + AppSettingValue + '/Material/Material_Request.aspx?MRSID=' + CAST(mrs.MaterialRequestSubmitID AS NVARCHAR(50))+ ''');' AS MaterialLink
	FROM pMaterial m
		INNER JOIN pMaterialTradePartner mtp ON m.MaterialID = mtp.MaterialId
			AND mtp.SeasonYearID = @SeasonYearID
			AND mtp.TradePartnerRelationshipLevelID = @TradePartnerRelationshipLevelID
		INNER JOIN pMaterialTradePartnerColor mtpc ON mtp.MaterialTradePartnerId = mtpc.MaterialTradePartnerID
		LEFT JOIN pMaterialSize ms ON mtpc.MaterialSizeID = ms.MaterialSizeID
		INNER JOIN pMaterialRequestSubmitWorkflow mrsw ON mtpc.MaterialTradePartnerColorID = mrsw.MaterialTradePartnerColorID
		INNER JOIN pMaterialRequestSubmit mrs ON mrsw.MaterialRequestSubmitWorkflowID = mrs.MaterialRequestSubmitWorkflowID AND mrsw.Submit = mrs.Submit
		INNER JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
		LEFT JOIN pMaterialRequestSubmitStatus mrss ON mrsw.Status = mrss.StatusID
		, sAppSetting	
	WHERE m.MaterialType = @MaterialTypeID
		AND AppSettingKey = 'plmOnApplicationServerUrl'
	ORDER BY m.MaterialNo, m.MaterialName
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08835', GetDate())
GO
