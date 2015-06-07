IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImagePathInfrastructure]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImagePathInfrastructure]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImagePathInfrastructure]
(
	@ImageID UNIQUEIDENTIFIER
	, @TradePartnerID UNIQUEIDENTIFIER
	, @InfrastructureID UNIQUEIDENTIFIER
	, @InfrastructureImageID UNIQUEIDENTIFIER
	, @ImageQualityValue INT
	, @ImageVersion INT
)

RETURNS NVARCHAR(500)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)

	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer +
							  '/ImageStream.ashx?IT=VINF&TPID=' + CAST(@TradePartnerID AS nVARCHAR(40)) +
							  '&TINFID=' + CAST(@InfrastructureID AS NVARCHAR(40)) +
							  '&L=0&Comp=100&S=' + CAST(@ImageQualityValue AS NVARCHAR(10)) +
							  '&TINFIID=' + CAST(@InfrastructureImageID AS NVARCHAR(40)) +
							  '&IID=' + CAST(@ImageID AS nVARCHAR(40)) +
							  '&V=' + CAST(@ImageVersion AS NVARCHAR(5))
	/*Return.*/
	RETURN @StreamingImagePath
END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10040', GetUTCDate())
GO