/****** Object:  StoredProcedure [dbo].[spx_User_DesktopAccessSourcingFolderCheck_INSERT]    Script Date: 08/23/2013 16:05:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DesktopAccessSourcingFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_DesktopAccessSourcingFolderCheck_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_User_DesktopAccessSourcingFolderCheck_INSERT]    Script Date: 08/23/2013 16:05:09 ******/
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

IF (SELECT COUNT(*) FROM sAccessSourcingFolder WITH (NOLOCK) WHERE  TeamId = @TeamId) = 0
	BEGIN
	Declare @SourcingTypeID uniqueidentifier
	SELECT TOP 1 @SourcingTypeID = SourcingTypeId FROM pSourcingType
		
		INSERT INTO sAccessSourcingFolder
			(SourcingTypeId, TeamId, CUser, CDate, MUser, MDate)
		VALUES (@SourcingTypeID, @TeamId, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate) 
	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06225', GetDate())
GO
