/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_SELECT]    Script Date: 04/29/2013 15:46:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_TempColors_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_TempColors_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOM_TempColors_SELECT]    Script Date: 04/29/2013 15:46:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOM_TempColors_SELECT]
	@StyleBOMDimensionID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT color.ColorName, color.ColorCode, color.ColorSource, color.ColorPaletteID, color.ColorFolderID 
	FROM pColorPalette color
	INNER JOIN pStyleBOMDimensionTempColor dimtemp ON dimtemp.ColorPaletteID = color.ColorPaletteID
	WHERE dimtemp.TeamID = @TeamID AND dimtemp.StyleBOMDimensionID = @StyleBOMDimensionID
	ORDER BY color.ColorCode, color.ColorName
    
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05653', GetDate())
GO
