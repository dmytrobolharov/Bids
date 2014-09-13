/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessSourcingFolderCheck_INSERT]    Script Date: 08/23/2013 16:06:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessSourcingFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessSourcingFolderCheck_INSERT]
GO
/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessSourcingFolderCheck_INSERT]    Script Date: 08/23/2013 16:06:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessSourcingFolderCheck_INSERT] (
@GroupID  uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

IF (SELECT COUNT(*) FROM sAccessGroupSourcingFolder WITH (NOLOCK) WHERE  GroupID  = @GroupID ) = 0
	BEGIN
	Declare @SourcingTypeID uniqueidentifier
	SELECT TOP 1 @SourcingTypeID = SourcingTypeId FROM pSourcingType
		INSERT INTO sAccessGroupSourcingFolder
			(SourcingTypeId, GroupID, CUser, CDate, MUser, MDate)
		VALUES (@SourcingTypeID, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate) 
	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06223', GetDate())
GO
