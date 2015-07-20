IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageCADBodyMarkerPath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageCADBodyMarkerPath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImageCADBodyMarkerPath]
(
	@BodyID UNIQUEIDENTIFIER
	, @MarkerID UNIQUEIDENTIFIER
)

RETURNS nvarchar(255)

AS

BEGIN	
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)

	/*Set image quality value.*/
	SET @ImageQualityValue = '2000'

	/*Get Image Server path portion.*/
	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=B&Type=MK&S=' + @ImageQualityValue + '&IID=' + CAST(@BodyID AS nvarchar(255)) + '&MID=' + CAST(@MarkerID AS nvarchar(255))

	/*Return.*/
	RETURN @StreamingImagePath

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10032', GetUTCDate())
GO