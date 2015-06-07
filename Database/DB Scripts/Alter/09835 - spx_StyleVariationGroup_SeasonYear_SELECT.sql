IF OBJECT_ID(N'[dbo].[spx_StyleVariationGroup_SeasonYear_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleVariationGroup_SeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleVariationGroup_SeasonYear_SELECT](
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
)
AS 


SELECT DISTINCT a.StyleDevelopmentName, a.StyleDevelopmentID, a.Variation, a.StyleID, 
                COALESCE(sc.Custom, c.SizeClass) AS SizeClass
FROM pStyleDevelopmentItem a WITH(NOLOCK)
INNER JOIN dbo.pStyleSeasonYear b WITH(NOLOCK) ON a.StyleID = b.StyleID
INNER JOIN dbo.pStyleHeader c WITH(NOLOCK) ON a.StyleID = c.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = c.SizeClassId
WHERE a.StyleDevelopmentID = @StyleDevelopmentID
	AND b.SeasonYearID = @SeasonYearID
ORDER BY a.Variation



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09835', GetDate())
GO
