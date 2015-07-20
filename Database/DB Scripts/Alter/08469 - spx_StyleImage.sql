IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleImage]
GO

CREATE PROCEDURE [dbo].[spx_StyleImage](@StyleID uniqueidentifier)
AS SELECT     dbo.pStyleHeader.StyleID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.TechSketchVersion, dbo.pStyleHeader.ConceptSketchID, dbo.pStyleHeader.ConceptSketchVersion, dbo.pStyleHeader.ColorSketchID, 
                      dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleImage.SpecSketchID1, dbo.pStyleImage.SpecSketchID2, dbo.pStyleImage.SpecSketchID3, 
                      dbo.pStyleImage.SpecSketchID4, dbo.pStyleImage.SpecSketchVersion1, dbo.pStyleImage.SpecSketchVersion2, dbo.pStyleImage.SpecSketchVersion3, 
                      dbo.pStyleImage.SpecSketchVersion4, dbo.pStyleImage.DetailSketchID1, dbo.pStyleImage.DetailSketchID2, dbo.pStyleImage.DetailSketchID3, 
                      dbo.pStyleImage.DetailSketchID4, dbo.pStyleImage.DetailSketchID11, dbo.pStyleImage.DetailSketchID12, dbo.pStyleImage.DetailSketchID21, 
                      dbo.pStyleImage.DetailSketchID22, dbo.pStyleImage.DetailSketchID31, dbo.pStyleImage.DetailSketchID32, dbo.pStyleImage.DetailSketchID41, 
                      dbo.pStyleImage.DetailSketchID42, dbo.pStyleImage.DetailSketchVersion1, dbo.pStyleImage.DetailSketchVersion2, 
                      dbo.pStyleImage.DetailSketchVersion3, dbo.pStyleImage.DetailSketchVersion4, dbo.pStyleImage.DetailSketchVersion11, 
                      dbo.pStyleImage.DetailSketchVersion12, dbo.pStyleImage.DetailSketchVersion21, dbo.pStyleImage.DetailSketchVersion22, 
                      dbo.pStyleImage.DetailSketchVersion31, dbo.pStyleImage.DetailSketchVersion32, dbo.pStyleImage.DetailSketchVersion41, 
                      dbo.pStyleImage.DetailSketchVersion42, dbo.pStyleImage.MaterialImageID, dbo.pStyleImage.MaterialImageVersion,
	         dbo.pStyleHeader.LinePlanSketchID , dbo.pStyleHeader.LinePlanSketchVersion , 
	         dbo.pStyleHeader.StyleSet ,  dbo.pStyleHeader.PC1, dbo.pStyleHeader.PC2, dbo.pStyleHeader.PC3, dbo.pStyleHeader.PC4,
	         dbo.pStyleHeader.DesignSketchBackID, dbo.pStyleHeader.DesignSketchBackVersion
FROM         dbo.pStyleHeader WITH (NOLOCK) LEFT OUTER JOIN
                      dbo.pStyleImage WITH (NOLOCK) ON dbo.pStyleHeader.StyleID = dbo.pStyleImage.StyleID
WHERE     (dbo.pStyleHeader.StyleID = @StyleID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08469', GetDate())
GO
