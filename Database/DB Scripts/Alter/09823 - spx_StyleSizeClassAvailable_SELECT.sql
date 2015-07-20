IF OBJECT_ID(N'[dbo].[spx_StyleSizeClassAvailable_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSizeClassAvailable_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_StyleSizeClassAvailable_SELECT]
(@StyleId uniqueidentifier)
AS 

DECLARE @StyleDevelopmentID uniqueidentifier
DECLARE @Variation nvarchar(10)

SELECT @StyleDevelopmentID = StyleDevelopmentID, @Variation = Variation FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID

SELECT CustomKey, Custom 
FROM pSizeClass WITH (NOLOCK)
WHERE (Custom NOT IN (SELECT COALESCE(sc.Custom, sh.SizeClass)
	FROM  pStyleHeader sh WITH (NOLOCK) INNER JOIN
	pStyleDevelopmentItem WITH (NOLOCK) ON sh.StyleID = pStyleDevelopmentItem.StyleID AND 
	sh.DevelopmentID = pStyleDevelopmentItem.StyleDevelopmentID 
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	WHERE pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID AND pStyleDevelopmentItem.Variation = @Variation
	AND sh.StyleID <> @StyleID)) 
ORDER BY Custom

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09823', GetDate())
GO
