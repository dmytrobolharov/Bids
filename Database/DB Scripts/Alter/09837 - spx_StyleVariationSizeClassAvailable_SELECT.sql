IF OBJECT_ID(N'[dbo].[spx_StyleVariationSizeClassAvailable_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleVariationSizeClassAvailable_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleVariationSizeClassAvailable_SELECT]
(@StyleId uniqueidentifier)
AS 

DECLARE @StyleDevelopmentID uniqueidentifier
DECLARE @Variation nvarchar(10)

SELECT @StyleDevelopmentID = StyleDevelopmentID, @Variation = Variation FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID

SELECT sh.StyleID, COALESCE(sc.Custom, sh.SizeClass) + ' (' + COALESCE(sr.SizeRangeCode, sh.SizeRange) + ')' AS SizeRange
FROM  pStyleHeader sh WITH (NOLOCK) 
INNER JOIN pStyleDevelopmentItem WITH (NOLOCK) ON sh.StyleID = pStyleDevelopmentItem.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE (pStyleDevelopmentItem.Variation = @Variation) AND (pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID)
ORDER BY sh.SizeClass

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09837', GetDate())
GO
