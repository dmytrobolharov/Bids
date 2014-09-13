IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sAccessLineFolderPalette_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sAccessLineFolderPalette_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_sAccessLineFolderPalette_SELECT] (
@LineTypeId uniqueidentifier,
@LinePaletteID uniqueidentifier,
@TeamID  uniqueidentifier
)

AS
BEGIN      
    SELECT ISNULL(MAX(AccessRoleId),0) As AccessRoleId, ISNULL(MAX(AccessView),0) As AccessView,
	ISNULL(MAX(AccessCreate),0) As AccessCreate, ISNULL(MAX(AccessModify),0) As AccessModify, ISNULL(MAX(AccessDelete),0) As AccessDelete, ISNULL(MAX(AccessPrint),0) As AccessPrint
    FROM sAccessLineFolderPalette WHERE TeamId = @TeamID AND LineTypeId = @LineTypeID
    AND LinePaletteID=@LinePaletteID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07533', GetDate())
GO