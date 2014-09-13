IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Material_Availability_Tracking_Param_StyleNo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Material_Availability_Tracking_Param_StyleNo_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Material_Availability_Tracking_Param_StyleNo_SELECT]
	@SeasonYearID AS UNIQUEIDENTIFIER = NULL
AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

	SELECT
		sh.StyleID
		, sh.StyleNo
	FROM pStyleSeasonYear ssy
		INNER JOIN pStyleHeader sh ON ssy.StyleID = sh.StyleID
	WHERE ssy.SeasonYearID = @SeasonYearID
	ORDER BY sh.StyleNo
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05571', GetDate())
GO
