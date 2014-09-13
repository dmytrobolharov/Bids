IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sAccessPlanningFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sAccessPlanningFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_sAccessPlanningFolder_SELECT] (
@TeamID  uniqueidentifier
)

AS
BEGIN

       SELECT ISNULL(MAX(AccessRoleID), 0) AS AccessRoleID,
       ISNULL(MAX(AccessView), 0) AS AccessView,
       ISNULL(MAX(AccessCreate), 0) AS AccessCreate,
       ISNULL(MAX(AccessModify), 0) AS AccessModify,
       ISNULL(MAX(AccessDelete), 0) AS AccessDelete,
       ISNULL(MAX(AccessPrint), 0) AS AccessPrint
       FROM sAccessPlanningFolder INNER JOIN pPlanningType ON pPlanningType.PlanningTypeID = sAccessPlanningFolder.PlanningTypeID
       WHERE TeamId = @TeamID
    
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07479', GetDate())
GO