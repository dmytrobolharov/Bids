/****** Object:  StoredProcedure [dbo].[spx_StyleVariationGroup_SeasonYear_SELECT]    Script Date: 03/26/2014 10:54:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleVariationGroup_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleVariationGroup_SeasonYear_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleVariationGroup_SeasonYear_SELECT]    Script Date: 03/26/2014 10:54:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleVariationGroup_SeasonYear_SELECT](
	@StyleDevelopmentID UNIQUEIDENTIFIER,
	@SeasonYearID UNIQUEIDENTIFIER
)
AS 


SELECT DISTINCT a.StyleDevelopmentName, a.StyleDevelopmentID, a.Variation, a.StyleID, c.SizeClass
FROM pStyleDevelopmentItem a WITH(NOLOCK)
	INNER JOIN dbo.pStyleSeasonYear b WITH(NOLOCK) ON a.StyleID = b.StyleID
	INNER JOIN dbo.pStyleHeader c WITH(NOLOCK) ON a.StyleID = c.StyleID
WHERE a.StyleDevelopmentID = @StyleDevelopmentID
	AND b.SeasonYearID = @SeasonYearID
ORDER BY a.Variation


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07367', GetDate())
GO
