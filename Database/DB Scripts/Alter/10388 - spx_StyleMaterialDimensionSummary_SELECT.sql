IF OBJECT_ID(N'[dbo].[spx_StyleMaterialDimensionSummary_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleMaterialDimensionSummary_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleMaterialDimensionSummary_SELECT]
(
 @StyleID UNIQUEIDENTIFIER,
 @StyleSet INT 
)
AS 
BEGIN

  SELECT dbo.fnx_GetStreamingImageHTML(a.MaterialImageID, a.MaterialImageVersion, 100, '') AS ImagePath, a.*
  FROM pStyleMaterials a WITH(NOLOCK)
  WHERE a.StyleID = @StyleID AND a.StyleSet = @StyleSet
  ORDER BY a.MainMaterial DESC, a.MaterialType, a.MaterialSort, a.MaterialNo 

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10388', GetUTCDate())
GO
