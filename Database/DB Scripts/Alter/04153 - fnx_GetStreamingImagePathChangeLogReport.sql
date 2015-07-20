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
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?S=' + @ImageQualityValue + '&V=' + CAST(@ImageVersion AS varchar(5)) + '&IID=' + CAST(@ImageID AS varchar(255))

	RETURN @StreamingImagePath
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04153', GetDate())
GO