IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialWhereCheck_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialWhereCheck_SELECT]
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



DECLARE @Msg NVARCHAR(4000)
SET @Msg  = ''

IF EXISTS (SELECT * FROM pStyleMaterials WHERE MaterialID = @MaterialID)
	OR EXISTS (SELECT * FROM pStyleBOM WHERE MaterialID = @MaterialID)
	SET @Msg = 'it is being used in styles' 
ELSE IF EXISTS (SELECT * FROM pPlanningMaterial WHERE MaterialID = @MaterialID)
	SET @Msg = 'it is being used in Planning' 

SELECT @Msg

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08948', GetDate())
GO
