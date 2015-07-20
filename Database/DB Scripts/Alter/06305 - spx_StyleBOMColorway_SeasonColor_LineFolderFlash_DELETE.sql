IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMColorway_SeasonColor_LineFolderFlash_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMColorway_SeasonColor_LineFolderFlash_DELETE]
GO

CREATE PROCEDURE [dbo].[spx_StyleBOMColorway_SeasonColor_LineFolderFlash_DELETE] 
	@LineFolderItemID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER
AS
BEGIN

	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER
	SELECT @StyleBOMDimensionID = StyleBOMDimensionID FROM pLineFolderItem WHERE LineFolderItemID = @LineFolderItemID
	
	IF @StyleBOMDimensionID IS NOT NULL AND @StyleBOMDimensionID <> '00000000-0000-0000-0000-000000000000'
	BEGIN
		EXEC spx_StyleBOMDimItem_DELETE
				@StyleBOMDimensionID = @StyleBOMDimensionID,	
				@DimID = @ColorPaletteID
	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06305', GetDate())
GO
