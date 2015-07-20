/****** Object:  UserDefinedFunction [dbo].[fnx_GetStreamingImagePathFitPhotos]    Script Date: 09/28/2012 12:29:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImagePathFitPhotos]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImagePathFitPhotos]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetStreamingImagePathFitPhotos]    Script Date: 09/28/2012 12:29:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
Comments:

General - Ryan Cabanas - September 23, 2009
	Pass the Image Version and Image ID and get the new Streaming Image Path
back.
*/


CREATE FUNCTION [dbo].[fnx_GetStreamingImagePathFitPhotos](
	@ImageID uniqueidentifier
	,@ImageQualityValue int
	,@ImageType nvarchar(40)
)

RETURNS nvarchar(255)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)


	/*Get Image Server path portion.*/
	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=' + @ImageType + '&S=' + CAST(@ImageQualityValue AS varchar(10)) + '&ID=' + CAST(@ImageID AS varchar(255))

	/*Return.*/
	RETURN @StreamingImagePath
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04022', GetDate())
GO