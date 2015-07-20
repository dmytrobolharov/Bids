IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingColorImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingColorImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingColorImagePath]
(
	@ColorFolderID uniqueidentifier
	, @ColorPaletteID uniqueidentifier
)

RETURNS nvarchar(255)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)

	/*Set image quality value.*/
	SET @ImageQualityValue = '100'

	/*Get Image Server path portion.*/
	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ColorStream.ashx?S=' + @ImageQualityValue + '&CFID=' + CAST(@ColorFolderID AS nvarchar(255)) + '&CPID=' + CAST(@ColorPaletteID AS nvarchar(255))

	/*Return.*/
	RETURN @StreamingImagePath
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10030', GetUTCDate())
GO