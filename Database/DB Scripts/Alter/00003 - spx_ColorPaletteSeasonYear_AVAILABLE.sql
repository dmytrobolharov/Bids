

INSERT INTO sVersion (AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '003', GetDate())

GO


ALTER PROCEDURE spx_ColorPaletteSeasonYear_AVAILABLE  (
@ColorPaletteID UNIQUEIDENTIFIER
)
AS 

--***
--** Modified by Artemio Gomez, 3/9/2010
--** Display only the seasonyears available in the ColorFolder 
--***

/*
SELECT  SeasonYearID , [Season] + ' ' + [Year] AS SeasonYear FROM  pSeasonYear 
WHERE SeasonYearID NOT IN (SELECT SeasonYearID FROM pColorPaletteSeasonYear WHERE ColorPaletteID = @ColorPaletteID)
*/

SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear 
FROM pColorFolderSeasonYear a
INNER JOIN pSeasonYear b ON a.SeasonYearID =  b.SeasonYearID 
WHERE a.SeasonYearID NOT IN ( 
	SELECT DISTINCT SeasonYearID FROM pColorPaletteSeasonYear WHERE ColorPaletteID = @ColorPaletteID
)
AND ColorFolderID =  ( SELECT ColorFolderID FROM pColorPalette WHERE ColorPaletteID = @ColorPaletteID )
ORDER BY Sort

GO

