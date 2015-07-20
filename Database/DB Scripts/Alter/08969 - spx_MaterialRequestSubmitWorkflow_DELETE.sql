/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]    Script Date: 08/22/2014 16:20:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE]    Script Date: 08/22/2014 16:20:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflow_DELETE](
@MaterialTradePartnerID UNIQUEIDENTIFIER 
)
AS 
BEGIN
	
	-- Breaking the connections between all the calendars
	DECLARE @TACalTemplateID UNIQUEIDENTIFIER
	
	DECLARE CalendarsCursor CURSOR SCROLL FOR
	SELECT TACalTemplateID FROM pTACalReference 
	WHERE ReferenceId = @MaterialTradePartnerID AND TACalReferenceTypeId = 24
	
	OPEN CalendarsCursor
	FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC spx_TACalReference_DELETE @TACalTemplateID, @MaterialTradePartnerID
		FETCH NEXT FROM CalendarsCursor INTO @TACalTemplateID
	END
	CLOSE CalendarsCursor
	DEALLOCATE CalendarsCursor

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
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08969', GetDate())
GO
