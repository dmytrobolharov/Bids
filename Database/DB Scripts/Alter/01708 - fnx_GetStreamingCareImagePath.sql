IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingCareImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingCareImagePath]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

	/*Build the path.*/
	SET @ImageQualityValue = '150'
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=SC&CF=' + @CareFolder + '&IID=' + @ImageID + '&S=' + @ImageQualityValue

	/*Return.*/
	RETURN @StreamingImagePath
END

Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01708'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01708', GetDate())
END
GO