IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneItemWorkflow_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneItemWorkflow_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_CalendarMilestoneItemWorkflow_SELECT]
	@CalendarMilestoneItemID UNIQUEIDENTIFIER,
	@WorkflowTypeID UNIQUEIDENTIFIER	
AS
BEGIN

	SELECT *, CASE WHEN ciw.WorkflowID IS NULL THEN 'False' ELSE 'True' END as Checked
	FROM vwx_MilestoneDependentWorkflows_SEL dw
	LEFT JOIN pCalendarMilestoneItemWorkflow ciw ON dw.WorkflowID = ciw.WorkflowID AND CalendarMilestoneItemID = @CalendarMilestoneItemID
	WHERE WorkflowTypeID = @WorkflowTypeID
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05467', GetDate())
GO
