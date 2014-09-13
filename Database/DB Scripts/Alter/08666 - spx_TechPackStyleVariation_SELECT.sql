IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackStyleVariation_SELECT]') AND type in (N'P', N'PC'))
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
			, dbo.pStyleHeader.StyleID
			, dbo.pStyleHeader.SizeClass
		FROM dbo.pStyleDevelopmentItem
			INNER JOIN dbo.pStyleHeader ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleHeader.StyleID
			INNER JOIN dbo.pStyleSeasonYear ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
		WHERE StyleDevelopmentID = @StyleDevelopmentID
			AND dbo.pStyleSeasonYear.SeasonYearID = @SeasonYearID
			AND dbo.pStyleHeader.StyleID = @StyleID
		ORDER BY Variation ASC
	END
	ELSE
	BEGIN
		SELECT StyleDevelopmentItemID
			, StyleDevelopmentID
			, StyleDevelopmentName
			, Variation
			, dbo.pStyleHeader.StyleID
			, dbo.pStyleHeader.SizeClass
		FROM dbo.pStyleDevelopmentItem
			INNER JOIN dbo.pStyleHeader ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleHeader.StyleID
		WHERE StyleDevelopmentID = @StyleDevelopmentID
			AND dbo.pStyleHeader.StyleID = @StyleID
		ORDER BY Variation ASC
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08666', GetDate())
GO
