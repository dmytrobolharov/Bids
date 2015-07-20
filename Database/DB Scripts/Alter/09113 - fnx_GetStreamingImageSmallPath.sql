/****** Object:  UserDefinedFunction [dbo].[fnx_GetStreamingImageSmallPath]    Script Date: 09/16/2014 14:55:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageSmallPath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageSmallPath]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetStreamingImageSmallPath]    Script Date: 09/16/2014 14:55:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

General - Ryan Cabanas - September 23, 2009
	Pass the Image Version and Image ID and get the new Streaming Image Path
back.

General - Ryan Cabanas - September 25, 2009
	Alternate version of function to give back lower quality for smaller images.
*/


CREATE FUNCTION [dbo].[fnx_GetStreamingImageSmallPath](
	@ImageID uniqueidentifier
	,@ImageVersion int
)

RETURNS nvarchar(255)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)

	/*Set image quality value.*/
	SET @ImageQualityValue = '500'

	/*Get Image Server path portion.*/
	SET @ImageServer = (SELECT TOP 1 AppSettingValue FROM sAppSetting WHERE AppSettingKey = 'ImageServer')

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?S=' + @ImageQualityValue + '&V=' + CAST(@ImageVersion AS nvarchar(5)) + '&IID=' + CAST(@ImageID AS nvarchar(255))

	/*Return.*/
	RETURN @StreamingImagePath
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09113', GetDate())
GO
