/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessLineFolderPaletteCheck_INSERT]    Script Date: 06/11/2013 13:55:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Group_DesktopAccessLineFolderPaletteCheck_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Group_DesktopAccessLineFolderPaletteCheck_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Group_DesktopAccessLineFolderPaletteCheck_INSERT]    Script Date: 06/11/2013 13:55:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Group_DesktopAccessLineFolderPaletteCheck_INSERT] (
	@AccessLineId UNIQUEIDENTIFIER,
	@AccessRoleId INT,
	@LineTypeID UNIQUEIDENTIFIER,
	@GroupID UNIQUEIDENTIFIER,
	@CreatedBy NVARCHAR(200),
	@CreatedDate DATETIME
)
AS


BEGIN
	
	EXEC spx_Group_DesktopAccessLineFolderCheck_INSERT
			@GroupID, @CreatedBy, @CreatedDate
	
END


BEGIN
	
	DECLARE @TempWorkflowAccess TABLE
	(
		LinePaletteID UNIQUEIDENTIFIER,
		LinePaletteName NVARCHAR(500),
		LinePaletteDescription NVARCHAR(500),
		LinePaletteSort VARCHAR(5)
	)

	INSERT INTO @TempWorkflowAccess
	EXEC spx_LineFolderPalette_SELECT @LineTypeID

	
	INSERT INTO sAccessGroupLineFolderPalette (AccessLineID, LineTypeID, LinePaletteID, AccessRoleId, GroupID, CUser, CDate, MUser, MDate)
	SELECT @AccessLineId, @LineTypeID, LinePaletteID, @AccessRoleId, @GroupID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate
	FROM @TempWorkflowAccess 
	WHERE LinePaletteID NOT IN( SELECT LinePaletteID FROM sAccessGroupLineFolderPalette WHERE GroupID = @GroupID AND LineTypeID = @LineTypeID )

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05838', GetDate())
GO
