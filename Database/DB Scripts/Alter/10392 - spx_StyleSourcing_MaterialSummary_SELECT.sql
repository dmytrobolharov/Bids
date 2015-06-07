IF OBJECT_ID(N'[dbo].[spx_StyleSourcing_MaterialSummary_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSourcing_MaterialSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleSourcing_MaterialSummary_SELECT] (
@StyleID uniqueidentifier,
@StyleSet int,
@StyleSourcingID uniqueidentifier,
@StyleColorID uniqueidentifier
)
AS

SELECT a.*, b.MainMaterial , b.MaterialType, '' AS GroupName, c.ComponentDescription,
b.MaterialNo, b.MaterialName, b.UOM , b.MaterialID,
dbo.fnx_GetStreamingImageHTML(b.MaterialImageID, b.MaterialImageVersion, 50, '') AS MaterialImage,
ISNULL (b.MaterialSize , 'NA*') AS MaterialSize, 
dbo.fnx_GetStreamingColorImageHTML(e.ColorFolderID, e.ColorPaletteID, 40, '') AS Color,
e.ColorPaletteID, ISNULL ( b.MaterialSizeID , '00000000-0000-0000-0000-000000000000' ) AS MaterialSizeID
FROM pStyleSourcingItem  a
INNER JOIN pStyleMaterials b ON a.StyleMaterialID =  b.StyleMaterialID 
INNER JOIN pComponentType c ON b.MaterialType  = c.ComponentTypeID
LEFT OUTER JOIN pStyleColorwayItem d ON d.StyleColorID = a.StyleColorID  AND d.StyleMaterialID = a.StyleMaterialID
LEFT OUTER JOIN pMaterialColor e ON e.MaterialColorID = d.MaterialColorID 
WHERE a.StyleSourcingID = @StyleSourcingID
AND a.StyleSet = @StyleSet 
AND a.StyleColorID = @StyleColorID 
ORDER BY b.MainMaterial DESC, c.ComponentOrder, 
b.MaterialSort, b.MaterialNo, b.MaterialName, b.StyleMaterialId 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10392', GetUTCDate())
GO
