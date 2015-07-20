IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECTED]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowViewSubmitAvailable_SELECTED]
(@TeamId uniqueidentifier)
AS

SELECT MaterialRequestWorkflowID, MaterialRequestWorkflow 
FROM pMaterialRequestWorkflow WITH(NOLOCK)
WHERE 
(
	MaterialRequestWorkflowID  IN 
	(
		SELECT SampleWorkflowId FROM  pMaterialSampleWorkflowViewSubmit WITH (NOLOCK) WHERE TeamId =@TeamId
	)
)
AND Active = 1
ORDER BY MaterialRequestWorkflowSort

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09059', GetDate())
GO
