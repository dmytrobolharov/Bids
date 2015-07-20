IF OBJECT_ID(N'[dbo].[fnx_GetStreamingImagePath]') IS NOT NULL
 DROP FUNCTION [dbo].[fnx_GetStreamingImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImagePath]
(
 @ImageID UNIQUEIDENTIFIER,
 @ImageVersion INT, 
 @ImageQualityValue INT
)
RETURNS NVARCHAR(255)
AS
BEGIN

  DECLARE @ImageServer nvarchar(200)

  /*Get Image Server path portion.*/
  SELECT @ImageServer = AppSettingValue
  FROM sAppSetting
  WHERE AppSettingKey = 'ImageServer' AND ConfigFileName = 'Server.config'

  RETURN @ImageServer + '/ImageStream.ashx?S=' + ISNULL(CAST(@ImageQualityValue AS NVARCHAR(5)), '50') + 
                        '&V=' + ISNULL(CAST(@ImageVersion AS NVARCHAR(5)), '0') + 
						'&IID=' + ISNULL(CAST(@ImageID AS NVARCHAR(50)), '00000000-0000-0000-0000-000000000000')

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10296', GetUTCDate())
GO
