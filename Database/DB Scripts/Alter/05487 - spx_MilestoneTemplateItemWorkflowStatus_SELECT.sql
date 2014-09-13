/****** Object:  StoredProcedure [dbo].[spx_MilestoneTemplateItemWorkflowStatus_SELECT]    Script Date: 04/04/2013 11:41:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MilestoneTemplateItemWorkflowStatus_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MilestoneTemplateItemWorkflowStatus_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_MilestoneTemplateItemWorkflowStatus_SELECT]
	@MilestoneTemplateItemID UNIQUEIDENTIFIER,
	@WorkflowTypeID UNIQUEIDENTIFIER
AS
BEGIN
	
	SELECT *, CASE WHEN mtiws.WorkflowStatusID IS NULL THEN 'False' ELSE 'True' END AS Checked
	FROM vwx_WorkflowStatus_ByType_SEL vws
	LEFT JOIN pMilestoneTemplateItemWorkflowStatus mtiws 
		ON vws.StatusID = mtiws.WorkflowStatusID AND mtiws.MilestoneTemplateitemID = @MilestoneTemplateItemID
	WHERE WorkflowTypeID = @WorkflowTypeID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05487', GetDate())
GO
