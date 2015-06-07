IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskSide_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskSide_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_DeskSide_SELECT]    Script Date: 12/15/2014 17:10:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskSide_SELECT]
(@TeamId uniqueidentifier)
AS 

if not exists (select * from dbo.sysobjects where id = object_id(N'#DeskSide') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE #DeskSide (
	[DeskSideID] [int] NOT NULL ,
	[DeskFolderId] [int] NULL ,
	[DeskSideName] [nvarchar] (200) NULL ,
	[DeskSideDescription] [nvarchar] (2000) NULL ,
	[DeskSideWindow] [nvarchar] (200) NULL ,
	[DeskSideURL] [nvarchar] (50) NULL ,
	[DeskSideIcon] [nvarchar] (50) NULL ,
	[DeskSideSort] [nvarchar] (4) NULL ,
	[DeskSideActive] [int] NOT NULL 
) ON [PRIMARY]
END

BEGIN
	INSERT INTO #DeskSide
	(DeskSideID, DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive)
	SELECT DeskSideID, DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive
	FROM  cDeskSide WITH (NOLOCK)
	WHERE (DeskSideActive = 1) AND (DeskFolderId IN (SELECT PermissionFolderTypeId FROM sPermissionFolder WITH (NOLOCK) INNER JOIN uUserGroup ON sPermissionFolder.GroupId = uUserGroup.GroupID WHERE uUserGroup.TeamId = @TeamId AND PermissionFolderNotLocked = 1))

	--WHERE (DeskSideActive = 1) AND (DeskFolderId IN (SELECT DeskFolderId FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamId = @TeamId AND DeskAccessId = 1))
END

IF (SELECT COUNT(*) FROM Users WITH (NOLOCK) WHERE TeamId = @TeamId AND Admin = 1) = 1
BEGIN
	INSERT INTO #DeskSide
	(DeskSideID, DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive)
	SELECT TOP 1 DeskSideID, DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive
	FROM  cDeskSide WITH (NOLOCK)
	WHERE (DeskSideActive = 1) AND (DeskFolderId = 100)
END

SELECT DeskSideID, DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive
FROM #DeskSide

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09195', GetDate())
GO


