/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialQuickList_SELECT]    Script Date: 06/04/2014 14:31:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleMaterialQuickList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleMaterialQuickList_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleMaterialQuickList_SELECT]    Script Date: 06/04/2014 14:31:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleMaterialQuickList_SELECT]
(
@StyleMaterialNo nVARCHAR(100),
@TeamID nVARCHAR(100)
)
AS
BEGIN

	SELECT * FROM pMaterial 
	INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 8) access ON pMaterial.MaterialType = access.ProductTypeId
	WHERE access.PermissionRoleId <> 0
	AND MaterialNo LIKE '%'+@StyleMaterialNo+'%'
	ORDER BY MaterialNo 

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07886', GetDate())
GO