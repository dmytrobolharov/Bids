IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflow_ShareStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareStatus_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflow_ShareStatus_UPDATE]
(
	@MaterialRequestSubmitWorkflowID uniqueidentifier,
	@TradePartnerID uniqueidentifier,
	@IsADD bit,
	@MUser nvarchar(200),
	@MDate datetime
)
AS 

BEGIN

IF @IsADD = 1
	BEGIN 
		IF NOT EXISTS (
			SELECT * FROM pMaterialRequestSubmitWorkflowShare 
			WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID AND TradePartnerId = @TradePartnerID)
			
			/*
			INSERT INTO pMaterialRequestSubmitWorkflowShare (MaterialRequestSubmitWorkflowID, TradePartnerId, MUser, MDate) 
			VALUES(@MaterialRequestSubmitWorkflowID, @TradePartnerID, @MUser, @MDate)
			*/
			
			/* Corrected logic for sharing All colors material request workflows */
			INSERT INTO pMaterialRequestSubmitWorkflowShare (MaterialRequestSubmitWorkflowID, TradePartnerId, MUser, MDate) 
			SELECT CASE WHEN mrw.MaterialRequestWorkflowColor = 0
						THEN mrsw.MaterialRequestSubmitWorkflowID
					ELSE mrsw2.MaterialRequestSubmitWorkflowID END AS MaterialRequestSubmitWorkflowID,
					@TradePartnerID, @MUser, @MDate
			FROM pMaterialRequestSubmitWorkflow mrsw
			INNER JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
			LEFT JOIN pMaterialRequestSubmitWorkflow mrsw2
				INNER JOIN pMaterialRequestWorkflow mrw2 ON mrsw2.MaterialRequestWorkflowID = mrw2.MaterialRequestWorkflowID 
					ON mrsw.MaterialTradePartnerID = mrsw2.MaterialTradePartnerID
						AND mrsw.MaterialRequestWorkflowID = mrsw2.MaterialRequestWorkflowID
						AND mrw2.MaterialRequestWorkflowColor = 1 
			WHERE mrsw.MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID
				AND NOT EXISTS ( -- fix for creating requests within material_new page
					SELECT * FROM pMaterialRequestSubmitWorkflowShare mrsws 
					WHERE mrsws.TradePartnerID = @TradePartnerID 
						AND mrsws.MaterialRequestSubmitWorkflowID = CASE WHEN mrw.MaterialRequestWorkflowColor = 0
																		THEN mrsw.MaterialRequestSubmitWorkflowID
																	ELSE mrsw2.MaterialRequestSubmitWorkflowID END)
	END
ELSE
	BEGIN
		-- DELETE FROM pMaterialRequestSubmitWorkflowShare WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID AND TradePartnerId = @TradePartnerID
		
		DELETE FROM pMaterialRequestSubmitWorkflowShare 
		WHERE TradePartnerId = @TradePartnerID AND MaterialRequestSubmitWorkflowID IN (
			SELECT CASE WHEN mrw.MaterialRequestWorkflowColor = 0
						THEN mrsw.MaterialRequestSubmitWorkflowID
					ELSE mrsw2.MaterialRequestSubmitWorkflowID END
			FROM pMaterialRequestSubmitWorkflow mrsw
			INNER JOIN pMaterialRequestWorkflow mrw ON mrsw.MaterialRequestWorkflowID = mrw.MaterialRequestWorkflowID
			LEFT JOIN pMaterialRequestSubmitWorkflow mrsw2
				INNER JOIN pMaterialRequestWorkflow mrw2 ON mrsw2.MaterialRequestWorkflowID = mrw2.MaterialRequestWorkflowID 
					ON mrsw.MaterialTradePartnerID = mrsw2.MaterialTradePartnerID
						AND mrsw.MaterialRequestWorkflowID = mrsw2.MaterialRequestWorkflowID
						AND mrw2.MaterialRequestWorkflowColor = 1 
			WHERE mrsw.MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID)
	END
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07489', GetDate())
GO
