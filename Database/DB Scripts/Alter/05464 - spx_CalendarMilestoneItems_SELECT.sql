IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarMilestoneItems_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarMilestoneItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_CalendarMilestoneItems_SELECT]
	@CalendarHeaderID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT * FROM pCalendarMilestoneItem WHERE CalendarHeaderID = @CalendarHeaderID ORDER BY SortOrder
	
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05464', GetDate())
GO
