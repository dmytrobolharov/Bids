IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_LineFolder_Global_2x2_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_LineFolder_Global_2x2_SELECT]
GO

CREATE Procedure [dbo].[rpx_LineFolder_Global_2x2_SELECT]
	@Season NVARCHAR(MAX)
	, @Year NVARCHAR(MAX)
	, @StyleType VARCHAR(MAX)
	, @MainMaterial VARCHAR(MAX)
	, @StyleCategory VARCHAR(MAX)
	, @StyleDivision VARCHAR(MAX)
AS
BEGIN

	SELECT value INTO #tmpSeason FROM fnx_Split(@Season, ',')
	SELECT value INTO #tmpYear FROM fnx_Split(@Year, ',')
	SELECT CAST(value AS INT) AS st INTO #tmpStyleType FROM fnx_Split(@StyleType, ',')
	SELECT CAST(value AS UNIQUEIDENTIFIER) AS sc INTO #tmpStyleCategory FROM fnx_Split(@StyleCategory, ',')
	SELECT CAST(value AS UNIQUEIDENTIFIER) AS sd INTO #tmpStyleDivision FROM fnx_Split(@StyleDivision, ',')
	
	CREATE TABLE #tmpMainMaterial (MainMaterialID UNIQUEIDENTIFIER)
	INSERT INTO #tmpMainMaterial SELECT CAST(value AS UNIQUEIDENTIFIER) FROM fnx_Split(@MainMaterial, ',')
	IF EXISTS (SELECT * FROM #tmpMainMaterial WHERE MainMaterialID = '00000000-0000-0000-0000-000000000000')
		INSERT INTO #tmpMainMaterial (MainMaterialID) VALUES (NULL)

	SELECT
		IDENTITY(INT, 0, 1) AS RowNum
		, sh.StyleNo
		, sh.Description
		, sy.Season + '/' + sy.Year AS SeasonYear
		, sm.MaterialName
		, sm.B AS MaterialContent
		, dbo.fnx_GetStreamingImagePath(sh.DesignSketchID, sh.DesignSketchVersion) AS StyleImagePath
		, sh.StyleID
	INTO #tmpLineList
	FROM
		pStyleHeader sh
		LEFT OUTER JOIN pStyleSeasonYear ssy ON sh.StyleID = ssy.StyleID
		LEFT OUTER JOIN pSeasonYear sy ON ssy.SeasonYearID = sy.SeasonYearID
        LEFT OUTER JOIN pStyleMaterials sm ON sh.StyleID = sm.StyleID AND sh.StyleSet = sm.StyleSet AND sm.MainMaterial = 1
		INNER JOIN #tmpSeason ts ON sy.Season = ts.value
		INNER JOIN #tmpYear ty ON sy.Year = ty.value
		INNER JOIN #tmpStyleType tst ON sh.StyleType = tst.st
		INNER JOIN #tmpStyleCategory tsc ON sh.StyleCategory = tsc.sc
		INNER JOIN #tmpMainMaterial tmm ON sh.MaterialID = tmm.MainMaterialID
		INNER JOIN #tmpStyleDivision tsd ON sh.DivisionID = tsd.sd
	ORDER BY sh.StyleNo

	SELECT 	RowNum / 2 AS [Row], RowNum % 2 AS [Column], * FROM #tmpLineList
	DROP TABLE #tmpLineList
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05578', GetDate())
GO
