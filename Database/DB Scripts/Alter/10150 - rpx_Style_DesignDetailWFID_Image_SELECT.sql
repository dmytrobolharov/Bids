IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DesignDetailWFID_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DesignDetailWFID_Image_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_DesignDetailWFID_Image_SELECT] 	 
	@StyleID nvarchar(255),
	@ReportPageID nvarchar(255),	
	@StyleSet As int
AS

DECLARE @WorkflowID nvarchar(255)

select @WorkflowID = ReportMapID from rReportStylePageItem where ReportPageID = @ReportPageID

SELECT	identity(int,0,1) as RowNumber,
	dbo.fnx_GetStreamingImagePath(si.ImageID, si.ImageVersion, 2000) AS FilePath,
	CAST(hi.ImageDescription AS nvarchar(255)) AS ImageDescription
INTO	#tblTemp
FROM	pStyleImageItem si, hImage hi 
WHERE	((si.ImageID = hi.ImageID) AND
	(si.ImageVersion = hi.Version) AND
	(si.StyleSet = @StyleSet) AND
	(si.StyleID = @StyleID) AND 
	(si.WorkflowID = @WorkflowID))
ORDER BY si.Sort, si.ImageID ASC

SELECT	RowNumber,
	FilePath,
	ImageDescription
FROM	#tblTemp

DROP TABLE #tblTemp


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10150', GetUTCDate())
GO