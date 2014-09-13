IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimcolorMgmtHdr_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimcolorMgmtHdr_select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOMDimcolorMgmtHdr_select]
(
@StyleColorid uniqueidentifier
)

AS

begin
	select ColorPaletteID, ColorFolderID,  ColorCode, ColorName from 
    pColorPalette where ColorPaletteID=@StyleColorid
end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03104'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03104', GetDate())

END

GO