IF OBJECT_ID(N'[dbo].[spx_StyleDevelopmentItems_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleDevelopmentItems_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleDevelopmentItems_SELECT]
(@StyleDevelopmentID uniqueidentifier)
AS 

SELECT pStyleDevelopmentItem.StyleDevelopmentItemID, pStyleDevelopmentItem.StyleDevelopmentID, sh.StyleID, 
      pStyleDevelopmentItem.Variation, sh.DevelopmentNo, sh.StyleNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
      COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	  'VAR #: ' + CAST(pStyleDevelopmentItem.Variation AS nVARCHAR(4)) + ' Style #: ' + sh.StyleNo + ' - ' + 
	  COALESCE(sc.Custom, sh.SizeClass) + ' (' +  COALESCE(sr.SizeRangeCode, sh.SizeRange) + ')' AS VariationName
FROM  pStyleDevelopmentItem 
INNER JOIN pStyleHeader sh ON pStyleDevelopmentItem.StyleID = sh.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
WHERE pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID
ORDER BY pStyleDevelopmentItem.Variation, sh.StyleNo

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09793', GetDate())
GO
