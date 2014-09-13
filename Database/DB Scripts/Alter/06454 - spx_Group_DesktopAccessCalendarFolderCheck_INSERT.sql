IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessCalendarFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessCalendarFolderCheck_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessCalendarFolderCheck_INSERT] (
@GroupID  uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

IF (SELECT COUNT(*) FROM sAccessGroupCalendarFolder WITH (NOLOCK) WHERE CalendarTypeId = 1 AND GroupID  = @GroupID ) = 0
	BEGIN
		INSERT INTO sAccessGroupCalendarFolder
			(CalendarTypeId, GroupID, CUser, CDate, MUser, MDate)
		VALUES (1, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate) 
	END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06454', GetDate())
GO
