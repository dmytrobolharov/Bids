IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackStyleVariation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackStyleVariation_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_TechPackStyleVariation_SELECT]
	@StyleID [uniqueidentifier]
	, @SeasonYearID [uniqueidentifier] = NULL
WITH EXECUTE AS CALLER
AS
DECLARE @StyleDevelopmentId uniqueidentifier

BEGIN
SELECT TOP 1 @StyleDevelopmentId = StyleDevelopmentId FROM dbo.pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID
END


IF @SeasonYearID IS NOT NULL
BEGIN
	SELECT StyleDevelopmentItemID, StyleDevelopmentID, StyleDevelopmentName, Variation,
		dbo.pStyleHeader.StyleID, dbo.pStyleHeader.SizeClass
	FROM dbo.pStyleDevelopmentItem WITH (NOLOCK)
		INNER JOIN dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleHeader.StyleID
		INNER JOIN dbo.pStyleSeasonYear WITH (NOLOCK) ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleSeasonYear.StyleID
	WHERE (StyleDevelopmentID = @StyleDevelopmentID)
		AND dbo.pStyleSeasonYear.SeasonYearID = @SeasonYearID
	ORDER BY Variation ASC
END
ELSE
BEGIN
	SELECT StyleDevelopmentItemID, StyleDevelopmentID, StyleDevelopmentName, Variation,
		dbo.pStyleHeader.StyleID, dbo.pStyleHeader.SizeClass
	FROM dbo.pStyleDevelopmentItem WITH (NOLOCK)
		INNER JOIN dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleHeader.StyleID
	WHERE (StyleDevelopmentID = @StyleDevelopmentID)
	ORDER BY Variation ASC
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07579', GetDate())
GO
