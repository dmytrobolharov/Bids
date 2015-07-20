/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_CheckColorCodeUnique]    Script Date: 07/30/2012 12:38:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_CheckColorCodeUnique]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_CheckColorCodeUnique]
GO

/****** Object:  StoredProcedure [dbo].[spx_ColorFolder_CheckColorCodeUnique]    Script Date: 07/30/2012 12:38:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Description:	Returns the amount of colors with given code in given folder
-- =============================================
CREATE PROCEDURE [dbo].[spx_ColorFolder_CheckColorCodeUnique]
	@ColorFolderID uniqueidentifier,
	@ColorPaletteID uniqueidentifier = NULL, -- ID of currently editing color, which shouldn't be included in results
	@ColorCode nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @ColorCodeCount int
	-- For creating new color palette (checks all records)
	IF @ColorPaletteID IS NULL
		BEGIN
			SELECT @ColorCodeCount = COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode
		END
	-- For editing an existing color palette (checks all records, except for current)
	ELSE
		BEGIN
			SELECT @ColorCodeCount = COUNT(*) FROM pColorPalette WITH (NOLOCK) WHERE ColorFolderID = @ColorFolderID  AND  ColorCode = @ColorCode AND NOT ColorPaletteID = @ColorPaletteID
		END
		
    RETURN @ColorCodeCount
END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03728', GetDate())
GO