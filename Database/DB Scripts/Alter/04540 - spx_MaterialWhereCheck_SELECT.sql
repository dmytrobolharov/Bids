/****** Object:  StoredProcedure [dbo].[spx_MaterialWhereCheck_SELECT]    Script Date: 12/05/2012 11:47:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWhereCheck_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWhereCheck_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_MaterialWhereCheck_SELECT]    Script Date: 12/05/2012 11:47:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_MaterialWhereCheck_SELECT](@MaterialID uniqueidentifier)
AS SELECT     dbo.pStyleHeader.StyleID, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.RefNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomerNo, 
                      dbo.pStyleHeader.SpecNo, dbo.pStyleHeader.Description, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, 
                      dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.TechSketchVersion, 
                      dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleHeader.DetailSketchID1, dbo.pStyleHeader.DetailSketchID2, dbo.pStyleHeader.DetailSketchID3, 
                      dbo.pStyleHeader.DetailSketchID4, dbo.pStyleHeader.DetailSketchVersion1, dbo.pStyleHeader.DetailSketchVersion2, 
                      dbo.pStyleHeader.DetailSketchVersion3, dbo.pStyleHeader.DetailSketchVersion4, dbo.pStyleHeader.SpecSketchID1, dbo.pStyleHeader.SpecSketchID2, 
                      dbo.pStyleHeader.SpecSketchID3, dbo.pStyleHeader.SpecSketchID4, dbo.pStyleHeader.SpecSketchVersion1, dbo.pStyleHeader.SpecSketchVersion2, 
                      dbo.pStyleHeader.SpecSketchVersion3, dbo.pStyleHeader.SpecSketchVersion4
FROM         dbo.pStyleMaterials WITH (NOLOCK) INNER JOIN
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleMaterials.StyleID = dbo.pStyleHeader.StyleID
WHERE     (dbo.pStyleMaterials.MaterialID = @MaterialID)
GROUP BY dbo.pStyleHeader.StyleID, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.RefNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomerNo, 
                      dbo.pStyleHeader.SpecNo, dbo.pStyleHeader.Description, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, 
                      dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.TechSketchVersion, 
                      dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleHeader.DetailSketchID1, dbo.pStyleHeader.DetailSketchID2, dbo.pStyleHeader.DetailSketchID3, 
                      dbo.pStyleHeader.DetailSketchID4, dbo.pStyleHeader.DetailSketchVersion1, dbo.pStyleHeader.DetailSketchVersion2, 
                      dbo.pStyleHeader.DetailSketchVersion3, dbo.pStyleHeader.DetailSketchVersion4, dbo.pStyleHeader.SpecSketchID1, dbo.pStyleHeader.SpecSketchID2, 
                      dbo.pStyleHeader.SpecSketchID3, dbo.pStyleHeader.SpecSketchID4, dbo.pStyleHeader.SpecSketchVersion1, dbo.pStyleHeader.SpecSketchVersion2, 
                      dbo.pStyleHeader.SpecSketchVersion3, dbo.pStyleHeader.SpecSketchVersion4
                      
                      UNION
                      
                      SELECT     dbo.pStyleHeader.StyleID, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.RefNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomerNo, 
                      dbo.pStyleHeader.SpecNo, dbo.pStyleHeader.Description, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, 
                      dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.TechSketchVersion, 
                      dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleHeader.DetailSketchID1, dbo.pStyleHeader.DetailSketchID2, dbo.pStyleHeader.DetailSketchID3, 
                      dbo.pStyleHeader.DetailSketchID4, dbo.pStyleHeader.DetailSketchVersion1, dbo.pStyleHeader.DetailSketchVersion2, 
                      dbo.pStyleHeader.DetailSketchVersion3, dbo.pStyleHeader.DetailSketchVersion4, dbo.pStyleHeader.SpecSketchID1, dbo.pStyleHeader.SpecSketchID2, 
                      dbo.pStyleHeader.SpecSketchID3, dbo.pStyleHeader.SpecSketchID4, dbo.pStyleHeader.SpecSketchVersion1, dbo.pStyleHeader.SpecSketchVersion2, 
                      dbo.pStyleHeader.SpecSketchVersion3, dbo.pStyleHeader.SpecSketchVersion4
FROM         dbo.pStyleBOM WITH (NOLOCK) INNER JOIN
                      dbo.pStyleHeader WITH (NOLOCK) ON dbo.pStyleBOM.StyleID = dbo.pStyleHeader.StyleID
WHERE     (dbo.pStyleBOM.MaterialID = @MaterialID)
GROUP BY dbo.pStyleHeader.StyleID, dbo.pStyleHeader.StyleType, dbo.pStyleHeader.RefNo, dbo.pStyleHeader.StyleNo, dbo.pStyleHeader.CustomerNo, 
                      dbo.pStyleHeader.SpecNo, dbo.pStyleHeader.Description, dbo.pStyleHeader.SizeRange, dbo.pStyleHeader.DueDate, dbo.pStyleHeader.RecDate, 
                      dbo.pStyleHeader.StyleStatus, dbo.pStyleHeader.MaterialImageID, dbo.pStyleHeader.DesignSketchID, dbo.pStyleHeader.TechSketchID, 
                      dbo.pStyleHeader.ColorSketchID, dbo.pStyleHeader.DesignSketchVersion, dbo.pStyleHeader.TechSketchVersion, 
                      dbo.pStyleHeader.ColorSketchVersion, dbo.pStyleHeader.DetailSketchID1, dbo.pStyleHeader.DetailSketchID2, dbo.pStyleHeader.DetailSketchID3, 
                      dbo.pStyleHeader.DetailSketchID4, dbo.pStyleHeader.DetailSketchVersion1, dbo.pStyleHeader.DetailSketchVersion2, 
                      dbo.pStyleHeader.DetailSketchVersion3, dbo.pStyleHeader.DetailSketchVersion4, dbo.pStyleHeader.SpecSketchID1, dbo.pStyleHeader.SpecSketchID2, 
                      dbo.pStyleHeader.SpecSketchID3, dbo.pStyleHeader.SpecSketchID4, dbo.pStyleHeader.SpecSketchVersion1, dbo.pStyleHeader.SpecSketchVersion2, 
                      dbo.pStyleHeader.SpecSketchVersion3, dbo.pStyleHeader.SpecSketchVersion4
ORDER BY dbo.pStyleHeader.StyleNo


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04540', GetDate())
GO

