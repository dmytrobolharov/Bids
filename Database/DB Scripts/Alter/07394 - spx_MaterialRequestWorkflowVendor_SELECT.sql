IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestWorkflowVendor_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestWorkflowVendor_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MaterialRequestWorkflowVendor_SELECT] (
@MaterialTradePartnerId UNIQUEIDENTIFIER
)
AS 

IF (SELECT COUNT(DISTINCT MaterialRequestWorkflowTempID) FROM pMaterialTradePartner WHERE MaterialTradePartnerId = @MaterialTradePartnerId) > 1
BEGIN
	SELECT MaterialRequestWorkflowID, MaterialRequestWorkflow, GroupName, MaterialRequestWorkflowSort
	FROM  pMaterialRequestWorkflow WHERE MaterialRequestWorkflowID IN (SELECT MaterialRequestWorkflowID FROM
		pMaterialRequestSubmitWorkflow WHERE MaterialTradePartnerId = @MaterialTradePartnerId)
	ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort
END
ELSE
BEGIN
	DECLARE @MaterialRequestWorkflowTempID UNIQUEIDENTIFIER
	SELECT TOP 1 @MaterialRequestWorkflowTempID = MaterialRequestWorkflowTempID FROM pMaterialTradePartner WHERE MaterialTradePartnerId = @MaterialTradePartnerId 

	SELECT t.MaterialRequestWorkflowID, t.MaterialRequestWorkflow, t.GroupName, ISNULL(pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort, '99') AS MaterialRequestWorkflowSort 
	FROM 
	(SELECT MaterialRequestWorkflowID, MaterialRequestWorkflow, GroupName, MaterialRequestWorkflowSort
	FROM  pMaterialRequestWorkflow WHERE MaterialRequestWorkflowID IN (SELECT MaterialRequestWorkflowID FROM
		pMaterialRequestSubmitWorkflow WHERE MaterialTradePartnerId = @MaterialTradePartnerId)) t
			LEFT JOIN pMaterialRequestWorkflowTemplateItem ON MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
				AND t.MaterialRequestWorkflowID = pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowID
	ORDER BY ISNULL(pMaterialRequestWorkflowTemplateItem.MaterialRequestWorkflowSort, '99')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07394', GetDate())
GO
