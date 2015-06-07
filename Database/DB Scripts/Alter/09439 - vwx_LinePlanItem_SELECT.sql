IF OBJECT_ID(N'[dbo].[vwx_LinePlanItem_SELECT]') IS NOT NULL
 DROP VIEW [dbo].[vwx_LinePlanItem_SELECT]
GO

CREATE VIEW [dbo].[vwx_LinePlanItem_SELECT]
AS
SELECT TOP (100) PERCENT lpi.LinePlanItemID, sh.StyleNo, sh.Description, 
	   COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, lpi.CustomField2
FROM pLinePlanItem lpi 
INNER JOIN pStyleHeader sh ON lpi.StyleID = sh.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
ORDER BY sh.StyleNo

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09439', GetDate())
GO
