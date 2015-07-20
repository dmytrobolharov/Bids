/****** Object:  StoredProcedure [dbo].[spx_CalendarLineList_INSERT]    Script Date: 04/03/2013 17:15:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CalendarLineList_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CalendarLineList_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_CalendarLineList_INSERT]
	@CalendarHeaderID UNIQUEIDENTIFIER,
	@LineFolderID UNIQUEIDENTIFIER
AS
BEGIN
	
	INSERT INTO pCalendarLineFolder(CalendarHeaderID, LineFolderID)
	VALUES (@CalendarHeaderID, @LineFolderID)
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05478', GetDate())
GO
