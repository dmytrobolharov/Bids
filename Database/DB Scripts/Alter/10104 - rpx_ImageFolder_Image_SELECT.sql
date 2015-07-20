IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_ImageFolder_Image_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_ImageFolder_Image_SELECT]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


CREATE   PROCEDURE [dbo].[rpx_ImageFolder_Image_SELECT] 	 
	@ImageID nvarchar(255),	
	@Version int
AS


SELECT (dbo.fnx_GetStreamingImagePath(ImageID, [Version], 2000)) AS FilePath,	--Comment #01
	'Version: ' + CAST(@Version AS nvarchar(5)) AS Version,
	'Last Modified: ' + CAST(MDate AS nvarchar(50)) AS ModifiedDate
FROM	hImage 
WHERE (ImageID  = @ImageID) 
	AND (Version = @Version)


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10104', GetUTCDate())
GO