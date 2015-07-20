IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImagePathChangeLogReport]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImagePathChangeLogReport]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImagePathChangeLogReport]
(
	@ImageID UNIQUEIDENTIFIER
	, @ImageVersion INT
	, @ImageQualityValue NVARCHAR(5)
)

RETURNS nvarchar(255)

AS

BEGIN
	DECLARE @StreamingImagePath NVARCHAR(255)
	DECLARE @ImageServer NVARCHAR(200)

	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?S=' + @ImageQualityValue + '&V=' + CAST(@ImageVersion AS nvarchar(5)) + '&IID=' + CAST(@ImageID AS nvarchar(255))

	RETURN @StreamingImagePath
END



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10038', GetUTCDate())
GO