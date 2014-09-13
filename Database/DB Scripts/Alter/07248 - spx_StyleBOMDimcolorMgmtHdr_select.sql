/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimcolorMgmtHdr_select]    Script Date: 03/18/2014 12:46:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimcolorMgmtHdr_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimcolorMgmtHdr_select]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimcolorMgmtHdr_select]    Script Date: 03/18/2014 12:46:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE PROCEDURE [dbo].[spx_StyleBOMDimcolorMgmtHdr_select]
(
@StyleColorID UNIQUEIDENTIFIER
)

AS
BEGIN
	SELECT palette.ColorPaletteID, palette.ColorFolderID,  palette.ColorCode, palette.ColorName 
	FROM pStyleColorway colorway INNER JOIN pColorPalette palette ON colorway.ColorPaletteID = palette.ColorPaletteID
	WHERE colorway.StyleColorID=@StyleColorID
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07248', GetDate())
GO
