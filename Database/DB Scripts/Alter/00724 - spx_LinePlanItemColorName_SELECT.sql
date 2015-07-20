IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LinePlanItemColorName_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_LinePlanItemColorName_SELECT]
GO


CREATE PROCEDURE [dbo].[spx_LinePlanItemColorName_SELECT](@ColorPaletteID uniqueidentifier)
AS 

SELECT 
		'<table><tr><td>
		<img src="../System/Control/ColorStream.ashx?S=16&CFID=' + CAST(pColorPalette.ColorFolderID AS NVARCHAR(50)) -- #01
		+ '&CPID=' + CAST(pColorPalette.ColorPaletteID AS NVARCHAR(50)) +  '" border="0" /></td><td class="fontHead">' + pColorPalette.ColorName + '</td></tr></table>'  
		AS ColorUrl	

FROM  pColorPalette WITH (NOLOCK)
WHERE pColorPalette.ColorPaletteID = @ColorPaletteID



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '724', GetDate())
GO
