IF OBJECT_ID(N'[dbo].[spx_StyleTechPackSize_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleTechPackSize_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleTechPackSize_SELECT]
(@StyledevelopmentId uniqueidentifier, @StyleVariation int)
AS 


SELECT sh.StyleID, sh.StyleNo, sh.DevelopmentNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
	   COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, sh.DevelopmentID, sh.TechPackId, 
	   sh.TechPackDate, sh.DueDate, pStyleDevelopmentItem.Variation
FROM pStyleHeader sh WITH (NOLOCK) 
INNER JOIN pStyleDevelopmentItem WITH (NOLOCK) ON sh.StyleID = pStyleDevelopmentItem.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE (sh.DevelopmentID = @StyleDevelopmentId) AND (pStyleDevelopmentItem.Variation = @StyleVariation)
ORDER BY sh.CDate

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09834', GetDate())
GO
