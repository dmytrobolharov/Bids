IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingCareImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingCareImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingCareImagePath]
(
	@ImageID nvarchar(255),
	@CareFolder nvarchar(255)
)
RETURNS nvarchar(255)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)
	/*Get Image Server path portion.*/
	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	/*Build the path.*/
	SET @ImageQualityValue = '150'
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=SC&CF=' + @CareFolder + '&IID=' + @ImageID + '&S=' + @ImageQualityValue

	/*Return.*/
	RETURN @StreamingImagePath
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10028', GetUTCDate())
GO


