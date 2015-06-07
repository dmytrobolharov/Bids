IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Line_List_Theme_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Line_List_Theme_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Line_List_Theme_SELECT]
	@LineFolderID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
	, @SeasonYearID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
	, @StyleThemeID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
	, @StyleCategoryID UNIQUEIDENTIFIER = '00000000-0000-0000-0000-000000000000'
AS
BEGIN
	IF @SeasonYearID = '00000000-0000-0000-0000-000000000000'
	SELECT @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
	
	-- Temp table for Line List
	DECLARE @LineLists TABLE (LineFolderID UNIQUEIDENTIFIER)
	INSERT INTO @LineLists VALUES (@LineFolderID)

	IF @LineFolderID = '00000000-0000-0000-0000-000000000000'
		INSERT INTO @LineLists
		SELECT LineFolderID FROM pLineFolder WHERE SeasonYearID = @SeasonYearID AND Active = 1

	-- Temp table for Style Theme
	DECLARE @StyleThemes TABLE (StyleThemeID UNIQUEIDENTIFIER)
	INSERT INTO @StyleThemes VALUES (@StyleThemeID)

	IF @StyleThemeID = '00000000-0000-0000-0000-000000000000'
		INSERT INTO @StyleThemes
		SELECT StyleThemeID FROM pStyleTheme WHERE Active = 1
	
	-- Temp table for Style Category
	DECLARE @StyleCategorys TABLE (StyleCategoryID UNIQUEIDENTIFIER)
	INSERT INTO @StyleCategorys VALUES (@StyleCategoryID)

	IF @StyleCategoryID = '00000000-0000-0000-0000-000000000000'
		INSERT INTO @StyleCategorys
		SELECT StyleCategoryId FROM pStyleCategory WHERE Active = 1
	
	
	
	SELECT (ROW_NUMBER() OVER (PARTITION BY ThemeName ORDER BY ThemeName) - 1) / 4 AS Row
		, (ROW_NUMBER() OVER (PARTITION BY ThemeName ORDER BY ThemeName) - 1) % 4 AS Col
		, * FROM
		(SELECT DISTINCT
			m.MaterialName
			, m.B
			, ISNULL(sh.Description, '') + ' (' + sh.StyleNo + ')' AS Style
			, sh.SizeRange
			, '$' + CAST(ISNULL(sch.StyleCostingCustomField2, 0) AS nVARCHAR(15)) + '/' + '$' + CAST(ISNULL(sch.StyleCostingCustomField1, 0) AS nVARCHAR(15)) AS Price
			, STUFF ((SELECT DISTINCT ', ' + ISNULL(ColorName, '') + ISNULL(' (' + ColorCode + ')', '')
				FROM pMaterialColor mc INNER JOIN pMaterialColorSeasonYear mcsy ON mc.MaterialColorID = mcsy.MaterialColorID AND mc.MaterialID = mcsy.MaterialID
				WHERE m.MaterialID = mc.MaterialID AND mcsy.SeasonYearID = @SeasonYearID FOR XML PATH('')), 1, 2, '') AS MaterialColor
			, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID,sh.DesignSketchVersion, 2000) AS StyleImagePath
			, sh.StyleNo
			, ISNULL(st.ThemeName, 'N/A') AS ThemeName
		FROM pLineFolderItem lfi
			INNER JOIN @LineLists ll ON lfi.LineFolderID = ll.LineFolderID
			INNER JOIN pStyleBOM sb ON lfi.StyleBOMDimensionID = sb.StyleBOMDimensionId AND sb.MainMaterial = 1
			INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
			INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
			INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID
			LEFT JOIN pStyleCostingHeader sch ON sh.StyleID = sch.StyleID AND ssy.StyleSeasonYearID = sch.StyleSeasonYearID
			LEFT JOIN pStyleTheme st ON sh.StyleThemeID = st.StyleThemeID
		WHERE ISNULL(sh.StyleCategory, '00000000-0000-0000-0000-000000000000') IN (SELECT * FROM @StyleCategorys)
			AND ISNULL(sh.StyleThemeID, '00000000-0000-0000-0000-000000000000') IN (SELECT * FROM @StyleThemes)) m
	ORDER BY m.ThemeName, m.StyleNo

END



GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10085', GetUTCDate())
GO