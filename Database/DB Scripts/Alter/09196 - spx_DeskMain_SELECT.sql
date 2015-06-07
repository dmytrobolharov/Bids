IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskMain_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskMain_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_DeskMain_SELECT]    Script Date: 12/15/2014 16:49:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskMain_SELECT](
@TeamID uniqueidentifier
)
AS 

SELECT  a.DeskID, a.DeskName, a.DeskDescription, a.DeskIcon, a.DeskSort  
FROM  cDesktop a INNER JOIN dbo.sPermissionFolder b ON a.DeskID = b.PermissionFolderTypeId
INNER JOIN dbo.uUserGroup as e ON e.GroupID = b.GroupId
INNER JOIN cDesktopFolder c ON b.PermissionFolderTypeId = c.DeskFolderId 
WHERE e.TeamId = @TeamID AND b.PermissionFolderNotLocked = 1  AND a.DeskActive = 1 
ORDER BY a.DeskSort, c.DeskFolderId 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09196', GetDate())
GO