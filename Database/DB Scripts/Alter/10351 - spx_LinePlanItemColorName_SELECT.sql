IF OBJECT_ID(N'[dbo].[spx_LinePlanItemColorName_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_LinePlanItemColorName_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_LinePlanItemColorName_SELECT](@ColorPaletteID UNIQUEIDENTIFIER)
AS 
BEGIN

  SELECT '<table><tr><td>' + 
         dbo.fnx_GetStreamingColorImageHTML(ColorFolderID, ColorPaletteID, 16, 'border="0"') +
         '</td><td class="fontHead">' + ColorName + '</td></tr></table>' AS ColorUrl	
  FROM dbo.pColorPalette WITH (NOLOCK)
  WHERE ColorPaletteID = @ColorPaletteID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10351', GetUTCDate())
GO
