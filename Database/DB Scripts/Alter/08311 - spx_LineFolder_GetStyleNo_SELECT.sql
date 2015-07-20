IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolder_GetStyleNo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolder_GetStyleNo_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LineFolder_GetStyleNo_SELECT]
(
	@StyleSeasonYearID UNIQUEIDENTIFIER
)
AS
BEGIN
		SELECT StyleNo
		FROM pStyleSeasonYear ssy
		WHERE ssy.StyleSeasonYearID = @StyleSeasonYearID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08311', GetDate())
GO
