IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Image_Material_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Image_Material_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_Image_Material_WhereUsed_SELECT]
	@ImageID UNIQUEIDENTIFIER
	, @TeamID UNIQUEIDENTIFIER
AS
BEGIN

	SELECT *
	FROM pMaterial m
		INNER JOIN dbo.fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) perm ON m.MaterialType = perm.ProductTypeId
	WHERE (PermissionRoleID = 3 OR PermissionView = 1)
		AND MaterialImageID = @ImageID AND MaterialImageID != '00000000-0000-0000-0000-000000000000'

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07805', GetDate())
GO
