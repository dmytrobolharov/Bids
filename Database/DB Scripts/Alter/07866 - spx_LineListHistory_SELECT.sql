/****** Object:  StoredProcedure [dbo].[spx_LineListHistory_SELECT]    Script Date: 06/04/2014 16:49:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListHistory_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineListHistory_SELECT]    Script Date: 06/04/2014 16:49:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_LineListHistory_SELECT](
	@TeamID UNIQUEIDENTIFIER
)
AS 

	SELECT a.LineFolderID,b.LineFolderDescription,c.LineFolderTypeDescription FROM pLineListHistory a
				INNER JOIN pLineFolder b on a.LineFolderID = b.LineFolderID
				LEFT OUTER JOIN pLineFolderType c ON b.LineFolderTypeID = c.LineFolderTypeID
				INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 3) access ON access.ProductTypeId = b.LineListTypeID
	WHERE a.TeamID = @TeamId
			AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)
	ORDER BY a.CDate DESC
	



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07866', GetDate())
GO