/****** Object:  StoredProcedure [dbo].[spx_Material_Color_SELECT]    Script Date: 04/26/2013 11:37:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Color_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_Color_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_Material_Color_SELECT]    Script Date: 04/26/2013 11:37:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_Material_Color_SELECT](
	@MaterialID UNIQUEIDENTIFIER,
	@SqlFilter NVARCHAR(MAX) = NULL
)
AS 
	
	DECLARE @strSql NVARCHAR(MAX)
	SET @strSql = ' SELECT * FROM 
	(
		SELECT a.MaterialColorID, a.MaterialColorImageID, a.MaterialColorImageVersion, 
			a.MaterialColorNote,
			a.ColorCode, a.ColorName, b.ColorPaletteCustom4 , b.ColorSource,
			b.ColorPaletteID, b.ColorFolderID, b.Hex, b.R, b.G, b.B, b.LAB_A, b.LAB_B, b.LAB_L
		FROM dbo.pMaterialColor a WITH(NOLOCK)
			INNER JOIN dbo.pColorPalette b WITH(NOLOCK)  ON a.ColorPaletteID = b.ColorPaletteID
		WHERE a.MaterialID = ''' + CAST(@MaterialID AS VARCHAR(40)) + ''' 
	) AS dataSet '
	
	IF @SqlFilter IS NOT NULL
	BEGIN
		IF LTRIM(RTRIM(@SqlFilter)) <> ''
		BEGIN
			SET @strSql = @strSql + @SqlFilter
		END
	END
		
	EXEC sp_executesql @strSql


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05616', GetDate())
GO
