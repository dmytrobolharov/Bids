IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sAccessPlanningFolderItem_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sAccessPlanningFolderItem_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_sAccessPlanningFolderItem_SELECT] (
@PlanningTypeId uniqueidentifier,
@PlanningItemID uniqueidentifier,
@TeamID  uniqueidentifier
)

AS
BEGIN

    SELECT AccessPlanningItemID, AccessPlanningItemID, PlanningItemID, PlanningTypeId, AccessRoleId, AccessView,
    AccessCreate, AccessModify, AccessDelete, AccessPrint,
    TeamId, CUser, CDate, MUser, MDate
    FROM sAccessPlanningFolderItem WHERE TeamId = @TeamID AND PlanningTypeId = @PlanningTypeId
    AND PlanningItemID=@PlanningItemID
    
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07480', GetDate())
GO