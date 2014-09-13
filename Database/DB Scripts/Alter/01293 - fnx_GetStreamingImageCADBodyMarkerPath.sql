IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageCADBodyMarkerPath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageCADBodyMarkerPath]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetStreamingImageCADBodyMarkerPath]    Script Date: 03/17/2011 12:45:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImageCADBodyMarkerPath](
	@BodyID uniqueidentifier,
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
	SET @ImageQualityValue = '2000'

	/*Get Image Server path portion.*/
	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=B&Type=MK&S=' + @ImageQualityValue + '&IID=' + CAST(@BodyID AS varchar(255)) + '&MID=' + CAST(@MarkerID AS varchar(255))

	/*Return.*/
	RETURN @StreamingImagePath

END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01293', GetDate())
GO