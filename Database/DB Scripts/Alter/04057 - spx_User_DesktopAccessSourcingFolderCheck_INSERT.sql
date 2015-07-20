IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DesktopAccessSourcingFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_DesktopAccessSourcingFolderCheck_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_User_DesktopAccessSourcingFolderCheck_INSERT] (
@TeamId uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

IF (SELECT COUNT(*) FROM sAccessSourcingFolder WITH (NOLOCK) WHERE SourcingTypeId = 1 AND TeamId = @TeamId) = 0
	BEGIN
		INSERT INTO sAccessSourcingFolder
			(SourcingTypeId, TeamId, CUser, CDate, MUser, MDate)
		VALUES (1, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate) 
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04057', GetDate())

GO

