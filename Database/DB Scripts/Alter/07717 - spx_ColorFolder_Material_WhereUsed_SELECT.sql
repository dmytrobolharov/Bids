IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolder_Material_WhereUsed_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolder_Material_WhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_ColorFolder_Material_WhereUsed_SELECT]
	@ColorFolderID UNIQUEIDENTIFIER,
	@TeamID UNIQUEIDENTIFIER,
	@WhereClause NVARCHAR(MAX),
	@SelectedColors NVARCHAR(MAX),
	@SelectMode INT = 0 /* 0 - has any, 1 - has all */
AS
BEGIN
	
	DECLARE @SelColors TABLE(ColorPaletteID UNIQUEIDENTIFIER)
	INSERT INTO @SelColors(ColorPaletteID)
	SELECT value FROM dbo.fnx_Split(@SelectedColors, ',') sc
	
	IF @SelectMode = 0
	BEGIN
	
		SELECT DISTINCT m.* 
		INTO #tmp0
		FROM pMaterialColor mc
		INNER JOIN pMaterial m ON mc.MaterialID = m.MaterialID
		INNER JOIN sAccessMaterialFolder amf ON m.MaterialType = amf.ComponentTypeId
		INNER JOIN @SelColors SelColors ON mc.ColorPaletteID = SelColors.ColorPaletteID
		WHERE amf.TeamId = @TeamID AND (amf.AccessRoleId = 3 OR amf.AccessView = 1)
		
		EXEC('SELECT * FROM #tmp0 ' + @WhereClause)
		DROP TABLE #tmp0
		
	END
	ELSE
	BEGIN
	
		SELECT m.* 
		INTO #tmp1
		FROM pMaterial m
		INNER JOIN sAccessMaterialFolder amf ON m.MaterialType = amf.ComponentTypeId
		WHERE NOT EXISTS(
			SELECT * 
			FROM @SelColors SelColors			
			LEFT JOIN pMaterialColor mc ON SelColors.ColorPaletteID = mc.ColorPaletteID AND mc.MaterialID = m.MaterialID
			WHERE mc.ColorPaletteID IS NULL)
		AND amf.TeamId = @TeamID AND (amf.AccessRoleId = 3 OR amf.AccessView = 1)
		
		EXEC('SELECT * FROM #tmp1 ' + @WhereClause)
		DROP TABLE #tmp1
		
	END
	
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07717', GetDate())
GO
