IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_AccessPlanningFolder_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_AccessPlanningFolder_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Group_AccessPlanningFolder_SELECT] (
@GroupID uniqueidentifier
)
AS 

	SELECT pPlanningType.PlanningTypeID, PlanningType,  AccessPlanningId,  AccessRoleId,  AccessView, AccessCreate, 
	AccessModify, AccessDelete, AccessPrint,  GroupID, 
	sAccessGroupPlanningFolder.CUser, sAccessGroupPlanningFolder.CDate, sAccessGroupPlanningFolder.MUser, sAccessGroupPlanningFolder.MDate  
	FROM  sAccessGroupPlanningFolder INNER JOIN pPlanningType
	ON sAccessGroupPlanningFolder.PlanningTypeId = pPlanningType.PlanningTypeID
	WHERE GroupID = @GroupID
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07468', GetDate())
GO