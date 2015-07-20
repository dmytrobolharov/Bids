IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneItem_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneItem_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_CalendarMilestoneItem_UPDATE]
	@CalendarMilestoneItemID UNIQUEIDENTIFIER,
	@WorkflowIDs VARCHAR(MAX),
	@UpdateSql NVARCHAR(MAX)
AS
BEGIN
	
	exec(@UpdateSql)
	
	-- empty item
	if EXISTS(SELECT * FROM pCalendarMilestoneItem WHERE CalendarMilestoneItemID = @CalendarMilestoneItemID AND ISNULL(CalendarMilestoneItemName, '') = '')
	begin
		exec spx_CalendarMilestoneItem_REMOVE @CalendarMilestoneItemID
	end
	else
	begin	
		DELETE FROM pCalendarMilestoneItemWorkflow WHERE CalendarMilestoneItemID = @CalendarMilestoneItemID
		
		INSERT INTO pCalendarMilestoneItemWorkflow (CalendarMilestoneItemID, WorkflowID)
		SELECT @CalendarMilestoneItemID, value FROM dbo.fnx_Split(@WorkflowIDs, ',')
	end
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05468', GetDate())
GO
