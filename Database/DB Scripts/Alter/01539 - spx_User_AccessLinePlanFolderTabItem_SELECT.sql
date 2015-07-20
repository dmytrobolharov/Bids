IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_User_AccessLinePlanFolderTabItem_SELECT') 
	DROP PROCEDURE spx_User_AccessLinePlanFolderTabItem_SELECT
GO
/****** Object:  StoredProcedure [dbo].[spx_User_AccessLinePlanFolderTabItem_SELECT]    Script Date: 06/21/2011 15:54:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_User_AccessLinePlanFolderTabItem_SELECT](
@LinePlanAttributeItemId uniqueidentifier,
@LinePlanId uniqueidentifier,
@LinePlanTabID int,
@TeamId uniqueidentifier
)
AS 

DECLARE  @LinePlanTemplateID UNIQUEIDENTIFIER 
DECLARE  @LinePlanAttributeValue nvarchar(200) 

select @LinePlanAttributeValue = LinePlanAttributeValue,  @LinePlanTemplateID = LinePlanTemplateID from pLinePlanAttributeItem d 
where  d.LinePlanAttributeItemID = @LinePlanAttributeItemId AND d.LinePlanID = @LinePlanId  

/*
SELECT @LinePlanTemplateID = LinePlanTemplateID FROM pLinePlan WHERE LinePlanID = @LinePlanID 

SELECT a.LinePlanFolderTabID, c.TeamID, a.AccessLinePlanId, 
      a.AccessRoleId, a.AccessView, a.AccessCreate, 
      a.AccessModify, a.AccessDelete, a.AccessPrint, 
      a.AccessRemove, a.CUser, a.CDate, a.MUser, 
      a.MDate, a.AccessLinePlanTabId, f.LinePlanTabID, f.LinePlanTabName, 
      f.LinePlanTabUrl, f.LinePlanTabToolTip, f.LinePlanTabSort, f.LinePlanTabRollupName, 
      f.LinePlanTabRollupUrl, f.LinePlanTabRollupToolTip
FROM  sAccessGroupLinePlanTab a 
INNER JOIN sAccessGroupLinePlanFolder b ON a.AccessLinePlanId = b.AccessLinePlanId 
INNER JOIN uUserGroup c ON b.GroupID = c.GroupID 
INNER JOIN pLinePlanAttributeItem d ON CAST(b.CustomID AS VARCHAR(40)) = d.LinePlanAttributeValue 
INNER JOIN pLinePlanFolderTab e ON a.LinePlanFolderTabID = e.LinePlanFolderTabID  AND e.LinePlanTemplateID = @LinePlanTemplateID
INNER JOIN pLinePlanTab f ON e.LinePlanTabID = f.LinePlanTabID
WHERE c.TeamID = @TeamID
AND f.Active = 1
AND d.LinePlanAttributeItemID = @LinePlanAttributeItemId 
AND d.LinePlanID = @LinePlanId
AND a.LinePlanTemplateID = @LinePlanTemplateID 
AND e.LinePlanTabID  = @LinePlanTabID 
ORDER BY  f.LinePlanTabSort
*/

SELECT  d.LinePlanTabName, d.LinePlanTabID, d.LinePlanTabSort, d.LinePlanTabUrl, d.LinePlanTabToolTip,
		d.LinePlanTabRollupName, d.LinePlanTabRollupUrl, d.LinePlanTabRollupToolTip, 
		MAX(a.AccessRoleId) AS AccessRoleId, MAX(a.AccessView) AS AccessView, 
		MAX(a.AccessCreate) AS AccessCreate , MAX(a.accessModify) AS accessModify, 
		MAX(a.AccessDelete) AS AccessDelete , MAX(a.AccessPrint) AS AccessPrint, MAX(a.AccessRemove) AS AccessRemove
	FROM sAccessGroupLinePlanTab a
		INNER JOIN sAccessGroupLinePlanFolder b ON b.AccessLinePlanId =  a.AccessLinePlanId
		INNER JOIN dbo.pLinePlanFolderTab c ON c.LinePlanFolderTabID =  a.LinePlanFolderTabID
		INNER JOIN dbo.pLinePlanTab d ON d.LinePlanTabID =  c.LinePlanTabID
		INNER JOIN dbo.uUserGroup e ON e.GroupID =  b.GroupID 
		AND e.TeamID = @TeamId	
	WHERE  cast(b.CustomID as nvarchar(200)) = @LinePlanAttributeValue  and	
	a.LinePlanTemplateID = @LinePlanTemplateID  and d.Active=1 and c.LinePlanTabID = @LinePlanTabID	 
	GROUP BY d.LinePlanTabName,d.LinePlanTabID, d.LinePlanTabSort, d.LinePlanTabUrl, 
	d.LinePlanTabToolTip, d.LinePlanTabRollupName, d.LinePlanTabRollupUrl, d.LinePlanTabRollupToolTip
	ORDER BY d.LinePlanTabSort

Go
  
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01539', GetDate())
GO