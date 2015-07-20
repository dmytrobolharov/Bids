IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListFlashEditWithPermission_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListFlashEditWithPermission_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LineListFlashEditWithPermission_SELECT]	
	@LineFolderID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@LineListFlashEditID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	DECLARE @LineListTypeID UNIQUEIDENTIFIER
	SELECT @LineListTypeID = LineListTypeID FROM pLineFolder WHERE LineFolderID = @LineFolderID

	SELECT * FROM pLineListFlashEdit flash
	INNER JOIN sAccessLineFolderPalette access
	ON access.LinePaletteID = flash.LineListFlashEditId AND access.TeamID = @TeamID AND access.LineTypeID = @LineListTypeID
	WHERE flash.LineListFlashEditActive = 1
		AND flash.LineListFlashEditID = @LineListFlashEditID OR @LineListFlashEditID IS NULL 
		AND (access.AccessView = 1 OR access.AccessRoleId = 3)
	ORDER BY flash.LineListFlashEditSort
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07400', GetDate())
GO
