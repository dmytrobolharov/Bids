IF OBJECT_ID(N'[dbo].[spx_StyleSizeDrop_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSizeDrop_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSizeDrop_SELECT]
(@StyleId uniqueidentifier,
@StyleDevelopmentId uniqueidentifier)
AS 

DECLARE @StyleVariation nvarchar(2)
SET @StyleVariation  = (SELECT TOP 1 Variation FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleDevelopmentId = @StyledevelopmentId AND StyleId = @StyleId)

SELECT sh.StyleID, sc.Custom + ' (' + sr.SizeRangeCode + ')' AS Size
FROM dbo.pStyleHeader sh WITH (NOLOCK) 
INNER JOIN dbo.pSizeRange sr WITH (NOLOCK) ON (sh.SizeRangeId IS NULL AND sh.SizeRange = sr.SizeRangeCode) OR
                                              (sh.SizeRangeId IS NOT NULL AND sh.SizeRangeId = sr.CustomId)
INNER JOIN dbo.pSizeClass sc WITH (NOLOCK) ON (sh.SizeClassId IS NULL AND sh.SizeClass = sc.Custom) OR
                                              (sh.SizeClassId IS NOT NULL AND sh.SizeClassId = sc.CustomId)
INNER JOIN dbo.pStyleDevelopmentItem WITH (NOLOCK) ON sh.StyleID = dbo.pStyleDevelopmentItem.StyleID AND 
                                                      sh.DevelopmentID = dbo.pStyleDevelopmentItem.StyleDevelopmentID
WHERE     (sh.StyleID <> @StyleId)
 AND (sh.DevelopmentID = @StyleDevelopmentId) 
 AND (dbo.pStyleDevelopmentItem.Variation = @StyleVariation)
 AND (sh.Active = 1)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09826', GetDate())
GO
