

/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessPartnerFolderCheck_INSERT]    Script Date: 03/05/2013 17:16:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessPartnerFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessPartnerFolderCheck_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessPartnerFolderCheck_INSERT]    Script Date: 03/05/2013 17:16:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create PROCEDURE [dbo].[spx_Group_DesktopAccessPartnerFolderCheck_INSERT] (
@GroupID  uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

IF (SELECT COUNT(*) FROM sAccessGroupPartnerFolder WITH (NOLOCK) WHERE PartnerTypeId = 1 AND GroupID  = @GroupID ) = 0
	BEGIN
		INSERT INTO sAccessGroupPartnerFolder
			(PartnerTypeId, GroupID, CUser, CDate, MUser, MDate)
		VALUES (1, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate) 
	END


GO







INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05248', GetDate())
GO
