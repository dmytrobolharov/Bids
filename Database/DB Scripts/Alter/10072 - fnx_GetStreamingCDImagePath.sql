IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingCDImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingCDImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingCDImagePath]
(
	@ImageID UNIQUEIDENTIFIER
	, @ImageVersion INT
	, @ImageQualityValue NVARCHAR(5)
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
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=CD&S=' + @ImageQualityValue + '&V=' + CAST(@ImageVersion AS nvarchar(5)) + '&ID=' + CAST(@ImageID AS nvarchar(255))

	/*Return.*/
	RETURN @StreamingImagePath
END




GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10072', GetUTCDate())
GO