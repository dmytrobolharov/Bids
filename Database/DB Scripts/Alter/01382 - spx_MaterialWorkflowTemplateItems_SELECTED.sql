IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].spx_MaterialWorkflowTemplateItems_SELECTED') AND type = N'P' )
	DROP PROCEDURE [dbo].spx_MaterialWorkflowTemplateItems_SELECTED
GO


CREATE PROCEDURE dbo.spx_MaterialWorkflowTemplateItems_SELECTED(
	@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER
)
AS

	SELECT b.MaterialRequestWorkflowID, b.MaterialRequestWorkflow 
    FROM pMaterialRequestWorkflowTemplateItem a WITH(NOLOCK)
		INNER JOIN pMaterialRequestWorkflow b WITH(NOLOCK) ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID 
    WHERE a.MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
    ORDER BY b.MaterialRequestWorkflowSort 
	

GO	

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01382', GETDATE())
GO	