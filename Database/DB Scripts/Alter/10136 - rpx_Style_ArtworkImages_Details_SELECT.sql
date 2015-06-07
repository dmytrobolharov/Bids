IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_ArtworkImages_Details_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_ArtworkImages_Details_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_ArtworkImages_Details_SELECT]            
(    
	@StyleID	AS NVARCHAR(100)
	,@StyleSet	AS INT
)          
AS  
BEGIN
	SET NOCOUNT ON

	SELECT
		ROW_NUMBER() OVER(ORDER BY
								pStyleMaterials.MaterialSort
								,pStyleMaterials.MaterialName
								,pStyleMaterials.MaterialNo) AS RowNumber
		,pStyleMaterials.MaterialName
		,pStyleMaterials.MaterialNo
		,(dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000)) AS StyleImagePath
	FROM pStyleMaterials
		LEFT OUTER JOIN hImage ON	pStyleMaterials.MaterialImageId = hImage.ImageID
									AND pStyleMaterials.MaterialImageVersion = hImage.[Version]
	WHERE CAST(pStyleMaterials.StyleID AS NVARCHAR(100)) = @StyleID
		AND pStyleMaterials.StyleSet = @StyleSet
		AND pStyleMaterials.Artwork = 1
			
/* Clean Up */
	SET NOCOUNT OFF
END


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10136', GetUTCDate())
GO