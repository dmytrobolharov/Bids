IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageCADStyleMarkerPath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageCADStyleMarkerPath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImageCADStyleMarkerPath](
	@StyleID uniqueidentifier,
	@MarkerID uniqueidentifier
)

RETURNS nvarchar(255)

AS

BEGIN

	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)

	/*Set image quality value.*/
	SET @ImageQualityValue = '1000'

	/*Get Image Server path portion.*/
	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=ST&Type=MK&S=' + @ImageQualityValue + '&IID=' + CAST(@StyleID AS nvarchar(255)) + '&MID=' + CAST(@MarkerID AS nvarchar(255)) + '&' + CAST(DATEDIFF(SECOND, '20000101', GETDATE()) AS NVARCHAR(30))

	/*Return.*/
	RETURN @StreamingImagePath

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09163', GetDate())
GO
