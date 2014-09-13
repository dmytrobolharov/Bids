IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageGRPOMPath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageGRPOMPath]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fnx_GetStreamingImageGRPOMPath](
	@ImageID uniqueidentifier
)

RETURNS nvarchar(255)

AS

BEGIN
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)

	SET @ImageQualityValue = '200'

	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=POM&S=' + @ImageQualityValue + '&V=' + '&ID=' + CAST(@ImageID AS varchar(255))

	RETURN @StreamingImagePath
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04444', GetDate())
GO
