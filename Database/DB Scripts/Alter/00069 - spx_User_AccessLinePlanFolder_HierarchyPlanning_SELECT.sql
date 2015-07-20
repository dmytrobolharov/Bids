IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_AccessLinePlanFolder_HierarchyPlanning_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_AccessLinePlanFolder_HierarchyPlanning_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_User_AccessLinePlanFolder_HierarchyPlanning_SELECT] (
@LinePlanID UNIQUEIDENTIFIER ,
@TeamID UNIQUEIDENTIFIER ,
@LinePlanAttributeItemID UNIQUEIDENTIFIER  = NULL
)
AS 

DECLARE  @LinePlanTemplateID UNIQUEIDENTIFIER

SELECT @LinePlanTemplateID = LinePlanTemplateID  FROM pLinePlan 
WHERE LinePlanID = @LinePlanID 



SELECT ISNULL(MAX(AccessRoleID),0) AS AccessRoleID , ISNULL(MAX(AccessPlanView),0) AS AccessPlanView, 
ISNULL(MAX(AccessPlanNew),0) AS AccessPlanNew, ISNULL(MAX(AccessPlanDelete),0) AS AccessPlanDelete, 
ISNULL(MAX(AccessHierView),0) AS AccessHierView, ISNULL(MAX(AccessHierNew),0) AS AccessHierNew, 
ISNULL(MAX(AccessHierDelete),0) AS AccessHierDelete
FROM sAccessGroupLinePlanFolder
WHERE LinePlanTemplateID =  @LinePlanTemplateID  
AND GroupID  IN (
	SELECT GroupID FROM dbo.uUserGroup WHERE TeamID = @TeamID
) 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '069', GetDate())


GO


