IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_User_DeskTop_Default_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_User_DeskTop_Default_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_User_DeskTop_Default_SELECT]
(
	@TeamID UNIQUEIDENTIFIER
	, @DeskURL NVARCHAR(MAX) = '' OUTPUT
)
AS
BEGIN
	SELECT @DeskURL = ISNULL('../Desk/Desk_Folder.aspx?DTID=' + CAST(u.DeskTopID AS NVARCHAR(5)) + '&TID=' + CAST(u.TeamID AS NVARCHAR(50)) + '&MW=' + CAST(dt.MenuWidth AS NVARCHAR(5)), '')
	FROM Users u
		LEFT JOIN sDeskTop dt ON u.DeskTopID = dt.DeskTopID
	WHERE u.TeamID = @TeamID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09299', GetDate())
GO
