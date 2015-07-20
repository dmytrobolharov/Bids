IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE](
@MaterialTradePartnerID UNIQUEIDENTIFIER 
)
AS 

	DELETE FROM dbo.pMaterialRequestSubmitComment 
	WHERE MaterialRequestSubmitID IN ( 
		SELECT MaterialRequestSubmitID FROM dbo.pMaterialRequestSubmit
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID 
	)

	DELETE FROM dbo.pMaterialRequestSubmitDocument
	WHERE MaterialRequestSubmitID IN ( 
		SELECT MaterialRequestSubmitID FROM dbo.pMaterialRequestSubmit
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID 
	)

	DELETE FROM dbo.pMaterialRequestSubmitItem
	WHERE MaterialRequestSubmitID IN ( 
		SELECT MaterialRequestSubmitID FROM dbo.pMaterialRequestSubmit
		WHERE MaterialTradePartnerID = @MaterialTradePartnerID 
	)


	DELETE FROM pMaterialTradePartnerColor
	WHERE MaterialTradePartnerID = @MaterialTradePartnerID

	DELETE FROM dbo.pMaterialRequestSubmit 	WHERE MaterialTradePartnerID = @MaterialTradePartnerID 
	DELETE FROM dbo.pMaterialTradePartner WHERE MaterialTradePartnerID = @MaterialTradePartnerID 

	DELETE FROM pMaterialRequestSubmitWorkflow WHERE MaterialTradePartnerID = @MaterialTradePartnerID






GO