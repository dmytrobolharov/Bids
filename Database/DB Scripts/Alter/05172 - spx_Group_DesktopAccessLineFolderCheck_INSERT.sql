/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessLineFolderCheck_INSERT]    Script Date: 02/26/2013 17:38:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessLineFolderCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessLineFolderCheck_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessLineFolderCheck_INSERT]    Script Date: 02/26/2013 17:38:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessLineFolderCheck_INSERT] (
@GroupID  uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

	INSERT INTO sAccessGroupLineFolder
		(LineTypeId, GroupID, CUser, CDate, MUser, MDate)
	SELECT LineListTypeID, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM pLineListType
	WHERE Active = 1
	AND LineListTypeID NOT IN (SELECT LineTypeID FROM sAccessGroupLineFolder WHERE GroupID = @GroupID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05172', GetDate())
GO
