IF EXISTS ( SELECT * FROM SysObjects WHERE ID = OBJECT_ID(N'[dbo].[rpx_Style_ArtworkImages_SELECT]'))
	BEGIN
		PRINT 'Dropping Procedure [rpx_Style_ArtworkImages_SELECT]'
		DROP PROCEDURE [dbo].[rpx_Style_ArtworkImages_SELECT]
	END
GO
/*----------------------------------------------------------------------                               
* Name        : rpx_Style_ArtworkImages_SELECT
*
* Report Name :	
*
* Description : 
*
* Change History:                  
* ------------------
* Date			Version		Author		Comment
* 09 May 2012	1.0			Kishore		Work Item # 8117
*										First version as per the requirement
*
---------------------------------------------------------------------- */ 
PRINT ''
PRINT ''
PRINT 'Creating Procedure [rpx_Style_ArtworkImages_SELECT]'
GO


CREATE PROCEDURE [dbo].[rpx_Style_ArtworkImages_SELECT]            
(    
	@StyleID		AS NVARCHAR(100)
	,@StyleSet		AS INT
	,@SeasonYearID	AS NVARCHAR(100)
)          
AS  
BEGIN
	SET NOCOUNT ON

	SELECT
		ROW_NUMBER() OVER (ORDER BY pStyleMaterials.MaterialSort
									,pStyleMaterials.MaterialName
									,pStyleMaterials.MaterialNo
									,pStyleColorway.Sort
									,pStyleColorway.StyleColorName
									,pStyleColorway.StyleColorNo) AS [Row]
		,pStyleMaterials.MaterialNo
		,pStyleColorway.StyleColorNo
		,pStyleColorway.StyleColorName
		,(dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])) AS StyleImagePath
	FROM pStyleColorwayArtwork
		INNER JOIN pStyleMaterials ON	pStyleColorwayArtwork.StyleMaterialId = pStyleMaterials.StyleMaterialId
		INNER JOIN pStyleSeasonYear ON	pStyleColorwayArtwork.StyleSeasonYearId = pStyleSeasonYear.StyleSeasonYearId
		INNER JOIN pStyleColorwaySeasonYear ON	pStyleColorwayArtwork.StyleColorID = pStyleColorwaySeasonYear.StyleColorwaySeasonYearID   
		INNER JOIN pStyleColorway ON	pStyleColorwaySeasonYear.StyleColorwayID = pStyleColorway.StyleColorID  
		INNER JOIN pColorPalette ON	pStyleColorway.ColorPaletteId = pColorPalette.ColorPaletteId
		LEFT OUTER JOIN hImage ON	pStyleColorwayArtwork.MaterialArtworkImageId = hImage.ImageID
									AND pStyleColorwayArtwork.MaterialArtworkImageVersion = hImage.[Version]
	WHERE CAST(pStyleMaterials.StyleID AS NVARCHAR(100)) = @StyleID
		AND pStyleMaterials.StyleSet = @StyleSet
		AND pStyleMaterials.Artwork = 1
		AND pStyleSeasonYear.SeasonYearId = @SeasonYearID

/* Clean Up */
	SET NOCOUNT OFF
END
GO
PRINT ''
PRINT 'Completed Creating Procedure [rpx_Style_ArtworkImages_SELECT]'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03492', GetDate())
GO