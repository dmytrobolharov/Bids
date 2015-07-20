IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Material_Availability_Tracking_Param_MaterialNo_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Material_Availability_Tracking_Param_MaterialNo_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Material_Availability_Tracking_Param_MaterialNo_SELECT]
	@SeasonYearID AS UNIQUEIDENTIFIER = NULL
AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
		SELECT TOP 1 @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1

    SELECT DISTINCT
          m.MaterialID
        , ISNULL(m.MaterialNo + ISNULL(' (' + m.MaterialName + ')',''), '') AS Material
    FROM pMaterial m
		INNER JOIN pStyleBOM sb ON m.MaterialID = sb.MaterialID
		INNER JOIN pStyleHeader sh ON sb.StyleID = sh.StyleID
		INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
    WHERE ssy.SeasonYearID = @SeasonYearID
	ORDER BY ISNULL(m.MaterialNo + ISNULL(' (' + m.MaterialName + ')',''), '')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09190', GetDate())
GO
