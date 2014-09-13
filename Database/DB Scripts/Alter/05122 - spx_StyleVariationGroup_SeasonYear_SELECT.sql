IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleVariationGroup_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleVariationGroup_SeasonYear_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleVariationGroup_SeasonYear_SELECT](
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
)
AS 


SELECT DISTINCT a.StyleDevelopmentName, a.StyleDevelopmentID, a.Variation, a.StyleID
FROM pStyleDevelopmentItem a WITH(NOLOCK)
	INNER JOIN dbo.pStyleSeasonYear b WITH(NOLOCK) ON a.StyleID = b.StyleID
WHERE a.StyleDevelopmentID = @StyleDevelopmentID
	AND b.SeasonYearID = @SeasonYearID
ORDER BY a.Variation
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05122', GetDate())
GO
