IF OBJECT_ID(N'[dbo].[spx_MaterialCoreColors_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_MaterialCoreColors_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialCoreColors_SELECT] 
(
 @MaterialCoreID UNIQUEIDENTIFIER 
)
AS 
BEGIN

  SELECT a.MaterialCoreColorID , b.ColorCode, b.ColorName, b.ColorPaletteID ,  
         dbo.fnx_GetStreamingColorImageHTML(b.ColorFolderID, b.ColorPaletteID, 25, '') AS ColorImagePath
  FROM dbo.pMaterialCoreColor a
  INNER JOIN dbo.pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
  WHERE a.MaterialCoreID = @MaterialCoreID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10364', GetUTCDate())
GO
