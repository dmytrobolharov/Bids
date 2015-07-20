IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequest_TradePartner_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequest_TradePartner_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequest_TradePartner_SELECT]
	@MaterialTradePartnerColorID UNIQUEIDENTIFIER = NULL,
	@MaterialTradePartnerID UNIQUEIDENTIFIER,
	@MaterialRequestWorkflowID NVARCHAR(100) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @MaterialRequestWorkflowID <> ''
	BEGIN
		SELECT tpm.*, sw.*, ISNULL(pt.CustomKey, 1) AS OwnerLevel, pt.Custom AS OwnerName FROM pMaterialTradePartner mtp
		INNER JOIN pMaterialRequestSubmitWorkflow sw ON sw.TradePartnerID = mtp.TradepartnerId
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON mtp.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
		LEFT JOIN uTradePartnerType pt ON pt.CustomId = sw.MaterialRequestPartnerTypeID
		WHERE sw.MaterialRequestWorkflowID = @MaterialRequestWorkflowID
		AND sw.MaterialTradePartnerID = @MaterialTradePartnerID
		AND sw.MaterialTradePartnerColorID = @MaterialTradePartnerColorID
    END
    ELSE
    BEGIN
		SELECT tpm.*, -1 AS OwnerLevel, NULL AS MaterialRequestSubmitWorkflowID
		FROM pMaterialTradePartner mtp
		LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm ON mtp.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
		WHERE mtp.MaterialTradePartnerID = @MaterialTradePartnerID
    END
    
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05132', GetDate())
GO
