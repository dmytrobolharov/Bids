/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


ALTER        PROCEDURE [dbo].[rpx_Style_DesignDetail_Image_2_SELECT]
	@StyleID varchar(255),	
	@StyleSet As int 
AS


SELECT	identity(int,0,1) as RowNumber,
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version])) AS FilePath,	--Comment #01
	CAST(hi.ImageDescription AS varchar(255)) AS ImageDescription 
INTO	#tblTemp
FROM	pStyleImageItem si, hImage hi 
WHERE	((si.ImageID = hi.ImageID) AND
	(si.ImageVersion = hi.Version) AND
	(si.StyleSet = @StyleSet) AND
	(si.StyleID = @StyleID)) 
ORDER BY si.Sort, si.ImageID ASC

SELECT RowNumber % 2 AS ColumnNumber,
	RowNumber / 2 AS RowNumber,
	FilePath,
	ImageDescription
FROM	#tblTemp

DROP TABLE #tblTemp
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '263', GetDate())
GO