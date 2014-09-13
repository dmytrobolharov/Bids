IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflow_ShareRequestHeader_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareRequestHeader_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareRequestHeader_UPDATE]
	@MaterialTradePartnerID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @AgentID UNIQUEIDENTIFIER,
			@VendorID UNIQUEIDENTIFIER,
			@FactoryID UNIQUEIDENTIFIER
	
	SELECT @AgentID = AgentID, @VendorID = VendorID, @FactoryID = FactoryID
	FROM pMaterialTradePartner mtp LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm
	ON mtp.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
	WHERE MaterialTradePartnerId = @MaterialTradePartnerID

	IF @AgentID IS NOT NULL
		EXEC spx_MaterialTradePartner_ShareStatus_UPDATE
		@MaterialTradePartnerID = @MaterialTradePartnerID,
		@TradePartnerID = @AgentID,
		@IsADD = 1,
		@MUser = NULL,
		@MDate = NULL
	ELSE IF @VendorID IS NOT NULL
		EXEC spx_MaterialTradePartner_ShareStatus_UPDATE
		@MaterialTradePartnerID = @MaterialTradePartnerID,
		@TradePartnerID = @VendorID,
		@IsADD = 1,
		@MUser = NULL,
		@MDate = NULL
	ELSE IF @FactoryID IS NOT NULL
		EXEC spx_MaterialTradePartner_ShareStatus_UPDATE
		@MaterialTradePartnerID = @MaterialTradePartnerID,
		@TradePartnerID = @FactoryID,
		@IsADD = 1,
		@MUser = NULL,
		@MDate = NULL

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05136', GetDate())
GO
