IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneTemplate_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneTemplate_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_CalendarMilestoneTemplate_INSERT]
	@CalendarHeaderID UNIQUEIDENTIFIER,
	@MilestoneTemplateID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME 
AS
BEGIN

DECLARE @StartDate AS DATETIME 
SELECT @StartDate = StartDate FROM  pCalendarHeader WHERE CalendarHeaderID = @CalendarHeaderID

INSERT INTO pCalendarMilestoneItem (CalendarMilestoneItemID,CalendarHeaderID,MilestoneTemplateItemID,
	CalendarMilestoneItemName, CalendarMilestoneItemDescription, DependentWorkflowTypeID,
	[Days], MilestoneDate, SortOrder, CUser, CDate, MUser, MDate)
SELECT 	NEWID(), @CalendarHeaderID, MilestoneTemplateItemID,
	MilestoneTemplateItemName, MilestoneTemplateItemDescription, DependentWorkflowTypeID,
	[Days], DATEADD(DAY, ISNULL([Days],0), @StartDate), SortOrder, @CUser, @CDate, @CUser, @CDate
FROM pMilestoneTemplateItem
WHERE MilestoneTemplateID = @MilestoneTemplateID
	

INSERT INTO pCalendarMilestoneItemWorkflow(CalendarMilestoneItemID, WorkflowID)
SELECT pCalendarMilestoneItem.CalendarMilestoneItemID, pMilestoneTemplateItemWorkflow.WorkflowID
FROM pCalendarMilestoneItem 
	INNER JOIN pMilestoneTemplateItem ON pCalendarMilestoneItem.MilestoneTemplateItemID = pMilestoneTemplateItem.MilestoneTemplateItemID
	INNER JOIN pMilestoneTemplateItemWorkflow ON pMilestoneTemplateItem.MilestoneTemplateItemID = pMilestoneTemplateItemWorkflow.MilestoneTemplateItemID
WHERE pCalendarMilestoneItem.CalendarHeaderID = @CalendarHeaderID


INSERT INTO pCalendarMilestoneItemWorkflowStatus(CalendarMilestoneItemID, WorkflowStatusID)
SELECT cmi.CalendarMilestoneItemID, mtiws.WorkflowStatusID
FROM pCalendarMilestoneItem cmi	
	INNER JOIN pMilestoneTemplateItemWorkflowStatus mtiws ON cmi.MilestoneTemplateItemID = mtiws.MilestoneTemplateitemID
WHERE cmi.CalendarHeaderID = @CalendarHeaderID

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05501', GetDate())
GO
