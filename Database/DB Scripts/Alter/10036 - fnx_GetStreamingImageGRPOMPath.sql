IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageGRPOMPath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageGRPOMPath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImageGRPOMPath]
(
	@ImageID UNIQUEIDENTIFIER
	, @ImageQualityValue INT
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @StreamingImagePath NVARCHAR(255)
	DECLARE @ImageServer NVARCHAR(200)

	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=POM&S=' + CAST(@ImageQualityValue AS NVARCHAR(5)) + '&V=' + '&ID=' + CAST(@ImageID AS NVARCHAR(255))

	RETURN @StreamingImagePath
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10036', GetUTCDate())
GO

