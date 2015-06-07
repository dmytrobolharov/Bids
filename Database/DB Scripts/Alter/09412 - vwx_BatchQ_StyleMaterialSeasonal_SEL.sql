IF OBJECT_ID(N'[dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_StyleMaterialSeasonal_SEL]
AS
SELECT DISTINCT 
	  TOP (100) PERCENT sh.StyleID, ssy.SeasonYearID, sh.StyleNo, sh.Description, sh.StyleCategory, 
	  COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, 
	  COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	  sh.MaterialNo, sh.MaterialName, 
	  sh.CustomField1, sh.CustomField2, sh.CustomField3, sh.CustomField4, sh.CustomField5,
	  sh.CustomField6, sh.CustomField7, sh.CustomField8, sh.CustomField15, 
	  sh.CustomField14, sh.CustomField13, sh.CustomField12, sh.CustomField11, 
	  sh.CustomField10, sh.CustomField9, sh.CustomField16, sh.CustomField30, 
	  sh.CustomField29, sh.CustomField28, sh.CustomField27, sh.CustomField26, 
	  sh.CustomField25, sh.CustomField24, sh.CustomField23, sh.CustomField22, 
	  sh.CustomField21, sh.CustomField20, sh.CustomField19, sh.CustomField18, 
	  sh.CustomField17, sh.CustomField31, sh.CustomField32, sh.CustomField33, 
	  sh.CustomField34, sh.CustomField35, sh.CustomField36, sh.CustomField37, 
	  sh.CustomField38, sh.CustomField39, sh.CustomField40, pStyleMaterials.StyleMaterialID, 
	  pStyleMaterials.MaterialID
	FROM pStyleHeader sh
	INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID 
	INNER JOIN pStyleColorwaySeasonYear scsy ON ssy.StyleSeasonYearID = scsy.StyleSeasonYearID 
	INNER JOIN pStyleColorway sc ON scsy.StyleColorwayID = sc.StyleColorID 
	INNER JOIN pStyleMaterials ON sh.StyleID = pStyleMaterials.StyleID
    LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
    LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
	WHERE (scsy.StyleColorStatus = 0) OR (scsy.StyleColorStatus = 100)
ORDER BY sh.StyleNo

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09412', GetDate())
GO
