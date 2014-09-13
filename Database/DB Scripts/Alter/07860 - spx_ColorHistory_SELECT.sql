/****** Object:  StoredProcedure [dbo].[spx_ColorHistory_SELECT]    Script Date: 06/04/2014 10:25:28 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorHistory_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorHistory_SELECT]    Script Date: 06/04/2014 10:25:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_ColorHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

	SELECT a.ColorFolderID,b.ColorFolderDescription,b.ColorTypeID,c.ColorTypeDescription FROM pColorHistory a WITH (NOLOCK)
				INNER JOIN pColorFolder b WITH (NOLOCK) ON a.ColorFolderID = b.ColorFolderID
				INNER JOIN fnx_Permissions_GetIntProductTypePermissions(@TeamID, 7) access ON access.ProductTypeId = b.ColorTypeID
				LEFT OUTER JOIN pColorType c ON b.ColorTypeID = c.ColorTypeID
	WHERE a.TeamID = @TeamId and (PermissionRoleId = 3 OR PermissionView = 1)
	ORDER BY a.CDate DESC


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07860', GetDate())
GO