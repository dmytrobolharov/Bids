IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_MaterialRequestSubmit_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[rpx_MaterialRequestSubmit_SELECT]
GO


CREATE PROCEDURE [dbo].[rpx_MaterialRequestSubmit_SELECT]
(
	@MaterialRequestSubmitID uniqueidentifier
)
AS 


SELECT pMaterialRequestSubmit.MaterialRequestSubmitID, pMaterialRequestSubmit.MaterialRequestSubmitWorkflowID, 
  pMaterialRequestSubmit.MaterialTradePartnerColorID, pMaterialRequestSubmit.MaterialTradePartnerID, 
  pMaterialRequestSubmit.MaterialRequestSubmitGroupID, pMaterialRequestSubmit.Submit, pMaterialRequestSubmit.AssignedTo, 
  pMaterialRequestSubmit.StartDate, pMaterialRequestSubmit.RecDate, pMaterialRequestSubmit.RecBy, pMaterialRequestSubmit.RecCarrier, 
  pMaterialRequestSubmit.RecTrackNo, pMaterialRequestSubmit.RecWeight, pMaterialRequestSubmit.VendorWeight, 
  pMaterialRequestSubmit.VendorDate, pMaterialRequestSubmit.VendorName, pMaterialRequestSubmit.SubmitDays, 
  pMaterialRequestSubmit.ResubmitDays, CONVERT(NVARCHAR(10), pMaterialRequestSubmitWorkflow.DueDate, 101) AS DueDate, pMaterialRequestSubmit.RevDate, pMaterialRequestSubmit.RevBy, 
  pMaterialRequestSubmit.EndDate, pMaterialRequestSubmit.EndBy, pMaterialRequestSubmit.CUser, pMaterialRequestSubmit.CDate, 
  pMaterialRequestSubmit.MUser, pMaterialRequestSubmit.MDate, pMaterialRequestSubmit.TUser, pMaterialRequestSubmit.TDate, 
  pMaterialRequestSubmit.AgentView, pMaterialRequestSubmit.SubmitComment, pMaterialRequestSubmit.VendorComment, 
  pMaterialRequestSubmit.InternalComment, pMaterialRequestSubmitStatus.Status
FROM pMaterialRequestSubmit
		INNER JOIN pMaterialRequestSubmitStatus ON	pMaterialRequestSubmit.Status = pMaterialRequestSubmitStatus.StatusID
		INNER JOIN pMaterialRequestSubmitWorkflow ON	pMaterialRequestSubmit.MaterialRequestSubmitWorkflowId = pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowId
WHERE pMaterialRequestSubmit.MaterialRequestSubmitID = @MaterialRequestSubmitID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.1.0000', '01530', GetDate())
GO