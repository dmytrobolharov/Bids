-- make Artwork workflow to work Seasonal
UPDATE Mapping SET IsSeasonal = 1 WHERE Map = '40000000-0000-0000-0000-000000000010'
GO

-- duplicate seasonal workflows for all seasons in style
INSERT INTO pStyleWorkflow(
	StyleWorkflowID, StyleWorkflowMasterID, StyleID, StyleSet, 
	WorkflowID, WorkflowType, WorkflowOrder, WorkDay, WorkDate, WorkStart, WorkDue,
	WorkAssignedTo, WorkComplete, WorkStatus, WorkStatusDate, WorkStatusBy, WorkVersion, WorkComments, WorkSort,
	CUser, CDate, MUser, MDate, ActualCompletedDate, WorkflowTemplateID, WorkflowTemplateItemID,
	PlannedStartDate, PlannedDueDate, PlannedWorkDays, 
	WorkflowAssignedTo, WorkEscalateTo, WorkflowAlerts, WorkflowAccessTypeID, WorkflowAccessTypeDesc,
	StyleSeasonYearID)
SELECT NEWID(), sw.StyleWorkflowMasterID, sw.StyleID, sw.StyleSet, 
	sw.WorkflowID, sw.WorkflowType, sw.WorkflowOrder, sw.WorkDay, sw.WorkDate, sw.WorkStart, sw.WorkDue,
	sw.WorkAssignedTo, sw.WorkComplete, sw.WorkStatus, sw.WorkStatusDate, sw.WorkStatusBy, sw.WorkVersion, sw.WorkComments, sw.WorkSort,
	sw.CUser, sw.CDate, sw.MUser, sw.MDate, sw.ActualCompletedDate, sw.WorkflowTemplateID, sw.WorkflowTemplateItemID,
	sw.PlannedStartDate, sw.PlannedDueDate, sw.PlannedWorkDays, 
	sw.WorkflowAssignedTo, sw.WorkEscalateTo, sw.WorkflowAlerts, sw.WorkflowAccessTypeID, sw.WorkflowAccessTypeDesc,
	ssy.StyleSeasonYearID
FROM pStyleWorkflow sw
INNER JOIN Mapping m ON sw.WorkflowID = m.Map
INNER JOIN pStyleSeasonYear ssy ON sw.StyleID = ssy.StyleID
WHERE m.Map = '40000000-0000-0000-0000-000000000010' AND m.IsSeasonal = 1
ORDER BY sw.StyleID, WorkflowID

-- remove original seasonal workflows
DELETE FROM pStyleWorkflow 
WHERE StyleWorkflowID IN (
	SELECT StyleWorkflowID FROM pStyleWorkflow sw
	INNER JOIN Mapping m ON sw.WorkflowID = m.Map
	WHERE m.Map = '40000000-0000-0000-0000-000000000010' AND m.IsSeasonal = 1 AND sw.StyleSeasonYearID IS NULL
)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06755', GetDate())
GO
