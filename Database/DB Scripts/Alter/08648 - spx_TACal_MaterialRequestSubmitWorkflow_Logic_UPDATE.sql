IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACal_MaterialRequestSubmitWorkflow_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACal_MaterialRequestSubmitWorkflow_Logic_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_TACal_MaterialRequestSubmitWorkflow_Logic_UPDATE] (
	@MaterialRequestSubmitWorkflowID UNIQUEIDENTIFIER,
	@TACalRefTaskId UNIQUEIDENTIFIER
)
AS 

-- update RevisedStart and RevisedEnd in calendar references table 
IF @TACalRefTaskId IS NOT NULL
BEGIN
	UPDATE pTACalReferenceTask 
	SET TaskRevisedlStart = pMaterialRequestSubmitWorkflow.RevisedStart, 
		TaskRevisedEnd = pMaterialRequestSubmitWorkflow.RevisedEnd
	FROM pMaterialRequestSubmitWorkflow
	WHERE pMaterialRequestSubmitWorkflow.MaterialRequestSubmitWorkflowID = @MaterialRequestSubmitWorkflowID
		AND pTACalReferenceTask.TACalRefTaskId = @TACalRefTaskId	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08648', GetDate())
GO
