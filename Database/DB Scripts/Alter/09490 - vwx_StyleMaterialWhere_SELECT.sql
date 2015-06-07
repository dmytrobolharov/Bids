IF OBJECT_ID(N'[dbo].[vwx_StyleMaterialWhere_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_StyleMaterialWhere_SELECT]
GO


CREATE VIEW [dbo].[vwx_StyleMaterialWhere_SELECT]
AS 
SELECT ssy.StyleSeasonYearID, sh.StyleNo, sh.Description, 
       COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
	   COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   ssy.StyleSeason, ssy.StyleYear   
FROM pStyleSeasonYear ssy WITH (NOLOCK)
INNER JOIN  pStyleHeader sh WITH (NOLOCK) ON ssy.StyleID  = sh.StyleID 
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09490', GetDate())
GO
