IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorType_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorType_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ColorType_SELECT]
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT * FROM pColorType
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 7) access ON pColorType.ColorTypeID = access.ProductTypeId
	WHERE PermissionRoleId <> 0
	AND CorpColor  = 0
	ORDER BY Sort
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07895', GetDate())
GO
