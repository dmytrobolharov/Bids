/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_Colorway_SELECT]    Script Date: 03/18/2014 13:27:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Colorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_Colorway_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_Colorway_SELECT]    Script Date: 03/18/2014 13:27:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[spx_StyleBOM_Colorway_SELECT]
	@StyleBOMDimensionId UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @StyleBOMColorColumn nVARCHAR(200) = ''
	DECLARE @ColorDimLevel INT = 0
	
	EXEC spx_StyleBOM_GetDimensionLevel_SELECT @StyleBOMDimensionID = @StyleBOMDimensionID,
												@DimensionTypeName = 'COLOR',
												@DimLevel = @ColorDimLevel OUT
												
	IF @ColorDimLevel = 1
		SET @StyleBOMColorColumn = 'ItemDim1ID'
	ELSE IF @ColorDimLevel = 2
		SET @StyleBOMColorColumn = 'ItemDim2ID'
	ELSE IF @ColorDimLevel = 3
		SET @StyleBOMColorColumn = 'ItemDim3ID'
	
	
	IF @StyleBOMColorColumn <> ''
	BEGIN
		
		DECLARE @StrSQL NVARCHAR(MAX)
		SET @StrSQL = ' SELECT colorway.StyleColorID, palette.ColorPaletteID, palette.ColorCode, palette.ColorName, palette.ColorFolderID 
		FROM pStyleBOMDimensionItem bom
		INNER JOIN pStyleColorway colorway ON bom.' + @StyleBOMColorColumn + ' = colorway.StyleColorID
		INNER JOIN pColorPalette palette ON colorway.ColorPaletteID = palette.ColorPaletteID
		WHERE StyleBOMDimensionID = ''' + CAST(@StyleBOMDimensionId AS NVARCHAR(50)) + ''' 
		ORDER BY palette.ColorCode, palette.ColorName '
		
		EXEC sp_executesql @StrSQL
		
	END
	ELSE
	BEGIN
		SELECT colorway.StyleColorID, palette.ColorPaletteID, palette.ColorCode, palette.ColorName, palette.ColorFolderID 
		FROM pStyleBOMDimensionItem bom
		INNER JOIN pStyleColorway colorway ON bom.ItemDim1Id = colorway.StyleColorID
		INNER JOIN pColorPalette palette ON colorway.ColorPaletteID = palette.ColorPaletteID
		WHERE 1 = 2
	END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07263', GetDate())
GO
