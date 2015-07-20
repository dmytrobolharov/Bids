IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImagePath]
(
	@ImageID UNIQUEIDENTIFIER
	, @ImageVersion INT
	, @ImageQualityValue INT
)

RETURNS NVARCHAR(255)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)

	/*Get Image Server path portion.*/
	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?S=' + CAST(@ImageQualityValue AS NVARCHAR(5)) + '&V=' + CAST(@ImageVersion AS NVARCHAR(5)) + '&IID=' + CAST(@ImageID AS NVARCHAR(255))

	/*Return.*/
	RETURN @StreamingImagePath
END
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10075', GetUTCDate())
GO