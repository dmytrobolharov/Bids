IF OBJECT_ID(N'[dbo].[spx_StyleGroupVariation_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleGroupVariation_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleGroupVariation_SELECT]
(@StyleDevelopmentId uniqueidentifier,
@Variation int)
AS 

SELECT dbo.pStyleDevelopmentItem.StyleDevelopmentID, sh.StyleNo, sh.Description, dbo.pStyleDevelopmentItem.StyleID, 
       dbo.pStyleDevelopmentItem.Variation, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, sh.DesignSketchID, 
	   sh.DesignSketchVersion, sh.DesignSketchBackID, sh.DesignSketchBackVersion
FROM dbo.pStyleDevelopmentItem WITH (NOLOCK) 
INNER JOIN dbo.pStyleHeader sh WITH (NOLOCK) ON dbo.pStyleDevelopmentItem.StyleID = sh.StyleID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE (dbo.pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentId) AND (dbo.pStyleDevelopmentItem.Variation = @Variation)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09796', GetDate())
GO
