IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWorkflowStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWorkflowStatus_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialWorkflowStatus_SELECT]
(
@StyleMaterialID uniqueidentifier
)
AS 

BEGIN

	SELECT WorkStatus FROM pWorkFlowItem 
	INNER JOIN pStyleBOM ON pWorkFlowItem.WorkFlowItemID = pStyleBOM.WorkFlowItemID
	WHERE StyleMaterialID = @StyleMaterialID

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07575', GetDate())
GO