IF OBJECT_ID(N'[dbo].[spx_TechPackStyleVariation_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_TechPackStyleVariation_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_TechPackStyleVariation_SELECT]
(	
	@StyleID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER = NULL
)
AS
BEGIN
	DECLARE @StyleDevelopmentId UNIQUEIDENTIFIER

	SELECT TOP 1 @StyleDevelopmentId = StyleDevelopmentId
	FROM dbo.pStyleDevelopmentItem
	WHERE StyleID = @StyleID

	IF @SeasonYearID IS NOT NULL
	BEGIN
		SELECT StyleDevelopmentItemID
			, StyleDevelopmentID
			, StyleDevelopmentName
			, Variation
			, sh.StyleID
			, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
		FROM dbo.pStyleDevelopmentItem
			INNER JOIN dbo.pStyleHeader sh ON dbo.pStyleDevelopmentItem.StyleID = sh.StyleID
			INNER JOIN dbo.pStyleSeasonYear ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE StyleDevelopmentID = @StyleDevelopmentID
			AND dbo.pStyleSeasonYear.SeasonYearID = @SeasonYearID
			AND sh.StyleID = @StyleID
		ORDER BY Variation ASC
	END
	ELSE
	BEGIN
		SELECT StyleDevelopmentItemID
			, StyleDevelopmentID
			, StyleDevelopmentName
			, Variation
			, sh.StyleID
			, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass
		FROM dbo.pStyleDevelopmentItem
			INNER JOIN dbo.pStyleHeader sh ON dbo.pStyleDevelopmentItem.StyleID = sh.StyleID
			LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
		WHERE StyleDevelopmentID = @StyleDevelopmentID
			AND sh.StyleID = @StyleID
		ORDER BY Variation ASC
	END
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09855', GetDate())
GO
