IF EXISTS ( SELECT * FROM SysObjects WHERE ID = OBJECT_ID(N'[dbo].[rpx_Style_ColorwayImages_SELECT]'))
	BEGIN
		PRINT 'Dropping Procedure [rpx_Style_ColorwayImages_SELECT]'
		DROP PROCEDURE [dbo].[rpx_Style_ColorwayImages_SELECT]
	END
GO
/*----------------------------------------------------------------------                               
* Name        : rpx_Style_ColorwayImages_SELECT
*
* Report Name :	
*
* Description : 
*
* Change History:                  
* ------------------
* Date			Version		Author		Comment
* 09 May 2012	1.0			Srinivas	Work Item # 8116
*										First version as per the requirement
*
---------------------------------------------------------------------- */ 

PRINT ''
PRINT ''
PRINT 'Creating Procedure [rpx_Style_ColorwayImages_SELECT]'
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
		,(dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version]))			AS StyleImageFrontPath
		,(dbo.fnx_GetStreamingImagePath(hImageBack.ImageID, hImageBack.[Version])) AS StyleImageBackPath
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
PRINT ''
PRINT 'Completed Creating Procedure [rpx_Style_ColorwayImages_SELECT]'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03486', GetDate())
GO