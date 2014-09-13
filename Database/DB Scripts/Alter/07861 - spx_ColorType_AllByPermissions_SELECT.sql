/****** Object:  StoredProcedure [dbo].[spx_ColorType_AllByPermissions_SELECT]    Script Date: 06/04/2014 13:39:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorType_AllByPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorType_AllByPermissions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorType_AllByPermissions_SELECT]    Script Date: 06/04/2014 13:39:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE  [dbo].[spx_ColorType_AllByPermissions_SELECT]
(
@TeamID UNIQUEIDENTIFIER 
)
AS
 
BEGIN
	SELECT * FROM pColorType
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 7) access ON access.ProductTypeId = pColorType.ColorTypeID
	WHERE PermissionRoleId <> 0
	ORDER BY Sort
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07861', GetDate())
GO