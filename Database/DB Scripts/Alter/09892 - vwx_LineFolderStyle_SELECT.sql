IF OBJECT_ID(N'[dbo].[vwx_LineFolderStyle_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LineFolderStyle_SELECT]
GO

CREATE VIEW [dbo].[vwx_LineFolderStyle_SELECT]
AS
SELECT DISTINCT lfi.LineFolderItemID, lfi.LineFolderID, lfi.LineFolderItemDrop, sh.StyleID, 
       sh.DevelopmentNo + '*' + CAST(sdi.Variation AS NVARCHAR(5)) AS ConceptNo, sh.DevelopmentNo, 
       sh.StyleNo, sh.CustomField1, sh.CustomField5 AS PatternRef, sh.Description, sh.CustomField8 AS DMCStyleType, 
	   sm.F AS FabricYarnType, sm.MaterialName AS MainMaterial, sm.H AS [Content], sm.I AS FabricWeight, 
	   sh.SizeClassId, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, 
	   sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   lf.SeasonYearID, lf.LineFolderTypeID, sh.DesignSketchID, sh.DesignSketchVersion, sh.StyleCategory, 
	   sh.StyleType, sh.WorkflowType, sh.DueDate, sh.RecDate, sh.TradePartnerID, sh.IntroSeasonYearID, 
	   sc.StyleCategory AS StyleCategoryName, perm.TeamId, perm.AccessRoleId, perm.AccessModify, 
	   lfi.LineFolderImageID, lfi.LineFolderImageVersion, lfi.LineFolderItemSort, sc.StyleCategoryId, 
	   lfi.StyleSeasonYearID, ssy.SeasonYearID AS ColorwaySeasonYearID, sh.SubCategoryId
FROM pLineFolderItem lfi
INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID 
INNER JOIN vwx_Permissions_ProductTypes	perm ON sh.StyleType = perm.IntProductTypeId AND 
												perm.PermissionFolderTypeId = 2 
INNER JOIN pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID 
INNER JOIN pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID 
INNER JOIN pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId 
INNER JOIN pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID
LEFT JOIN pStyleMaterials sm ON sh.StyleID = sm.StyleID AND 
								sh.StyleSet = sm.StyleSet AND 
								sm.MainMaterial = 1 
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09892', GetDate())
GO
