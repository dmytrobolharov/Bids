/****** Object:  StoredProcedure [dbo].[spx_Material_Where_SELECT]    Script Date: 06/04/2014 14:57:54 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Where_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_Where_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Material_Where_SELECT]    Script Date: 06/04/2014 14:57:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[spx_Material_Where_SELECT](
@MaterialID UNIQUEIDENTIFIER, 
@TeamID UNIQUEIDENTIFIER 
) 
AS 


	SELECT a.MaterialID, a.MChange 
    FROM pStyleMaterials a , pStyleHeader b  
    INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = b.StyleType
    WHERE a.StyleID = b.StyleID 
	AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)
    GROUP BY a.MChange, a.MaterialID
    HAVING a.MaterialID = @MaterialID  
    UNION
    SELECT a.MaterialID, a.MChange 
    FROM pStyleBOM a , pStyleHeader b  
    INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 2) access ON access.ProductTypeId = b.StyleType
    WHERE a.StyleID = b.StyleID 
	AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)
    GROUP BY a.MChange, a.MaterialID
    HAVING a.MaterialID = @MaterialID  
    ORDER BY a.MChange DESC 
    



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07867', GetDate())
GO