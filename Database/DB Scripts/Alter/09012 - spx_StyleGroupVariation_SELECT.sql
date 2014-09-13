IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleGroupVariation_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleGroupVariation_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_StyleGroupVariation_SELECT]
(@StyleDevelopmentId uniqueidentifier,
@Variation int)
AS 

SELECT     dbo.pStyleDevelopmentItem.StyleDevelopmentID, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.Description, dbo.pStyleDevelopmentItem.StyleID, 
                      dbo.pStyleDevelopmentItem.Variation, dbo.pStyleHeader.SizeClass, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.DesignSketchVersion,
					  dbo.pStyleHeader.DesignSketchBackID, dbo.pStyleHeader.DesignSketchBackVersion
FROM         dbo.pStyleDevelopmentItem WITH (NOLOCK) INNER JOIN
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleDevelopmentItem.StyleID = dbo.pStyleHeader.StyleID
WHERE     (dbo.pStyleDevelopmentItem.StyleDevelopmentID = @StyleDevelopmentId) AND (dbo.pStyleDevelopmentItem.Variation = @Variation)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09012', GetDate())
GO
