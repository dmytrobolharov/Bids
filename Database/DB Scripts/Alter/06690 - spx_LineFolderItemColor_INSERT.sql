IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemColor_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemColor_INSERT]
GO


CREATE  PROCEDURE [dbo].[spx_LineFolderItemColor_INSERT]
(@StyleID uniqueidentifier,
@StyleColorID uniqueidentifier,
@ColorPaletteID uniqueidentifier = null,
@LineFolderItemID uniqueidentifier,
@LineFolderID uniqueidentifier,
@ModifiedDate datetime,
@ModifiedBy nvarchar(200))
AS 
IF @StyleColorID IS NOT NULL
BEGIN
	INSERT INTO dbo.pLineFolderItemColor
						  (LineFolderItemID, LineFolderID, StyleColorID, StyleID, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, 
						  MDate, MUser, LineFolderItemColorDrop)
	SELECT     @LineFolderItemID, @LineFolderID, StyleColorID, StyleID, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, 
						  CUser, @ModifiedDate, @ModifiedBy, 0 AS LineFolderItemColorDrop
	FROM         dbo.pStyleColorway WITH (NOLOCK) 
	WHERE     (StyleID = @StyleID) AND  (StyleColorID = @StyleColorID)
END
ELSE
BEGIN
	INSERT INTO dbo.pLineFolderItemColor
		(LineFolderItemID, LineFolderID, StyleColorID, StyleID, StyleColorStandardID, StyleColorNo, StyleColorName, MainColor, Sort, Version, CDate, CUser, 
		MDate, MUser, LineFolderItemColorDrop, ColorPaletteID)
	SELECT TOP 1 @LineFolderItemID, @LineFolderID, NULL, StyleID, NULL, ColorCode, ColorName, ColorName, a.Sort, NULL, CDate, 
		CUser, @ModifiedDate, @ModifiedBy, 0 AS LineFolderItemColorDrop, @ColorPaletteID
	FROM dbo.pStyleColorwaySeasonYear a WITH (NOLOCK) INNER JOIN
		dbo.pColorPalette b WITH (NOLOCK) ON a.ColorPaletteID = b.ColorPaletteID
	WHERE  (StyleID = @StyleID) AND  (a.ColorPaletteID = @ColorPaletteID)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06690', GetDate())
GO
