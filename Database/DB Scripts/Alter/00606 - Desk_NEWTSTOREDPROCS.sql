

/****** Object:  StoredProcedure [dbo].[spx_DashFolderItem_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DashFolderItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DashFolderItem_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskFolder_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskFolder_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskMain_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskMain_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskMain_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskSide_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskSide_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskSide_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTop_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTop_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECTED]    Script Date: 10/15/2010 10:52:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTop_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTop_SELECTED]
GO



/****** Object:  StoredProcedure [dbo].[spx_DashFolderItem_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DashFolderItem_SELECT](@DashFolderItemID uniqueidentifier)
AS 

SELECT DashFolderItemID, DashFolderID, DashFolderItemName, DashFolderItemUrl, 
	DashFolderItemIcon, DashFolderItemSort, DashFolderItemActive, 
	DashFolderItemServerUrl, DashFolderItemServerFolderName, DashFolderItemServerReportName
FROM         rDashFolderItem
WHERE DashFolderItemID = @DashFolderItemID
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskFolder_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskFolder_SELECT]
AS 

BEGIN
	SELECT DeskFolderId, DeskFolderName FROM cDesktopFolder
END




GO

/****** Object:  StoredProcedure [dbo].[spx_DeskMain_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskMain_SELECT](
@TeamID uniqueidentifier
)
AS 

SELECT  a.DeskID, a.DeskName, a.DeskDescription, a.DeskIcon, a.DeskSort  
FROM  cDesktop a INNER JOIN cDeskUserFolderAccess b ON a.DeskID = b.DeskFolderID   
INNER JOIN cDesktopFolder c ON b.DeskFolderId = c.DeskFolderId 
WHERE b.TeamId = @TeamID AND b.DeskAccessID = 1  AND a.DeskActive = 1 
ORDER BY a.DeskSort, c.DeskFolderId 


GO

/****** Object:  StoredProcedure [dbo].[spx_DeskSide_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
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
	[DeskSideName] [varchar] (200) NULL ,
	[DeskSideDescription] [varchar] (2000) NULL ,
	[DeskSideWindow] [varchar] (200) NULL ,
	[DeskSideURL] [varchar] (50) NULL ,
	[DeskSideIcon] [varchar] (50) NULL ,
	[DeskSideSort] [varchar] (4) NULL ,
	[DeskSideActive] [int] NOT NULL 
) ON [PRIMARY]
END

BEGIN
	INSERT INTO #DeskSide
	(DeskSideID, DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive)
	SELECT DeskSideID, DeskFolderId, DeskSideName, DeskSideDescription, DeskSideWindow, DeskSideURL, DeskSideIcon, DeskSideSort, DeskSideActive
	FROM  cDeskSide WITH (NOLOCK)
	WHERE (DeskSideActive = 1) AND (DeskFolderId IN (SELECT DeskFolderId FROM cDeskUserFolderAccess WITH (NOLOCK) WHERE TeamId = @TeamId AND DeskAccessId = 1))
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

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 10/15/2010 10:52:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_DeskTop_SELECT](@TeamID uniqueidentifier)
AS 

SELECT DeskTopID, DeskName, DeskDescription, DeskIcon, 
	DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, 
	DeskSort, DeskActive
FROM  sDeskTop
WHERE DeskActive = 1 ORDER BY DeskSort

GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECTED]    Script Date: 10/15/2010 10:52:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_DeskTop_SELECTED](@TeamID uniqueidentifier, @DeskTopID int)
AS 

SELECT DeskTopID, DeskName, DeskDescription, DeskIcon, 
	DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, 
	DeskSort, DeskActive
FROM  sDeskTop
WHERE DeskTopID = @DeskTopID  


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '606', GetDate())
GO