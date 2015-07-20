IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_GetStyleNo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_GetStyleNo_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_GetStyleNo_SELECT]
(
	@StyleSeasonYearID UNIQUEIDENTIFIER
)
AS
BEGIN
		SELECT sh.StyleNo FROM pStyleHeader sh
			inner join pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
			WHERE StyleSeasonYearID = @StyleSeasonYearID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09260', GetDate())
GO
