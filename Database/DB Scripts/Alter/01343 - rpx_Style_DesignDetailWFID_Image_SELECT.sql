IF EXISTS (select * from sysobjects where id = object_id('rpx_Style_DesignDetailWFID_Image_SELECT') and sysstat & 0xf = 4)
    drop procedure rpx_Style_DesignDetailWFID_Image_SELECT
GO

CREATE PROCEDURE [dbo].[rpx_Style_DesignDetailWFID_Image_SELECT] 	 
	@StyleID varchar(255),
	@ReportPageID varchar(255),	
	@StyleSet As int
AS

DECLARE @WorkflowID varchar(255)

select @WorkflowID = ReportMapID from rReportStylePageItem where ReportPageID = @ReportPageID

SELECT	identity(int,0,1) as RowNumber,
	dbo.fnx_GetStreamingImagePath(si.ImageID, si.ImageVersion) AS FilePath,
	CAST(hi.ImageDescription AS varchar(255)) AS ImageDescription
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
VALUES ('DB_Version', '4.0.0000', '01343', GetDate())
GO
