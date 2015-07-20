IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pPlanningTypeByPerm_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pPlanningTypeByPerm_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_pPlanningTypeByPerm_SELECT] (
@TeamID  uniqueidentifier
)

AS
BEGIN

	SELECT pt.PlanningTypeID, PlanningType FROM pPlanningType pt
    INNER JOIN sAccessPlanningFolder apf ON pt.PlanningTypeID = apf.PlanningTypeID
    WHERE apf.TeamId = @TeamID
    AND (apf.AccessCreate = 1 OR apf.AccessRoleId = 3)
    AND pt.Active = 1
    ORDER BY Sort
    
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07477', GetDate())
GO