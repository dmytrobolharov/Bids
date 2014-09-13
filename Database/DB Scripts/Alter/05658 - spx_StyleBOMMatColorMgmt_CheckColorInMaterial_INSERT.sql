/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMatColorMgmt_CheckColorInMaterial_INSERT]    Script Date: 05/07/2013 18:03:08 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMatColorMgmt_CheckColorInMaterial_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMatColorMgmt_CheckColorInMaterial_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMatColorMgmt_CheckColorInMaterial_INSERT]    Script Date: 05/07/2013 18:03:08 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMMatColorMgmt_CheckColorInMaterial_INSERT]
	@StyleMaterialID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    IF NOT EXISTS(SELECT * FROM pStyleBOM sbom INNER JOIN pMaterialColor mc ON sbom.MaterialID = mc.MaterialID
					WHERE mc.ColorPaletteID = @ColorPaletteID AND sbom.StyleMaterialID = @StyleMaterialID)
	BEGIN
		
		DECLARE @ColorFolderID UNIQUEIDENTIFIER
		DECLARE @MaterialID UNIQUEIDENTIFIER
		
		SELECT @ColorFolderID = ColorFolderID FROM pColorPalette WHERE ColorPaletteID = @ColorPaletteID
		SELECT @MaterialID = MaterialID FROM pStyleBOM WHERE StyleMaterialID = @StyleMaterialID
		
		EXEC spx_MaterialColor_Pending_INSERT @ColorPaletteID, @ColorFolderID, @MaterialID, @CUser, @CDate
		EXEC spx_MaterialColor_FromPending_INSERT @ColorPaletteID, @MaterialID, NULL, @Cuser, @CDate
		
	END
	
	SELECT  mc.MaterialColorID, mc.ColorCode, mc.ColorName, mc.ColorSource, mc.ColorFolderID, mc.ColorPaletteID
	FROM pStyleBOM sbom INNER JOIN pMaterialColor mc ON sbom.MaterialID = mc.MaterialID
	WHERE mc.ColorPaletteID = @ColorPaletteID AND sbom.StyleMaterialID = @StyleMaterialID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05658', GetDate())
GO
