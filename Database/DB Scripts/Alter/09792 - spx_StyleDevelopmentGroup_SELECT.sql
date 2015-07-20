IF OBJECT_ID(N'[dbo].[spx_StyleDevelopmentGroup_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleDevelopmentGroup_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleDevelopmentGroup_SELECT]
(
@StyleID uniqueidentifier,
@StyleVariation nvarchar(5)
)
AS 

DECLARE @StyleDevelopmentID nvarchar(50)

SELECT @StyleDevelopmentID = StyleDevelopmentID FROM dbo.pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID

BEGIN
	SELECT dbo.pStyleDevelopmentItem.StyleDevelopmentItemID, dbo.pStyleDevelopment.StyleDevelopmentID, dbo.pStyleDevelopment.StyleDevelopmentNo, 
	dbo.pStyleDevelopmentItem.StyleID, dbo.pStyleDevelopmentItem.SizeRange, dbo.pStyleDevelopmentItem.Variation, 
	dbo.pStyleDevelopmentItem.CUser, dbo.pStyleDevelopmentItem.CDate, dbo.pStyleDevelopmentItem.MUser, dbo.pStyleDevelopmentItem.MDate, 
	COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, sh.Active, 
	CASE WHEN COALESCE(sc.Custom, sh.SizeClass) Is Null THEN COALESCE(sr.SizeRangeCode, sh.SizeRange) ELSE COALESCE(sc.Custom, sh.SizeClass) END AS DevelopmentHeader
	FROM dbo.pStyleDevelopment WITH (NOLOCK) INNER JOIN
	dbo.pStyleDevelopmentItem WITH (NOLOCK) ON dbo.pStyleDevelopment.StyleDevelopmentID = dbo.pStyleDevelopmentItem.StyleDevelopmentID INNER JOIN
	dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleDevelopmentItem.StyleID = sh.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
	LEFT JOIN pSizeRange sr ON sr.CustomId = sh.SizeRangeId
	WHERE (dbo.pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentID) AND ( dbo.pStyleDevelopmentItem.Variation = @StyleVariation)
	ORDER BY sh.CDate
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09792', GetDate())
GO
