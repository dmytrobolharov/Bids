/****** Object:  View [dbo].[vwx_LineListFlashCosting_SELECT]    Script Date: 12/14/2012 15:46:06 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_LineListFlashCosting_SELECT]'))
DROP VIEW [dbo].[vwx_LineListFlashCosting_SELECT]
GO

/****** Object:  View [dbo].[vwx_LineListFlashCosting_SELECT]    Script Date: 12/14/2012 15:46:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_LineListFlashCosting_SELECT]
AS
SELECT     llfc.LineFolderItemID, llfc.MaterialID, llfc.DutyCategory, llfc.MaterialCost, llfc.LaborCost, llfc.AddedCost, llfc.FlashCostFOB, llfc.DutyP, llfc.Duty, llfc.Variance, 
                      llfc.FlashCostLDP, llfc.WholesaleMU, llfc.RetailMU, llfc.WholesalePrice, llfc.RetailPrice, sh.StyleID, sh.StyleNo, sh.Description, sh.StyleCategory AS StyleCategoryID, 
                      sc.StyleCategory, sh.SizeClass, ssy.StyleSeason, ssy.StyleYear, fcd.DutyCategoryName, fcd.DutyCategoryCode, lfi.LineFolderID, lfi.LineFolderItemDrop
FROM         dbo.pLineListFlashCosting AS llfc INNER JOIN
                      dbo.pLineFolderItem AS lfi ON lfi.LineFolderItemID = llfc.LineFolderItemID INNER JOIN
                      dbo.pStyleHeader AS sh ON sh.StyleID = lfi.StyleID INNER JOIN
                      dbo.pStyleSeasonYear AS ssy ON ssy.StyleID = sh.StyleID AND ssy.StyleSeasonYearID = lfi.StyleSeasonYearID INNER JOIN
                      dbo.pStyleCategory AS sc ON sc.StyleCategoryId = sh.StyleCategory LEFT OUTER JOIN
                      dbo.pFlashCostDuty AS fcd ON fcd.FlashCostDutyID = llfc.DutyCategory
WHERE     (lfi.LineFolderItemDrop <> 'Yes')

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04635', GetDate())
GO
