IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialCopySeasonYear_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_MaterialCopySeasonYear_SELECT]
GO

CREATE PROCEDURE dbo.spx_MaterialCopySeasonYear_SELECT
AS

	SELECT SeasonYearID, Season, Year FROM dbo.pSeasonYear WITH(NOLOCK)
	ORDER BY Year desc, Season
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01055', GetDate())
GO