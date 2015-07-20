
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[spx_SeasonYearAvailable_SELECT]') AND OBJECTPROPERTY(id,N'IsProcedure') = 1)
BEGIN
	DROP PROCEDURE spx_SeasonYearAvailable_SELECT
END
GO

CREATE PROCEDURE [dbo].[spx_SeasonYearAvailable_SELECT] 
AS

BEGIN
	SELECT SeasonYearID, Season, Year, Active, Sort, CUser, CDate, MUser, MDate, CurrentSeason, SAPCode, CustomID, CustomKey, CustomSort, 
		  [Season] + ' ' + [YEAR] AS SeasonYear
	FROM  pSeasonYear
	WHERE Active = 1
	ORDER BY Sort, [YEAR] DESC, [Season]
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01008', GetDate())
GO
