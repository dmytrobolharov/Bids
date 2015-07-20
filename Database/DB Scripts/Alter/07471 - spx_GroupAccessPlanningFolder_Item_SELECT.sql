IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_GroupAccessPlanningFolder_Item_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_GroupAccessPlanningFolder_Item_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_GroupAccessPlanningFolder_Item_SELECT] (   
@GroupID uniqueidentifier,
@PlanningTypeID UNIQUEIDENTIFIER  
)  
AS   
  DECLARE @TempItemPlanning TABLE
	(
		PlanningItemID UNIQUEIDENTIFIER,
		PlanningItemName NVARCHAR(500),
		PlanningItemDescription NVARCHAR(500),
		PlanningItemSort INT,
		Child nVARCHAR(2)
	)

	INSERT INTO @TempItemPlanning
	EXEC spx_PlanningFolderItem_SELECT @PlanningTypeID
  
	SELECT a.PlanningItemID, a.PlanningItemName, a.PlanningItemSort, a.PlanningItemDescription, a.Child, 
	 b.AccessPlanningItemID, b.AccessPlanningID,  b.AccessRoleId, b.AccessView, b.AccessCreate,   
	 b.AccessModify, b.AccessDelete, b.AccessPrint,
	 b.GroupID, b.CUser, b.CDate,  b.MUser,   
	 b.MDate  
	FROM  @TempItemPlanning a INNER JOIN   sAccessGroupPlanningFolderItem  b WITH (NOLOCK) ON a.PlanningItemID = b.PlanningItemID  
	WHERE b.GroupID = @GroupID  AND b.PlanningTypeID = @PlanningTypeID
	ORDER BY a.PlanningItemSort


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07471', GetDate())
GO