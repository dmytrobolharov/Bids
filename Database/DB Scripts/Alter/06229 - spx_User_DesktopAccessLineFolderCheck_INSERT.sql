IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DesktopAccessLineFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_DesktopAccessLineFolderCheck_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_User_DesktopAccessLineFolderCheck_INSERT] (
@TeamId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

IF (SELECT COUNT(*) FROM sAccessLineFolder WITH (NOLOCK) WHERE TeamId = @TeamId) = 0
	BEGIN
			Declare @LineTypeId uniqueidentifier
	SELECT TOP 1 @LineTypeId = LineListTypeID FROM pLineListType
		INSERT INTO sAccessLineFolder
			(LineTypeId, TeamId, CUser, CDate, MUser, MDate)
		VALUES (@LineTypeId, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate) 
	END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '06229', GetDate())
GO