IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Planning_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_Planning_WhereUsed_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_Material_Planning_WhereUsed_SELECT]
	@MaterialID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@WhereClause NVARCHAR(MAX)
AS
BEGIN

	SELECT DISTINCT p.*
	INTO #tmp0
	--SELECT DISTINCT p.* FROM 
	FROM pPlanningMaterial pm
		INNER JOIN vwx_Planning_SELECT p ON pm.PlanningID = p.PlanningID AND pm.SeasonYearID = p.SeasonYearID	
		INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 22) access ON access.ProductTypeId = p.PlanningTypeId
	WHERE access.PermissionRoleId = 3 OR access.PermissionView = 1 and pm.MaterialID=@MaterialID

	EXEC('SELECT * FROM #tmp0 ' + @WhereClause)		
	DROP TABLE #tmp0
END


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08295', GetDate())
GO

