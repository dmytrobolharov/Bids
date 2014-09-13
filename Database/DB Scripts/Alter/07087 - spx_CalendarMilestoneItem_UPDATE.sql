IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_CalendarMilestoneItem_UPDATE]
	@CalendarMilestoneItemID UNIQUEIDENTIFIER,
	@WorkflowIDs nVARCHAR(MAX),
	@WorkflowStatusIDs nVARCHAR(MAX),
	@UpdateSql NVARCHAR(MAX)
AS
BEGIN
	
	exec(@UpdateSql)
	
	DECLARE @StartDate AS DATETIME 
	SELECT @StartDate = StartDate FROM pCalendarHeader 
	INNER JOIN pCalendarMilestoneItem ON pCalendarHeader.CalendarHeaderID = pCalendarMilestoneItem.CalendarHeaderID
	WHERE pCalendarMilestoneItem.CalendarMilestoneItemID = @CalendarMilestoneItemID

	UPDATE pCalendarMilestoneItem 
	SET MilestoneDate = CASE WHEN DependentWorkflowTypeID <> '00000000-0000-0000-0000-000000000000' 
		THEN DATEADD(DAY, ISNULL([Days],0), @StartDate)
		ELSE MilestoneDate END
	WHERE CalendarMilestoneItemID = @CalendarMilestoneItemID
	
	-- empty item
	if EXISTS(SELECT * FROM pCalendarMilestoneItem WHERE CalendarMilestoneItemID = @CalendarMilestoneItemID AND ISNULL(CalendarMilestoneItemName, '') = '')
	begin
		exec spx_CalendarMilestoneItem_REMOVE @CalendarMilestoneItemID
	end
	else
	begin	
		-- update workflows
		DELETE FROM pCalendarMilestoneItemWorkflow WHERE CalendarMilestoneItemID = @CalendarMilestoneItemID		
		INSERT INTO pCalendarMilestoneItemWorkflow (CalendarMilestoneItemID, WorkflowID)
		SELECT @CalendarMilestoneItemID, value FROM dbo.fnx_Split(@WorkflowIDs, ',')
		
		-- update workflow statuses
		DELETE FROM pCalendarMilestoneItemWorkflowStatus WHERE CalendarMilestoneItemID =@CalendarMilestoneItemID
		INSERT INTO pCalendarMilestoneItemWorkflowStatus (CalendarMilestoneItemID, WorkflowStatusID)
		SELECT @CalendarMilestoneItemID, value FROM dbo.fnx_Split(@WorkflowStatusIDs, ',')
	end
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07087', GetDate())
GO
