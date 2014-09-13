IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Line_List_Theme_Theme_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Line_List_Theme_Theme_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Line_List_Theme_Theme_SELECT]
	
AS
BEGIN
	
	SELECT '(ALL)' AS ThemeName, '00000000-0000-0000-0000-000000000000' AS StyleThemeID
	UNION
	SELECT ThemeName, StyleThemeID
	FROM pStyleTheme
	WHERE Active = 1
	ORDER BY ThemeName
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06578', GetDate())
GO
