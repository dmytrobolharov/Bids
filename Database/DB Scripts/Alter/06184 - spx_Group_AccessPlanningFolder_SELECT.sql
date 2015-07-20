IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessPlanningFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessPlanningFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessPlanningFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 
SELECT 1 AS PlanningTypeId, 'Planning Folder' AS PartnerFolder, AccessPlanningID,  AccessRoleId,  AccessView, AccessCreate, 
    AccessModify, AccessDelete, AccessPrint,  GroupID, 
    CUser, CDate, MUser, MDate  
FROM  sAccessGroupPlanningFolder 
WHERE GroupID = @GroupID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06184', GetDate())
GO
