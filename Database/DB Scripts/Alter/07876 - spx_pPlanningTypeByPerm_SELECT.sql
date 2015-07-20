/****** Object:  StoredProcedure [dbo].[spx_pPlanningTypeByPerm_SELECT]    Script Date: 06/04/2014 11:47:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_pPlanningTypeByPerm_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_pPlanningTypeByPerm_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_pPlanningTypeByPerm_SELECT]    Script Date: 06/04/2014 11:47:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_pPlanningTypeByPerm_SELECT] (
@TeamID  uniqueidentifier
)

AS
BEGIN

	SELECT pt.PlanningTypeID, PlanningType FROM pPlanningType pt
    INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 22) access ON access.ProductTypeId = pt.PlanningTypeID
    WHERE (access.PermissionCreate = 1 OR access.PermissionRoleId = 3)
    AND pt.Active = 1
    ORDER BY Sort
    
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07876', GetDate())
GO