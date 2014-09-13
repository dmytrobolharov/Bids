IF EXISTS ( SELECT * FROM SysObjects WHERE ID = OBJECT_ID(N'[dbo].[rpx_Style_ArtworkImages_Details_SELECT]'))
	BEGIN
		PRINT 'Dropping Procedure [rpx_Style_ArtworkImages_Details_SELECT]'
		DROP PROCEDURE [dbo].[rpx_Style_ArtworkImages_Details_SELECT]
	END
GO
/*----------------------------------------------------------------------                               
* Name        : rpx_Style_ArtworkImages_Details_SELECT
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
PRINT 'Creating Procedure [rpx_Style_ArtworkImages_Details_SELECT]'
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
		,(dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])) AS StyleImagePath
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
PRINT ''
PRINT 'Completed Creating Procedure [rpx_Style_ArtworkImages_Details_SELECT]'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03491', GetDate())
GO