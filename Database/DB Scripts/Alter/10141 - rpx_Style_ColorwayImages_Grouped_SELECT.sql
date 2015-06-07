IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_ColorwayImages_Grouped_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_ColorwayImages_Grouped_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_ColorwayImages_Grouped_SELECT]            
(    
	@StyleID		AS NVARCHAR(100)
	,@StyleSet		AS INT
	,@SeasonYearID	AS NVARCHAR(100)
)          
AS  
BEGIN
	SET NOCOUNT ON

	/*Create temp table.*/
	CREATE TABLE #temp_MainRecords
	(
		TableRow INT IDENTITY(0,1)
		,StyleId NVARCHAR(50)
		,StyleColorNo NVARCHAR(300)
		,StyleColorName NVARCHAR(300)
		,StyleImageFrontPath NVARCHAR(300)
		,StyleImageBackPath NVARCHAR(300)
		,Sort NVARCHAR(50)
	)

	/*Get records and put in temp table.*/
	INSERT INTO #temp_MainRecords
	(
		StyleId
		,StyleColorNo
		,StyleColorName
		,StyleImageFrontPath
		,StyleImageBackPath
		,Sort
	)
	SELECT
		pStyleColorwaySeasonYear.StyleId
		,pStyleColorway.StyleColorNo
		,pStyleColorway.StyleColorName
		,(dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000)) AS StyleImageFrontPath
		,(dbo.fnx_GetStreamingImagePath(hImageBack.ImageID, hImageBack.[Version], 2000)) AS StyleImageBackPath
		,pStyleColorway.Sort
	FROM pStyleColorwaySeasonYear
		INNER JOIN pStyleColorway ON	pStyleColorwaySeasonYear.StyleColorwayId = pStyleColorway.StyleColorId
		INNER JOIN pStyleSeasonYear ON	pStyleColorwaySeasonYear.StyleSeasonYearId = pStyleSeasonYear.StyleSeasonYearId
		INNER JOIN pColorPalette ON	pStyleColorway.ColorPaletteId = pColorPalette.ColorPaletteId
		LEFT OUTER JOIN hImage ON	pStyleColorwaySeasonYear.DesignImageFrontId = hImage.ImageID
									AND pStyleColorwaySeasonYear.DesignImageFrontVersion = hImage.[Version]		
		LEFT OUTER JOIN hImage hImageBack ON	pStyleColorwaySeasonYear.DesignImageBackId = hImageBack.ImageID
												AND pStyleColorwaySeasonYear.DesignImageBackVersion = hImageBack.[Version]		
	WHERE CAST(pStyleColorwaySeasonYear.StyleID AS NVARCHAR(100)) = @StyleID
		AND CAST(pStyleSeasonYear.SeasonYearID AS NVARCHAR(100)) = @SeasonYearID
		AND pStyleColorway.StyleSet = @StyleSet
	ORDER BY
		 pStyleColorway.Sort
		,pStyleColorway.StyleColorName
		,pStyleColorway.StyleColorNo
	
	/*Final select.*/
	SELECT
		TableRow / 3 AS Rownumber
		,TableRow % 3 AS Columnnumber
		,StyleId
		,StyleColorNo
		,StyleColorName
		,StyleImageFrontPath
		,StyleImageBackPath
		,Sort
	FROM #temp_MainRecords

		
/* Clean Up */
	
	SET NOCOUNT OFF
END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10141', GetUTCDate())
GO