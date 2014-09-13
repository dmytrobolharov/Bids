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
	
	SELECT (ROW_NUMBER() OVER (PARTITION BY MaterialName ORDER BY MaterialName) - 1) / 11 AS Row
		, (ROW_NUMBER() OVER (PARTITION BY MaterialName ORDER BY MaterialName) - 1) % 11 AS Col
		, * FROM
		(SELECT DISTINCT
			m.MaterialName
			, m.B
			, sh.StyleNo
			, sh.SizeRange
			, STUFF ((SELECT DISTINCT ', ' + ISNULL(ColorName, '') + ISNULL(' (' + ColorCode + ')', '')
				FROM pMaterialColor mc INNER JOIN pStyleBOMItem sbi ON mc.MaterialColorID = sbi.MaterialColorId
				WHERE sbi.StyleBOMDimensionID = sb.StyleBOMDimensionId AND sbi.StyleMaterialID = sb.StyleMaterialID FOR XML PATH('')), 1, 2, '') AS MaterialColor
			, dbo.fnx_GetStreamingImagePath(SB.MaterialImageID,SB.MaterialImageVersion) AS ImagePath
			, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID,sh.DesignSketchVersion) AS StyleImagePath
		FROM pLineFolderItem lfi
		INNER JOIN @LineLists ll ON lfi.LineFolderID = ll.LineFolderID
		INNER JOIN pStyleBOM sb ON lfi.StyleBOMDimensionID = sb.StyleBOMDimensionId AND sb.MainMaterial = 1
		INNER JOIN pMaterial m ON sb.MaterialID = m.MaterialID
		INNER JOIN pStyleHeader sh ON lfi.StyleID = sh.StyleID) m
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06569', GetDate())
GO
