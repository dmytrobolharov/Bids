/****** Object:  StoredProcedure [dbo].[spx_CalendarLineList_REMOVE]    Script Date: 04/03/2013 17:16:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarLineList_REMOVE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarLineList_REMOVE]
GO

CREATE PROCEDURE [dbo].[spx_CalendarLineList_REMOVE]
	@CalendarHeaderID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	DELETE FROM pCalendarLineFolder WHERE CalendarHeaderID = @CalendarHeaderID AND LineFolderID = @LineFolderID
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05479', GetDate())
GO
