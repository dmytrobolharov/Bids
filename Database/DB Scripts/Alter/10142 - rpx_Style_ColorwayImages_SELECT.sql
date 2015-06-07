IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_ColorwayImages_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_ColorwayImages_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_ColorwayImages_SELECT]            
(    
	@StyleID		AS NVARCHAR(100)
	,@StyleSet		AS INT
	,@SeasonYearID	AS NVARCHAR(100)
)          
AS  
BEGIN
	SET NOCOUNT ON

	SELECT
		ROW_NUMBER() OVER(ORDER BY	 
									 pStyleColorway.Sort
									,pStyleColorway.StyleColorName
									,pStyleColorway.StyleColorNo) AS Rownumber		 
		,pStyleColorway.StyleColorNo
		,pStyleColorway.StyleColorName
		,(dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000))			AS StyleImageFrontPath
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
	

		
/* Clean Up */
	
	SET NOCOUNT OFF
END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10142', GetUTCDate())
GO