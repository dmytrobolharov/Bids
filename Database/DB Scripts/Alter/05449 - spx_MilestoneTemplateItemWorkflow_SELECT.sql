/****** Object:  StoredProcedure [dbo].[spx_MilestoneTemplateItemWorkflow_SELECT]    Script Date: 03/29/2013 16:32:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItemWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItemWorkflow_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItemWorkflow_SELECT]
	@MilestoneTemplateItemID UNIQUEIDENTIFIER,
	@WorkflowTypeID UNIQUEIDENTIFIER	
AS
BEGIN

	SELECT *, CASE WHEN tiw.WorkflowID IS NULL THEN 'False' ELSE 'True' END as Checked
	FROM vwx_MilestoneDependentWorkflows_SEL dw
	LEFT JOIN pMilestoneTemplateItemWorkflow tiw ON dw.WorkflowID = tiw.WorkflowID AND MilestoneTemplateItemID = @MilestoneTemplateItemID 
	WHERE WorkflowTypeID = @WorkflowTypeID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05449', GetDate())
GO
