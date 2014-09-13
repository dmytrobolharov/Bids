IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneItem_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneItem_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_CalendarMilestoneItem_REMOVE]
	@CalendarMilestoneItemID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pCalendarMilestoneItemWorkflow WHERE CalendarMilestoneItemID = @CalendarMilestoneItemID
	DELETE FROM pCalendarMilestoneItem WHERE CalendarMilestoneItemID = @CalendarMilestoneItemID
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05466', GetDate())
GO
