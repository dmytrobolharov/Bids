IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dpx_Line_List_Fabric_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[dpx_Line_List_Fabric_SELECT]
GO

CREATE PROCEDURE [dbo].[dpx_Line_List_Fabric_SELECT]
	@LineFolderID UNIQUEIDENTIFIER = NULL
	, @SeasonYearID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	IF @SeasonYearID IS NULL OR @SeasonYearID = '00000000-0000-0000-0000-000000000000'
	SELECT @SeasonYearID = SeasonYearID FROM pSeasonYear WHERE CurrentSeason = 1
	
	DECLARE @LineLists TABLE (LineFolderID UNIQUEIDENTIFIER)
	INSERT INTO @LineLists VALUES (@LineFolderID)

	IF @LineFolderID IS NULL OR @LineFolderID = '00000000-0000-0000-0000-000000000000'
		INSERT INTO @LineLists
		SELECT LineFolderID FROM pLineFolder WHERE SeasonYearID = @SeasonYearID AND Active = 1
	
	SELECT (ROW_NUMBER() OVER (PARTITION BY MaterialName ORDER BY MaterialName) - 1) / 5 AS Row
		, (ROW_NUMBER() OVER (PARTITION BY MaterialName ORDER BY MaterialName) - 1) % 5 AS Col
		, * FROM
		(SELECT DISTINCT
			ISNULL(m.MaterialName, '') + ' (' + m.MaterialNo + ')' AS MaterialName
			, m.B
			, ISNULL(sh.Description, '') + ' (' + sh.StyleNo + ')' AS Style
			, sh.SizeRange
			, '$' + CAST(ISNULL(sch.StyleCostingCustomField2, 0) AS nVARCHAR(15)) + '/' + '$' + CAST(ISNULL(sch.StyleCostingCustomField1, 0) AS nVARCHAR(15)) AS Price
			, STUFF ((SELECT DISTINCT ', ' + ISNULL(ColorName, '') + ISNULL(' (' + ColorCode + ')', '')
				FROM pMaterialColor mc INNER JOIN pMaterialColorSeasonYear mcsy ON mc.MaterialColorID = mcsy.MaterialColorID AND mc.MaterialID = mcsy.MaterialID
				WHERE m.MaterialID = mc.MaterialID AND mcsy.SeasonYearID = @SeasonYearID FOR XML PATH('')), 1, 2, '') AS MaterialColor
			, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID,sh.DesignSketchVersion) AS StyleImagePath
			, sh.StyleNo
		FROM pLineFolderItem lfi
			INNER JOIN @LineLists ll ON lfi.LineFolderID = ll.LineFolderID
			INNER JOIN pStyleBOM sb ON lfi.StyleBOMDimensionID = sb.StyleBOMDimensionId AND sb.MainMaterial = 1
			INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
			INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID
			INNER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID AND ssy.SeasonYearID = @SeasonYearID
			LEFT JOIN pStyleCostingHeader sch ON sh.StyleID = sch.StyleID AND ssy.StyleSeasonYearID = sch.StyleSeasonYearID) m
	ORDER BY m.MaterialName, m.StyleNo
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06571', GetDate())
GO
