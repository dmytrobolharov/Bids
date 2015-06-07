IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListHistory_SELECT]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_LineListHistory_SELECT]
GO
CREATE PROCEDURE [dbo].[spx_LineListHistory_SELECT]
(
	@TeamID UNIQUEIDENTIFIER
) AS
BEGIN
	DECLARE @DivisionFolderTypeID INT = 26

	SELECT a.LineFolderID,b.LineFolderDescription,c.LineFolderTypeDescription
	FROM pLineListHistory a
		INNER JOIN pLineFolder b on a.LineFolderID = b.LineFolderID
		LEFT OUTER JOIN pLineFolderType c ON b.LineFolderTypeID = c.LineFolderTypeID
		INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, 3) d ON d.ProductTypeId = b.LineListTypeID
		INNER JOIN fnx_Permissions_GetGuidProductTypePermissions(@TeamID, @DivisionFolderTypeID) division ON division.ProductTypeId = b.LineFolderDivisionID
	WHERE a.TeamID = @TeamID
			AND (d.PermissionView = 1 OR d.PermissionRoleId = 3)
			AND (division.PermissionView = 1 OR division.PermissionRoleId = 3)
	ORDER BY a.CDate DESC
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10202', GetUTCDate())
GO