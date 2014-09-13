/*
Comments:

#01 - Ryan Cabanas - September 23, 2009
	Replace the old image string with the new image string using function.
Deleted old code.
*/


ALTER   PROCEDURE [dbo].[rpx_ImageFolder_Image_SELECT] 	 
	@ImageID varchar(255),	
	@Version int
AS


SELECT (dbo.fnx_GetStreamingImagePath(ImageID, [Version])) AS FilePath,	--Comment #01
	'Version: ' + CAST(@Version AS varchar(5)) AS Version,
	'Last Modified: ' + CAST(MDate AS varchar(50)) AS ModifiedDate
FROM	hImage 
WHERE (ImageID  = @ImageID) 
	AND (Version = @Version)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '798', GetDate())
GO