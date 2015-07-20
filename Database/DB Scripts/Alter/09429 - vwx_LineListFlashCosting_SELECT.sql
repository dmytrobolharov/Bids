IF OBJECT_ID(N'[dbo].[vwx_LineListFlashCosting_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LineListFlashCosting_SELECT]
GO

CREATE VIEW [dbo].[vwx_LineListFlashCosting_SELECT]
AS
SELECT llfc.LineFolderItemID, llfc.MaterialID, llfc.DutyCategory, llfc.MaterialCost, llfc.LaborCost, 
	   llfc.AddedCost, llfc.FlashCostFOB, llfc.DutyP, llfc.Duty, llfc.Variance, llfc.FlashCostLDP, 
	   llfc.WholesaleMU, llfc.RetailMU, llfc.WholesalePrice, llfc.RetailPrice, sh.StyleID, sh.StyleNo, 
	   sh.Description, sh.StyleCategory AS StyleCategoryID, sc.StyleCategory, 
	   COALESCE(scc.Custom, sh.SizeClass) AS SizeClass, ssy.StyleSeason, ssy.StyleYear, fcd.DutyCategoryName, 
	   fcd.DutyCategoryCode, lfi.LineFolderID, lfi.LineFolderItemDrop, lfi.LineFolderItemSort, sh.SubCategoryId, 
	   st.StyleTypeDescription
FROM pLineListFlashCosting AS llfc 
INNER JOIN pLineFolderItem AS lfi ON lfi.LineFolderItemID = llfc.LineFolderItemID 
INNER JOIN pStyleHeader AS sh ON sh.StyleID = lfi.StyleID 
INNER JOIN pStyleSeasonYear AS ssy ON ssy.StyleID = sh.StyleID AND ssy.StyleSeasonYearID = lfi.StyleSeasonYearID 
INNER JOIN pStyleCategory AS sc ON sc.StyleCategoryId = sh.StyleCategory 
INNER JOIN pStyleType AS st ON st.StyleTypeId = sh.StyleType 
LEFT JOIN pFlashCostDuty AS fcd ON fcd.FlashCostDutyID = llfc.DutyCategory 
LEFT JOIN pSizeClass scc ON scc.CustomID = sh.SizeClassId


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09429', GetDate())
GO
