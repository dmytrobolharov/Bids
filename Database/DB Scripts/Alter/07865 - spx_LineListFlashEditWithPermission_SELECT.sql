/****** Object:  StoredProcedure [dbo].[spx_LineListFlashEditWithPermission_SELECT]    Script Date: 06/04/2014 12:14:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListFlashEditWithPermission_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListFlashEditWithPermission_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_LineListFlashEditWithPermission_SELECT]    Script Date: 06/04/2014 12:14:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
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
	INNER JOIN fnx_Permissions_GetGuidProductType_WorkflowPermissions(@TeamID, 3, @LineListTypeID) access
	ON access.WorkflowId = flash.LineListFlashEditId
	WHERE flash.LineListFlashEditActive = 1
		AND flash.LineListFlashEditID = @LineListFlashEditID OR @LineListFlashEditID IS NULL 
		AND (access.PermissionView = 1 OR access.PermissionRoleId = 3)
	ORDER BY flash.LineListFlashEditSort

END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07865', GetDate())
GO