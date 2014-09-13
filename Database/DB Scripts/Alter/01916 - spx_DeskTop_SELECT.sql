IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTop_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTop_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_DeskTop_SELECT](@TeamID uniqueidentifier)
AS 

SELECT  1000 'DeskAccessId',1001 'DeskFolderID',a.DeskTopID, a.DeskName, a.DeskDescription, a.DeskIcon,
      a.DeskLabel1, a.DeskLabel2, a.DeskUrl, a.DeskMenu, a.DeskMain,
      a.DeskSort, a.DeskActive
FROM  sDeskTop a 
WHERE a.DeskName In('Home','Log Off')

UNION 
 
SELECT c.DeskAccessId,c.DeskFolderID,d.DeskTopID, d.DeskName, d.DeskDescription, d.DeskIcon,
  d.DeskLabel1, d.DeskLabel2, d.DeskUrl, d.DeskMenu, d.DeskMain,
  d.DeskSort, d.DeskActive
FROM uUserGroup a WITH (NOLOCK), uGroup b WITH (NOLOCK), cDeskGroupFolderAccess c WITH (NOLOCK),sDeskTop d  
WHERE a.GroupID = b.GroupID  AND b.Active =1 AND c.GroupID = b.GroupID AND c.DeskFolderID = d.DeskFolderID AND d.DeskActive = 1 AND c.DeskAccessId=1
AND a.TeamID = @TeamId GROUP BY c.DeskAccessId,c.DeskFolderID,d.DeskTopID, d.DeskName, d.DeskDescription, d.DeskIcon,
  d.DeskLabel1, d.DeskLabel2, d.DeskUrl, d.DeskMenu, d.DeskMain,
  d.DeskSort, d.DeskActive ORDER BY a.DeskSort

  
  
--CREATE  PROCEDURE [dbo].[spx_DeskTop_SELECT](@TeamID uniqueidentifier)  
--AS   
  
--SELECT  a.DeskTopID, a.DeskName, a.DeskDescription, a.DeskIcon,  
--      a.DeskLabel1, a.DeskLabel2, a.DeskUrl, a.DeskMenu, a.DeskMain,  
--      a.DeskSort, a.DeskActive  
--FROM  sDeskTop a   
--WHERE a.DeskName In('Home','Log Off')  
  
--UNION  
  
--SELECT  a.DeskTopID, a.DeskName, a.DeskDescription, a.DeskIcon,  
--      a.DeskLabel1, a.DeskLabel2, a.DeskUrl, a.DeskMenu, a.DeskMain,  
--      a.DeskSort, a.DeskActive  
--FROM  sDeskTop a INNER JOIN cDeskUserFolderAccess b ON a.DeskFolderID = b.DeskFolderID    
--WHERE b.TeamId = @TeamId AND b.DeskAccessID = 1  AND a.DeskActive = 1  
--ORDER BY a.DeskSort  
  
  
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01916'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01916', GetDate())
END	
GO


