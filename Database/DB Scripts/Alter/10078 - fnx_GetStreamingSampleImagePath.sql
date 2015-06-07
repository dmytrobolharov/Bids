IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingSampleImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingSampleImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingSampleImagePath]
(
	@SampleRequestTradeID UNIQUEIDENTIFIER
	, @TradePartnerVendorID UNIQUEIDENTIFIER
	, @SampleRequestSubmitImageID UNIQUEIDENTIFIER
	, @ImageID UNIQUEIDENTIFIER
	, @ImageQualityValue NVARCHAR(5)
)

RETURNS nvarchar(400)

AS
BEGIN

	/*Declare variables.*/

	DECLARE @StreamingImagePath nvarchar(400)

	DECLARE @ImageServer nvarchar(200)

	/*Get Image Server path portion.*/
	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	/*Build the path.*/
	SET @StreamingImagePath =	@ImageServer
								+ '/ImageStream.ashx?IT=S&SRTID=' + CAST(@SampleRequestTradeID AS nvarchar(255))
								+ '&TPVID=' + CAST(@TradePartnerVendorID AS nvarchar(255))
								+ '&L=0&Comp=100&S=' + @ImageQualityValue
								+ '&SRSID=' + CAST(@SampleRequestSubmitImageID AS nvarchar(255))
								+ '&IID=' + CAST(@ImageID AS nvarchar(255))
								+ '&V=1'

	/*Return.*/
	RETURN @StreamingImagePath

END




GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10078', GetUTCDate())
GO