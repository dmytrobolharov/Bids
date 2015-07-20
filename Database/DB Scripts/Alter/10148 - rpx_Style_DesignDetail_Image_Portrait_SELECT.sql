IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DesignDetail_Image_Portrait_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_DesignDetail_Image_Portrait_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_DesignDetail_Image_Portrait_SELECT]
	@StyleID nvarchar(255),	
	@StyleSet As int 
AS


SELECT	identity(int,0,1) as RowNumber,
	(dbo.fnx_GetStreamingImagePath(hi.ImageID, hi.[Version], 2000)) AS FilePath,	--Comment #01
	CAST(hi.ImageDescription AS nvarchar(255)) AS ImageDescription 
INTO	#tblTemp
FROM	pStyleImageItem si, hImage hi 
WHERE	((si.ImageID = hi.ImageID) AND
	(si.ImageVersion = hi.Version) AND
	(si.StyleSet = @StyleSet) AND
	(si.StyleID = @StyleID))
ORDER BY si.Sort, si.ImageID ASC

SELECT RowNumber,		--Comment #02
	FilePath,
	ImageDescription
FROM	#tblTemp


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10148', GetUTCDate())
GO