IF OBJECT_ID(N'[dbo].[spx_StyleSizeCopyAvailable_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSizeCopyAvailable_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSizeCopyAvailable_SELECT]
(@StyleID uniqueidentifier)
AS 

DECLARE @StyleDevelopmentID uniqueidentifier
DECLARE @Variation nvarchar(10)

SELECT @StyleDevelopmentID = StyleDevelopmentID, @Variation = Variation FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID


SELECT sh.StyleId, sh.StyleNo, 
       COALESCE(sr.SizeRangeCode, sh.SizeRange) AS SizeRange, 
	   COALESCE(sc.Custom, sh.SizeClass) AS SizeClass 
FROM pStyleHeader sh WITH (NOLOCK)
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
LEFT JOIN pSizeRange sr ON sr.CustomID = sh.SizeRangeId
WHERE (sh.StyleId IN (SELECT StyleId FROM pStyleDevelopmentItem WITH (NOLOCK) 
					  WHERE StyleDevelopmentID = @StyleDevelopmentID AND Variation = @Variation)) 
ORDER BY sh.CDate

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09825', GetDate())
GO
