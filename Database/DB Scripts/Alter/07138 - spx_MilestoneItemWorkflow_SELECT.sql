IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneItemWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneItemWorkflow_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneItemWorkflow_SELECT]
	@MilestoneItemID UNIQUEIDENTIFIER,
	@WorkflowTypeID UNIQUEIDENTIFIER	
AS
BEGIN

	SELECT *, CASE WHEN tiw.WorkflowID IS NULL THEN 'False' ELSE 'True' END as Checked
	FROM vwx_MilestoneDependentWorkflows_SEL dw
	LEFT JOIN pMilestoneItemWorkflow tiw ON dw.WorkflowID = tiw.WorkflowID AND MilestoneItemID = @MilestoneItemID 
	WHERE WorkflowTypeID = @WorkflowTypeID
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07138', GetDate())
GO
