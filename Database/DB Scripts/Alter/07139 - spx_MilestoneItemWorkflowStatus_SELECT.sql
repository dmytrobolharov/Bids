IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneItemWorkflowStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneItemWorkflowStatus_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MilestoneItemWorkflowStatus_SELECT]
	@MilestoneItemID UNIQUEIDENTIFIER,
	@WorkflowTypeID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT *, CASE WHEN mtiws.WorkflowStatusID IS NULL THEN 'False' ELSE 'True' END AS Checked
	FROM vwx_WorkflowStatus_ByType_SEL vws
	LEFT JOIN pMilestoneItemWorkflowStatus mtiws 
		ON vws.StatusID = mtiws.WorkflowStatusID AND mtiws.MilestoneItemID = @MilestoneItemID
	WHERE WorkflowTypeID = @WorkflowTypeID
	
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07139', GetDate())
GO
