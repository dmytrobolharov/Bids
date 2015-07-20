/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]    Script Date: 01/23/2013 17:05:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]    Script Date: 01/23/2013 17:05:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
	
	DELETE pMaterialRequestSubmitWorkflowShare
	FROM pMaterialRequestSubmitWorkflowShare share
	INNER JOIN pMaterialRequestSubmitWorkflow wf ON share.MaterialRequestSubmitWorkflowID = wf.MaterialRequestSubmitWorkflowID
	AND wf.MaterialTradePartnerID = @MaterialTradePartnerID
	
	DELETE FROM pMaterialRequestSubmitWorkflow WHERE MaterialTradePartnerID = @MaterialTradePartnerID

	DELETE FROM pMaterialTradePartnerShare WHERE MaterialTradePartnerID = @MaterialTradePartnerID
	
	



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04865', GetDate())
GO

