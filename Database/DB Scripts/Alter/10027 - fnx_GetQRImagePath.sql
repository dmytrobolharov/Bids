IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetQRImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetQRImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetQRImagePath]
(
	@SRSID nvarchar(50)
)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PlmonServer nvarchar(200)
	DECLARE @Size nvarchar(5) = '32'
	DECLARE @StreamingQRImagePath nvarchar(255)
	
	SELECT @PlmonServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'
	
	SET @StreamingQRImagePath = @PlmonServer + '/QRCode.ashx?CODE=' + @SRSID + '&SIZE=' + @Size

	/*Return.*/
	RETURN @StreamingQRImagePath
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10027', GetUTCDate())
GO