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

-- if the workflow is shared, why the whole request isn't?
DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER
SELECT @MaterialTradePartnerID = MaterialTradePartnerID FROM pMaterialRequestSubmitWorkflow
WHERE MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID

IF EXISTS( -- share the request if there is any shared workflows
	SELECT *
	FROM pMaterialRequestSubmitWorkflow mrsw
	INNER JOIN pMaterialRequestSubmitWorkflowShare mrsws ON mrsw.MaterialRequestSubmitWorkflowID = mrsws.MaterialRequestSubmitWorkflowID
	WHERE mrsw.MaterialTradePartnerID = @MaterialTradePartnerID)
BEGIN
	EXEC spx_MaterialTradePartner_ShareStatus_UPDATE
		@MaterialTradePartnerID = @MaterialTradePartnerID,
		@TradePartnerID = @TradePartnerID,
		@IsADD = 1,
		@MUser = @MUser,
		@MDate = @MDate
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09109', GetDate())
GO
