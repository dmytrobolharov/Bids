IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GroupAccessPlanningFolder_Item_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GroupAccessPlanningFolder_Item_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_GroupAccessPlanningFolder_Item_UPDATE]  (  
@AccessRoleId	INT,   
@AccessView		INT,   
@AccessCreate	INT ,   
@AccessModify	INT,  
@AccessDelete	INT ,   
@AccessPrint	INT , 
@MUser			NVARCHAR (200),   
@MDate			DATETIME ,   
@AccessPlanningItemID UNIQUEIDENTIFIER   
)  
AS

DECLARE @AccessPlanningId UNIQUEIDENTIFIER
DECLARE @GroupID UNIQUEIDENTIFIER
DECLARE @PlanningTypeID UNIQUEIDENTIFIER

SELECT @AccessPlanningId = AccessPlanningID, @GroupID = GroupID, @PlanningTypeID = PlanningTypeID 
FROM sAccessGroupPlanningFolderItem WHERE AccessPlanningItemID = @AccessPlanningItemID


EXEC spx_Group_DesktopAccessPlanningFolderItemCheck_INSERT @AccessPlanningID, @AccessRoleID, @PlanningTypeID, @GroupID, @MUser, @MDate
  
 UPDATE sAccessGroupPlanningFolderItem    
 SET AccessRoleId = @AccessRoleId,   
 AccessView = @AccessView,    
 AccessCreate = @AccessCreate,    
 AccessModify = @AccessModify, 
 AccessDelete = @AccessDelete,    
 AccessPrint = @AccessPrint,   
 MUser = @MUser,    
 MDate = @MDate    
 WHERE AccessPlanningItemID = @AccessPlanningItemID
 



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07472', GetDate())
GO