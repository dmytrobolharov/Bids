/****** Object:  StoredProcedure [dbo].[spx_StyleTypeList_ByPermissions_SELECT]    Script Date: 06/02/2014 13:54:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTypeList_ByPermissions_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTypeList_ByPermissions_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleTypeList_ByPermissions_SELECT]    Script Date: 06/02/2014 13:54:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleTypeList_ByPermissions_SELECT] (
	@TeamId UNIQUEIDENTIFIER
	) AS 
BEGIN

	SELECT StyleTypeID, StyleTypeDescription FROM pStyleType
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamId, 2) access ON pStyleType.StyleTypeID = access.ProductTypeId
	WHERE access.PermissionRoleId = 3 OR access.PermissionCreate = 1
	ORDER BY StyleTypeOrder

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07820', GetDate())
GO
