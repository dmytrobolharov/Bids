UPDATE pMaterialRequestWorkflow SET GroupID = 0 WHERE GroupID IS NULL
GO
UPDATE pMaterialRequestWorkflow SET MaterialRequestWorkflowControlSchema = 'Control_MaterialRequestWorkflowItem_Default.xml' WHERE MaterialRequestWorkflowControlSchema IS NULL
GO
UPDATE pMaterialRequestWorkflow SET MaterialRequestSubmitHeaderPrintSchema = 'Material_TradePartnerVendor_Print_SchemaHeader.xml'  WHERE MaterialRequestSubmitHeaderPrintSchema IS NULL
GO
UPDATE pMaterialRequestWorkflow SET MaterialRequestSubmitBodyPrintSchema = MaterialRequestWorkflowSchema  WHERE MaterialRequestSubmitBodyPrintSchema IS NULL
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01984'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01984', GetDate())

END

GO



	
	
	