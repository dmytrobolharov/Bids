IF OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleMaterialSeasonal]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal]
AS 
SELECT m.MaterialID, sh.StyleID, sh.StyleNo, sh.Description, 
       COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
       COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
       sy.SeasonYearID
FROM pMaterial m
CROSS JOIN pStyleHeader sh
CROSS JOIN pSeasonYear sy
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09411', GetDate())
GO
