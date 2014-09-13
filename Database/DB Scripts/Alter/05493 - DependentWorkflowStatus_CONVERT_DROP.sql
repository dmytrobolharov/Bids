if EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMilestoneTemplateItem' AND COLUMN_NAME = 'DependentWorkflowStatusID')
begin
	INSERT INTO pMilestoneTemplateItemWorkflowStatus(MilestoneTemplateitemID, WorkflowStatusID)
	SELECT MilestoneTemplateItemID, DependentWorkflowStatusID from pMilestoneTemplateItem
	ALTER TABLE pMilestoneTemplateItem DROP COLUMN DependentWorkflowStatusID
end
GO

if EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pCalendarMilestoneItem' AND COLUMN_NAME = 'DependentWorkflowStatusID')
begin
	INSERT INTO pCalendarMilestoneItemWorkflowStatus(CalendarMilestoneItemID, WorkflowStatusID)
	SELECT CalendarMilestoneItemID, DependentWorkflowStatusID from pCalendarMilestoneItem
	ALTER TABLE pCalendarMilestoneItem DROP COLUMN DependentWorkflowStatusID
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05493', GetDate())
GO
