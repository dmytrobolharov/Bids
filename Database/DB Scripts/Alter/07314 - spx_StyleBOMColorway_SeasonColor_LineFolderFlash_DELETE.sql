IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMColorway_SeasonColor_LineFolderFlash_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMColorway_SeasonColor_LineFolderFlash_DELETE]
GO



CREATE PROCEDURE [dbo].[spx_StyleBOMColorway_SeasonColor_LineFolderFlash_DELETE] 
	@LineFolderItemID UNIQUEIDENTIFIER,
	@StyleBOMDimensionID UNIQUEIDENTIFIER,	
	@ColorPaletteID UNIQUEIDENTIFIER
AS
BEGIN

	IF @StyleBOMDimensionID IS NOT NULL AND @StyleBOMDimensionID <> '00000000-0000-0000-0000-000000000000'
	BEGIN
	
		DECLARE @StyleColorID UNIQUEIDENTIFIER
	
		IF NOT EXISTS (SELECT * FROM pStyleColorway WHERE StyleColorID = @ColorPaletteID)
		BEGIN
			DECLARE @StyleID UNIQUEIDENTIFIER
			SELECT @StyleID = StyleID FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID
			SELECT @StyleColorID = StyleColorID FROM pStyleColorway WHERE StyleID = @StyleID AND ColorPaletteID = @ColorPaletteID
		END
		ELSE
		BEGIN
			SET @StyleColorID = @ColorPaletteID
		END
		
		DECLARE @Flag TABLE (Flag INT)
		INSERT INTO @Flag (Flag)
		EXEC spx_StyleBOMDimItem_IsUsed
				@StyleBOMDimensionID = @StyleBOMDimensionID,	
				@DimID = @StyleColorID
				
		IF (SELECT TOP 1 Flag FROM @Flag) = 0
		BEGIN
			EXEC spx_StyleBOMDimItem_DELETE
					@StyleBOMDimensionID = @StyleBOMDimensionID,	
					@DimID = @StyleColorID
		END
		
	END

END

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07314', GetDate())
GO
