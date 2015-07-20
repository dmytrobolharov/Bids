IF EXISTS (select * from sysobjects where id = object_id('rpx_Style_DesignDetail2_Image_SELECT') and sysstat & 0xf = 4)
    drop procedure rpx_Style_DesignDetail2_Image_SELECT
GO
-- =============================================
-- Author:		Joseph Lau
-- =============================================
CREATE PROCEDURE [dbo].[rpx_Style_DesignDetail2_Image_SELECT]
	@StyleID varchar(255),	 
	@WorkflowItemID varchar(255),	
	@StyleSet As int
AS

SELECT	identity(int,0,1) as RowNumber,
	dbo.fnx_GetStreamingImagePath(sdf.ImageID, sdf.ImageVersion) AS FilePath,
	CAST(hi.ImageDescription AS nvarchar(200)) AS ImageDescription,
	CAST(sdf.Comments AS nvarchar(2000)) AS Comments
INTO	#tblTemp
FROM	pStyleDetailForm sdf, hImage hi 
WHERE	((sdf.ImageID = hi.ImageID) AND
	(sdf.ImageVersion = hi.Version) AND
	(sdf.StyleSet = @StyleSet) AND
	(sdf.WorkFlowItemId = @WorkflowItemID) AND
	(sdf.StyleID = @StyleID))
ORDER BY sdf.Sort, sdf.ImageID ASC

SELECT	RowNumber,
	FilePath,
	ImageDescription,
	Comments
FROM	#tblTemp

DROP TABLE #tblTemp
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01059', GetDate())
GO