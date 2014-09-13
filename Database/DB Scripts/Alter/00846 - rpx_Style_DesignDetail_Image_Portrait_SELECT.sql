/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.

#02 - Ryan Cabanas - November 16, 2009
	Made a copy of the 'rpx_Style_DesignDetail_Image_SELECT' procedure and
made this 'rpx_Style_DesignDetail_Image_Portrait_SELECT' copy.  In this one I
took out the '% 1' section in the SELECT because there is only one column in
the report.  This procedure can be used for both single and double
Design Detail Image Portrait reports.
*/

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_DesignDetail_Image_Portrait_SELECT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[rpx_Style_DesignDetail_Image_Portrait_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_Style_DesignDetail_Image_Portrait_SELECT]
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

SELECT RowNumber,		--Comment #02
	FilePath,
	ImageDescription
FROM	#tblTemp
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '846', GetDate())
GO