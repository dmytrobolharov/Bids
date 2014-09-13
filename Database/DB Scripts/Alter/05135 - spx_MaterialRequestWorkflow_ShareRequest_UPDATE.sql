IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflow_ShareRequest_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareRequest_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareRequest_UPDATE]
	@MaterialTradePartnerID UNIQUEIDENTIFIER,
	@MaterialTradePartnerColorID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @MaterialRequestWorkflowSubmitID UNIQUEIDENTIFIER,
			@AgentID UNIQUEIDENTIFIER,
			@VendorID UNIQUEIDENTIFIER,
			@FactoryID UNIQUEIDENTIFIER,
			@WorkflowCursor CURSOR
	
	SELECT @AgentID = AgentID, @VendorID = VendorID, @FactoryID = FactoryID
	FROM pMaterialTradePartner mtp LEFT JOIN vwx_TradePartnerRelationshipLevels_SEL tpm
	ON mtp.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
	WHERE MaterialTradePartnerId = @MaterialTradePartnerID
	
	SET @WorkflowCursor = CURSOR SCROLL
	FOR SELECT MaterialRequestSubmitWorkflowID FROM pMaterialRequestSubmitWorkflow
	WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID 
	AND MaterialTradePartnerID = @MaterialTradePartnerID
	
	OPEN @WorkflowCursor
	FETCH NEXT FROM @WorkflowCursor INTO @MaterialRequestWorkflowSubmitID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @AgentID IS NOT NULL
			EXEC spx_MaterialRequestWorkflow_ShareStatus_UPDATE
			@MaterialRequestSubmitWorkflowID = @MaterialRequestWorkflowSubmitID,
			@TradePartnerID = @AgentID,
			@IsADD = 1,
			@MUser = NULL,
			@MDate = NULL
			
		IF @VendorID IS NOT NULL
			EXEC spx_MaterialRequestWorkflow_ShareStatus_UPDATE
			@MaterialRequestSubmitWorkflowID = @MaterialRequestWorkflowSubmitID,
			@TradePartnerID = @VendorID,
			@IsADD = 1,
			@MUser = NULL,
			@MDate = NULL
			
		IF @FactoryID IS NOT NULL
			EXEC spx_MaterialRequestWorkflow_ShareStatus_UPDATE
			@MaterialRequestSubmitWorkflowID = @MaterialRequestWorkflowSubmitID,
			@TradePartnerID = @FactoryID,
			@IsADD = 1,
			@MUser = NULL,
			@MDate = NULL
			
		FETCH NEXT FROM @WorkflowCursor INTO @MaterialRequestWorkflowSubmitID
	END
	
	CLOSE @WorkflowCursor
	DEALLOCATE @WorkflowCursor
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05135', GetDate())
GO
