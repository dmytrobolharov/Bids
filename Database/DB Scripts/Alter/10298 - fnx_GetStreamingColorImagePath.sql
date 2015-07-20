IF OBJECT_ID(N'[dbo].[fnx_GetStreamingColorImagePath]') IS NOT NULL
 DROP FUNCTION [dbo].[fnx_GetStreamingColorImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingColorImagePath]
(
 @ColorFolderID UNIQUEIDENTIFIER, 
 @ColorPaletteID UNIQUEIDENTIFIER, 
 @ImageQualityValue NVARCHAR(5)
)
RETURNS NVARCHAR(255)
AS
BEGIN

  DECLARE @ImageServer NVARCHAR(200)

  /*Get Image Server path portion.*/
  SELECT @ImageServer = AppSettingValue
  FROM dbo.sAppSetting
  WHERE AppSettingKey = 'ImageServer' AND ConfigFileName = 'Server.config'

  RETURN @ImageServer + '/ColorStream.ashx?S=' + ISNULL(@ImageQualityValue, '50') + 
                        '&CFID=' + ISNULL(CAST(@ColorFolderID AS NVARCHAR(50)), '00000000-0000-0000-0000-000000000000') + 
						'&CPID=' + ISNULL(CAST(@ColorPaletteID AS NVARCHAR(50)), '00000000-0000-0000-0000-000000000000')
  
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10298', GetUTCDate())
GO
