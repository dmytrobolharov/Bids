IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT](
	@MaterialTradePartnerColorID UNIQUEIDENTIFIER
)    
AS     
    
DECLARE @MaterialTradePartnerID UNIQUEIDENTIFIER    
    
SELECT TOP 1 @MaterialTradePartnerID = MaterialTradePartnerID FROM pMaterialRequestSubmitWorkflow     
WHERE MaterialTradePartnerColorID = @MaterialTradePartnerColorID    
    
    
SELECT pMaterialTradePartnerColor.MaterialTradePartnerColorID, pMaterialTradePartnerColor.ColorCode, pMaterialRequestSubmit.MaterialRequestSubmitID,     
  pMaterialTradePartnerColor.ColorNo, pMaterialTradePartnerColor.ColorName, pMaterialTradePartnerColor.VendorColorCode,     
  pMaterialTradePartnerColor.VendorColorNo, pMaterialTradePartnerColor.VendorColorName, pMaterialRequestWorkflow.MaterialRequestWorkflowID,     
  pMaterialRequestWorkflow.GroupName, pMaterialRequestWorkflow.GroupID, pMaterialRequestSubmitStatus.Status,     
  pMaterialRequestSubmitWorkflow.Submit, pMaterialRequestSubmitWorkflow.DueDate, pMaterialRequestSubmitWorkflow.EndDate,     
  pMaterialRequestWorkflow.MaterialRequestWorkflow, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID,     
  pMaterialRequestWorkflow.MaterialRequestWorkflowSort, pMaterialTradePartnerColor.MaterialID,     
     '../System/Icons/' + pMaterialRequestSubmitStatus.StatusIcon AS Icon,   
 pMaterialRequestSubmitWorkflow.MaterialTradePartnerID, pMaterialRequestWorkflow.MaterialRequestWorkflowColor, pMaterialTradePartnerColor.ColorFolderID, pMaterialTradePartnerColor.ColorPaletteID,    
 pMaterialTradePartnerColor.MaterialColorImageID, pMaterialTradePartnerColor.MaterialColorImageVersion, pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors    
FROM pMaterialRequestSubmitStatus INNER JOIN    
  pMaterialRequestWorkflow INNER JOIN    
  pMaterialRequestSubmitWorkflow ON     
  pMaterialRequestWorkflow.MaterialRequestWorkflowID = pMaterialRequestSubmitWorkflow.MaterialRequestWorkflowID ON     
  pMaterialRequestSubmitStatus.StatusID = pMaterialRequestSubmitWorkflow.Status INNER JOIN    
  pMaterialTradePartnerColor ON     
  pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = pMaterialTradePartnerColor.MaterialTradePartnerColorID INNER JOIN    
  pMaterialRequestSubmit ON     
  pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID    
WHERE pMaterialRequestSubmitWorkflow.MaterialTradePartnerColorID = @MaterialTradePartnerColorID AND pMaterialRequestSubmitWorkflow.MaterialRequestSubmitAllColors = 0    
AND pMaterialRequestSubmitWorkflow.Active = 1     
ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort,  pMaterialRequestWorkflow.MaterialRequestWorkflow
    
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01268', GetDate())
GO
