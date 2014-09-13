/****** Object:  StoredProcedure [dbo].[spx_CalendarMilestoneItemWorkflowStatus_SELECT]    Script Date: 04/04/2013 13:58:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneItemWorkflowStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneItemWorkflowStatus_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_CalendarMilestoneItemWorkflowStatus_SELECT]
	@CalendarMilestoneItemID UNIQUEIDENTIFIER,
	@WorkflowTypeID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT *, CASE WHEN cmiws.WorkflowStatusID IS NULL THEN 'False' ELSE 'True' END AS Checked
	FROM vwx_WorkflowStatus_ByType_SEL vws
	LEFT JOIN pCalendarMilestoneItemWorkflowStatus cmiws
		ON vws.StatusID = cmiws.WorkflowStatusID AND cmiws.CalendarMilestoneItemID = @CalendarMilestoneItemID
	WHERE WorkflowTypeID = @WorkflowTypeID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05490', GetDate())
GO
