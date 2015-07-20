
/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]    Script Date: 10/03/2012 11:53:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT]    Script Date: 10/03/2012 11:53:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_MaterialRequestSubmitWorkflowTreeWithColors_SELECT](@MaterialTradePartnerColorID uniqueidentifier)
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
ORDER BY pMaterialRequestWorkflow.MaterialRequestWorkflowSort


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04084', GetDate())
GO