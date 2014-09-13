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

    SELECT ISNULL(MAX(AccessRoleId),0) As AccessRoleId, ISNULL(MAX(AccessView),0) As AccessView,
    ISNULL(MAX(AccessCreate),0) As AccessCreate, ISNULL(MAX(AccessModify),0) As AccessModify, ISNULL(MAX(AccessDelete),0) As AccessDelete, ISNULL(MAX(AccessPrint),0) As AccessPrint
    FROM sAccessPlanningFolderItem WHERE TeamId = @TeamID AND PlanningTypeId = @PlanningTypeId
    AND PlanningItemID=@PlanningItemID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07515', GetDate())
GO
