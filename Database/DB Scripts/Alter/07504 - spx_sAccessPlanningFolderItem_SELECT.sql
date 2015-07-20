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

    SELECT MAX(AccessRoleId) As AccessRoleId, MAX(AccessView) As AccessView,
    MAX(AccessCreate) As AccessCreate, MAX(AccessModify) As AccessModify, MAX(AccessDelete) As AccessDelete, MAX(AccessPrint) As AccessPrint
    FROM sAccessPlanningFolderItem WHERE TeamId = @TeamID AND PlanningTypeId = @PlanningTypeId
    AND PlanningItemID=@PlanningItemID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07504', GetDate())
GO