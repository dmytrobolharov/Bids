/****** Object:  UserDefinedFunction [dbo].[fnx_GetStreamingImagePath_FPComments]    Script Date: 09/28/2012 12:29:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImagePath_FPComments]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImagePath_FPComments]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetStreamingImagePath_FPComments]    Script Date: 09/28/2012 12:29:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnx_GetStreamingImagePath_FPComments](
	@ImageID uniqueidentifier
)

RETURNS nvarchar(255)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)

	/*Set image quality value.*/
	SET @ImageQualityValue = '400'

	/*Get Image Server path portion.*/
	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=MAMAGIC&S=' + @ImageQualityValue + '&ID=' + CAST(@ImageID AS varchar(255))

	/*Return.*/
	RETURN @StreamingImagePath
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04023', GetDate())
GO