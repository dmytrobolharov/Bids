/****** Object:  StoredProcedure [dbo].[spx_CalendarMilestoneItem_UPDATE]    Script Date: 04/04/2013 12:03:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneItem_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_CalendarMilestoneItem_UPDATE]
	@CalendarMilestoneItemID UNIQUEIDENTIFIER,
	@WorkflowIDs VARCHAR(MAX),
	@WorkflowStatusIDs VARCHAR(MAX),
	@UpdateSql NVARCHAR(MAX)
AS
BEGIN
	
	exec(@UpdateSql)
	
	DECLARE @StartDate AS DATETIME 
	SELECT @StartDate = StartDate FROM pCalendarHeader 
	INNER JOIN pCalendarMilestoneItem ON pCalendarHeader.CalendarHeaderID = pCalendarMilestoneItem.CalendarHeaderID
	WHERE pCalendarMilestoneItem.CalendarMilestoneItemID = @CalendarMilestoneItemID

	UPDATE pCalendarMilestoneItem SET MilestoneDate = DATEADD(DAY, ISNULL([Days],0), @StartDate)
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
VALUES     ('DB_Version', '0.5.0000', '05491', GetDate())
GO
