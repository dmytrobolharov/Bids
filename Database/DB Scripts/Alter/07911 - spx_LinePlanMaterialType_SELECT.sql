/****** Object:  StoredProcedure [dbo].[spx_LinePlanMaterialType_SELECT]    Script Date: 06/05/2014 11:48:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanMaterialType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LinePlanMaterialType_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LinePlanMaterialType_SELECT]    Script Date: 06/05/2014 11:48:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_LinePlanMaterialType_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 


    SELECT DISTINCT 
		a.ComponentTypeID, 
		a.ComponentDescription, 
		a.ComponentOrder
    FROM 
		dbo.pComponentType a WITH(NOLOCK) 
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) access ON access.ProductTypeId = a.ComponentTypeID
	AND access.PermissionRoleId <> 0 
	--WHERE a.ComponentTypeID IN (10,11,42,40,13) 
	ORDER BY 
		a.ComponentOrder


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07911', GetDate())
GO