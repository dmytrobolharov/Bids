UPDATE pWorkFlowItem SET 
WorkStart = (
	SELECT workstart FROM pStyleWorkflow a 
	WHERE pWorkFlowItem.WorkflowID = a.WorkflowID and pWorkFlowItem.StyleID = a.StyleID and pWorkFlowItem.StyleSet = a.StyleSet
),
WorkDue = (
	SELECT WorkDue FROM pStyleWorkflow a 
	WHERE pWorkFlowItem.WorkflowID = a.WorkflowID and pWorkFlowItem.StyleID = a.StyleID and pWorkFlowItem.StyleSet = a.StyleSet
),
WorkAssignedTo = (
	SELECT WorkAssignedTo FROM pStyleWorkflow a 
	WHERE pWorkFlowItem.WorkflowID = a.WorkflowID and pWorkFlowItem.StyleID = a.StyleID and pWorkFlowItem.StyleSet = a.StyleSet
),
WorkStatus = (
	SELECT WorkStatus FROM pStyleWorkflow a 
	WHERE pWorkFlowItem.WorkflowID = a.WorkflowID and pWorkFlowItem.StyleID = a.StyleID and pWorkFlowItem.StyleSet = a.StyleSet
),
WorkEscalateTo = (
	SELECT WorkEscalateTo FROM pStyleWorkflow a 
    WHERE pWorkFlowItem.WorkflowID = a.WorkflowID and pWorkFlowItem.StyleID = a.StyleID and pWorkFlowItem.StyleSet = a.StyleSet
)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03855', GetDate())
GO