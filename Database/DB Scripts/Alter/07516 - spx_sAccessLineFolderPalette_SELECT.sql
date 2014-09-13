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
    SELECT MAX(AccessRoleId) As AccessRoleId, MAX(AccessView) As AccessView,
	MAX(AccessCreate) As AccessCreate, MAX(AccessModify) As AccessModify, MAX(AccessDelete) As AccessDelete, MAX(AccessPrint) As AccessPrint
    FROM sAccessLineFolderPalette WHERE TeamId = @TeamID AND LineTypeId = @LineTypeID
    AND LinePaletteID=@LinePaletteID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07516', GetDate())
GO
