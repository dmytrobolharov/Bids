IF OBJECT_ID(N'[dbo].[vwx_LineFolderItem_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LineFolderItem_SELECT]
GO

CREATE VIEW [dbo].[vwx_LineFolderItem_SELECT]
AS
SELECT lfi.LineFolderID, lfi.LineFolderItemID, lfi.LineItemFolder1, lfi.LineItemFolder2, lfi.LineItemFolder3, 
	   lfi.LineItemFolder4, lfi.LineItemFolder5, lfi.LineItemFolder6, lfi.LineItemFolder7, lfi.LineItemFolder8, 
	   lfi.LineItemFolder9, lfi.LineFolderItemDrop, lfi.LineFolderItemDropUser, lfi.LineFolderItemDropDate, 
	   lfi.LineFolderImageID, lfi.LineFolderImageVersion, lfi.CUser, lfi.CDate, lfi.MUser, lfi.MDate, lfi.MChange, 
	   sh.StyleID, sh.DevelopmentNo + '*' + CAST(sdi.Variation AS NVARCHAR(5)) AS ConceptNo, sh.DevelopmentNo, 
	   sh.StyleNo, sh.CustomField1, sh.CustomField5 AS PatternRef, sh.Description, sh.CustomField8 AS DMCStyleType, 
	   sm.F AS FabricYarnType, sm.MaterialName AS MainMaterial, sm.H AS [Content], sm.I AS FabricWeight, 
	   sh.SizeRangeId, COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   sh.SizeClassId, COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, 
       lf.SeasonYearID, lf.LineFolderTypeID, sh.DesignSketchID, sh.DesignSketchVersion, lfi.LineFolderItemSort, 
	   sh.StyleCategory, sh.StyleType, sh.WorkflowType, sh.DueDate, sh.RecDate, sh.TradePartnerID, sh.IntroSeasonYearID, 
       lfi.StyleSeasonYearID, ssy.SeasonYearID AS ColorwaySeasonYearID, sc.StyleCategory AS StyleCategoryName, perm.TeamId, 
	   perm.AccessRoleId, perm.AccessModify, sh.CustomField3 AS styleStatus, lfi.StyleBOMDimensionID, 
	   wfi.WorkFlowItemName AS BOMName, sh.DivisionID, sh.SubCategoryId, 
       '<img src="' + REPLACE(dbo.fnx_GetStreamingImageSmallPath(sh.DesignSketchID, sh.DesignSketchVersion), 'S=500', 'S=50') + '" alt="" />' AS [Image], 
	   sh.DevelopmentID, d.Custom AS DivisionName, st.StyleTypeDescription, ssc.Custom AS SubCategoryName,
       '<a href="Line_List_Folder_Style.aspx?SID=' + CAST(sh.StyleID AS NVARCHAR(50)) + '&LFID=' + 
	    CAST(lf.LineFolderID AS NVARCHAR(50)) + '&LFIID=' + CAST(lfi.LineFolderItemID AS NVARCHAR(50)) + '">' + sh.StyleNo + '</a>' AS StylePropertyLink                      
FROM pLineFolderItem lfi 
INNER JOIN dbo.pStyleHeader sh ON lfi.StyleID = sh.StyleID 
INNER JOIN vwx_Permissions_ProductTypes perm ON sh.StyleType = perm.IntProductTypeId AND perm.PermissionFolderTypeId = 2 
INNER JOIN dbo.pStyleDevelopmentItem sdi ON sh.StyleID = sdi.StyleID 
INNER JOIN dbo.pLineFolder lf ON lfi.LineFolderID = lf.LineFolderID 
INNER JOIN dbo.pStyleCategory sc ON sh.StyleCategory = sc.StyleCategoryId 
LEFT JOIN dbo.pStyleSeasonYear ssy ON lfi.StyleSeasonYearID = ssy.StyleSeasonYearID 
LEFT JOIN dbo.pStyleMaterials sm ON sh.StyleID = sm.StyleID AND 
								    sh.StyleSet = sm.StyleSet AND 
								    sm.MainMaterial = 1 
LEFT JOIN dbo.pStyleBOMDimension sbd ON lfi.StyleBOMDimensionID = sbd.StyleBOMDimensionID 
LEFT JOIN dbo.pWorkFlowItem wfi ON sbd.WorkFlowItemID = wfi.WorkFlowItemID 
LEFT JOIN dbo.iCustom1 d ON sh.DivisionID = d.CustomID 
LEFT JOIN dbo.pStyleType st ON sh.StyleType = st.StyleTypeID 
LEFT JOIN dbo.pSubCategory ssc ON sh.SubCategoryId = CAST(ssc.CustomID AS NVARCHAR(200))
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09891', GetDate())
GO
