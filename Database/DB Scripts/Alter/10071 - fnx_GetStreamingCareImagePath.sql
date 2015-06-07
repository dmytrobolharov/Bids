IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingCareImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingCareImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingCareImagePath]
(
	@ImageID NVARCHAR(255)
	, @CareFolder NVARCHAR(255)
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
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=SC&CF=' + @CareFolder + '&IID=' + @ImageID + '&S=' + @ImageQualityValue

	/*Return.*/
	RETURN @StreamingImagePath
END




GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10071', GetUTCDate())
GO