/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 06/20/2014 18:39:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTop_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTop_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 06/20/2014 18:39:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_DeskTop_SELECT](@TeamID uniqueidentifier)
AS 

SELECT  
	1000 'DeskAccessId',
	1001 'DeskFolderID',
	a.DeskTopID, 
	a.DeskName, 
	a.DeskDescription, 
	a.DeskIcon,
    a.DeskLabel1, 
    a.DeskLabel2,
    a.DeskButtonName, 
    a.DeskUrl, 
    a.DeskMenu, 
    a.DeskMain,
    a.DeskSort, 
    a.DeskActive
FROM  
	sDeskTop a 
WHERE 
	a.DeskName In('Home','Log Off')

UNION 
 
SELECT 
	c.PermissionFolderNotLocked,
	c.PermissionFolderTypeId,
	d.DeskTopID, 
	d.DeskName, 
	d.DeskDescription,
	d.DeskIcon,
	d.DeskLabel1, 
	d.DeskLabel2,
	d.DeskButtonName,
	d.DeskUrl, 
	d.DeskMenu, 
	d.DeskMain,
	d.DeskSort, 
	d.DeskActive
FROM 
	uUserGroup a WITH (NOLOCK), 
	uGroup b WITH (NOLOCK), sPermissionFolder c WITH (NOLOCK),
	sDeskTop d  
WHERE 
	a.GroupID = b.GroupID  
	AND b.Active =1 
	AND c.GroupID = b.GroupID 
	AND c.PermissionFolderTypeId = d.DeskFolderID
	AND d.DeskActive = 1 AND c.PermissionFolderNotLocked=1
	AND a.TeamID = @TeamId 
GROUP BY 
	c.PermissionFolderNotLocked,
	c.PermissionFolderTypeId,
	d.DeskTopID, 
	d.DeskName, 
	d.DeskDescription, 
	d.DeskIcon,
	d.DeskLabel1, 
	d.DeskLabel2, 
	d.DeskUrl, 
	d.DeskMenu, 
	d.DeskMain,
	d.DeskSort, 
	d.DeskActive,
	d.DeskButtonName 
ORDER BY 
	a.DeskSort  
  


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08053', GetDate())
GO
