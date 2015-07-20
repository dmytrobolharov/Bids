/****** Object:  StoredProcedure [dbo].[spx_Material_Color_SELECT]    Script Date: 02/09/2015 16:44:57 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Material_Color_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Material_Color_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_Material_Color_SELECT]    Script Date: 02/09/2015 16:44:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_Material_Color_SELECT](
	@MaterialID UNIQUEIDENTIFIER,
	@SqlFilter NVARCHAR(MAX) = NULL,
	@PageNo INT = NULL,
	@PageSize INT = NULL,
	@SortOrder NVARCHAR(MAX) = NULL,
	@RecordCount INT = NULL OUTPUT
)
AS 
	
			SELECT a.MaterialColorID, a.MaterialColorImageID, a.MaterialColorImageVersion, 
			a.MaterialColorNote,
			a.ColorCode, a.ColorName, b.ColorPaletteCustom4 , b.ColorSource,
			b.ColorPaletteID, b.ColorFolderID, b.Hex, b.R, b.G, b.B, b.LAB_A, b.LAB_B, b.LAB_L 
			INTO #tmp0
			FROM dbo.pMaterialColor a WITH(NOLOCK)
			INNER JOIN dbo.pColorPalette b WITH(NOLOCK)  ON a.ColorPaletteID = b.ColorPaletteID
		WHERE a.MaterialID = @MaterialID
	
	--declare @strSql NVARCHAR(MAX) = 'SELECT * FROM #'
	
	--IF @SqlFilter IS NOT NULL
	--BEGIN
	--	IF LTRIM(RTRIM(@SqlFilter)) <> ''
	--	BEGIN
	--		SET @strSql = @strSql + @SqlFilter
	--	END
	--END
		
	--EXEC sp_executesql @strSql



DECLARE @sqlString  NVARCHAR(MAX) = dbo.fnx_CreatePagingString('#tmp0',@PageNo,@PageSize,@SortOrder, @SqlFilter)

exec sp_executesql @sqlString

IF @SqlFilter is not NULL
begin
	SET @SqlFilter = REPLACE(@SqlFilter, ' WHERE ','')
	DECLARE @sqlStringCount NVARCHAR(MAX) = 'SELECT * INTO #tmpCount FROM #tmp0 WHERE ' + @SqlFilter
	exec sp_executesql @sqlStringCount
	--DROP TABLE #tmpCount
end

SET @RecordCount = @@ROWCOUNT
--DROP TABLE #tmp0

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09328', GetDate())
GO