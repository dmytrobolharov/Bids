/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_ColorwayByCodeName_DELETE]    Script Date: 03/18/2014 13:27:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_ColorwayByCodeName_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_ColorwayByCodeName_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_ColorwayByCodeName_DELETE]    Script Date: 03/18/2014 13:27:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOM_ColorwayByCodeName_DELETE]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@ColorCode NVARCHAR(200),
	@ColorName NVARCHAR(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @StyleID UNIQUEIDENTIFIER
	SELECT @StyleID = StyleID FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID
	
	DECLARE @StyleColorID UNIQUEIDENTIFIER
	SELECT @StyleColorID = colorway.StyleColorID FROM pStyleColorway colorway
	INNER JOIN pColorPalette palette ON colorway.ColorPaletteID = palette.ColorPaletteID
	WHERE colorway.StyleID = @StyleID AND palette.ColorCode = @ColorCode AND palette.ColorName = @ColorName
	
	IF @StyleColorID IS NOT NULL
	BEGIN
		EXEC spx_StyleBOMDimItem_DELETE @StyleBOMDimensionID, @StyleColorID
	END
	
END


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07264', GetDate())
GO
