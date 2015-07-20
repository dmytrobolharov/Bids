/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_INSERT]    Script Date: 05/08/2013 12:21:07 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_TempColors_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_TempColors_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_INSERT]    Script Date: 05/08/2013 12:21:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_TempColors_INSERT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @IsInserted INT = 0
	
	-- Inserting the color to table of Temporary BOM Colors
	IF NOT EXISTS (SELECT * FROM pStyleBOMDimensionTempColor WHERE StyleBOMDimensionID = @StyleBOMDimensionID 
					AND ColorPaletteID = @ColorPaletteID AND TeamID = @TeamID)
	BEGIN
		INSERT INTO pStyleBOMDimensionTempColor (StyleBOMDimensionID, ColorPaletteID, TeamID)
		VALUES (@StyleBOMDimensionID, @ColorPaletteID, @TeamID)
		
		SET @IsInserted = 1
    END
    
    -- Selecting the inserted color info from pColorPalette
    SELECT ColorCode, ColorName, ColorSource, ColorFolderID, ColorPaletteID, @IsInserted AS WasInserted
    FROM pColorPalette
    WHERE ColorPaletteID = @ColorPaletteID
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05652', GetDate())
GO
