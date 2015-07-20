IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Color_Image_Details_SELECT]'))
DROP VIEW [dbo].[vwx_Color_Image_Details_SELECT]
GO


CREATE VIEW [dbo].[vwx_Color_Image_Details_SELECT]
AS
SELECT pColorPalette.ColorPaletteID, pColorPalette.ImageVersion AS ColorVersion, hImage.ImageLocation AS ColorImageLocation,pImage.*    
FROM       pColorPalette
INNER JOIN pImage ON pColorPalette.ImageID = pImage.ImageID
INNER JOIN hImage ON pImage.ImageID = hImage.ImageID AND pColorPalette.ImageVersion = himage.Version

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10432', GetUTCDate())
GO
