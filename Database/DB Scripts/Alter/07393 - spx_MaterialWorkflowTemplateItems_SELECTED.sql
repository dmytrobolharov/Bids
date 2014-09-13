IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowTemplateItems_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowTemplateItems_SELECTED]
GO


CREATE PROCEDURE [dbo].[spx_MaterialWorkflowTemplateItems_SELECTED](
	@MaterialRequestWorkflowTempID UNIQUEIDENTIFIER
)
AS

	SELECT b.MaterialRequestWorkflowID, b.MaterialRequestWorkflow 
    FROM pMaterialRequestWorkflowTemplateItem a WITH(NOLOCK)
		INNER JOIN pMaterialRequestWorkflow b WITH(NOLOCK) ON a.MaterialRequestWorkflowID = b.MaterialRequestWorkflowID 
    WHERE a.MaterialRequestWorkflowTempID = @MaterialRequestWorkflowTempID
    ORDER BY a.MaterialRequestWorkflowSort 

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07393', GetDate())
GO
