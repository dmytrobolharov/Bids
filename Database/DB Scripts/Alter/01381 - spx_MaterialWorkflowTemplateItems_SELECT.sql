IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowTemplateItems_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialWorkflowTemplateItems_SELECT]
GO


CREATE PROCEDURE dbo.spx_MaterialWorkflowTemplateItems_SELECT(
	@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER
)
AS


	SELECT MaterialRequestWorkflowID, MaterialRequestWorkflow 
	FROM pMaterialRequestWorkflow WITH(NOLOCK)
	WHERE MaterialRequestWorkflowID NOT IN (
		SELECT MaterialRequestWorkflowID 
		FROM pMaterialRequestWorkflowTemplateItem WITH(NOLOCK)
		WHERE MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
		) 
	ORDER BY MaterialRequestWorkflowSort
	

GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01381', GETDATE())
GO	