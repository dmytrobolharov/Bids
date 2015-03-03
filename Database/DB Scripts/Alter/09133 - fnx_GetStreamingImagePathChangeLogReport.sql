IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImagePathChangeLogReport]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImagePathChangeLogReport]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create FUNCTION [dbo].[fnx_GetStreamingImagePathChangeLogReport](
	@ImageID uniqueidentifier
	,@ImageVersion int
	,@ImageQualityValue nvarchar(5)
)

RETURNS nvarchar(255)

AS

BEGIN
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)

	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?S=' + @ImageQualityValue + '&V=' + CAST(@ImageVersion AS nvarchar(5)) + '&IID=' + CAST(@ImageID AS nvarchar(255))
	SET @StreamingImagePath = STUFF(@StreamingImagePath, 8 ,0, HOST_NAME())
	RETURN @StreamingImagePath
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.0.0001', '09133', GetDate())
GO