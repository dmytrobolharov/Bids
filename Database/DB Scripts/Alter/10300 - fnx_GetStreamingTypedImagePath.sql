IF OBJECT_ID(N'[dbo].[fnx_GetStreamingTypedImagePath]') IS NOT NULL
 DROP FUNCTION [dbo].[fnx_GetStreamingTypedImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingTypedImagePath]
(
 @ImageType NVARCHAR(20),
 @ImageID UNIQUEIDENTIFIER, 
 @ImageQualityValue INT
)
RETURNS NVARCHAR(255)
AS
BEGIN

  DECLARE @ImageServer NVARCHAR(200)

  /*Get Image Server path portion.*/
  SELECT @ImageServer = AppSettingValue
  FROM dbo.sAppSetting
  WHERE AppSettingKey = 'ImageServer' AND ConfigFileName = 'Server.config'

  RETURN @ImageServer + '/ImageStream.ashx?IT='+ISNULL(@ImageType, 'UNKNOWN') +
                        '&S=' + ISNULL(CAST(@ImageQualityValue AS NVARCHAR(5)), '50') + 
                        '&ID=' + ISNULL(CAST(@ImageID AS NVARCHAR(50)), '00000000-0000-0000-0000-000000000000')
  
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10300', GetUTCDate())
GO
