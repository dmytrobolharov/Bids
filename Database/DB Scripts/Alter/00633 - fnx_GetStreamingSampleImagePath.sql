/*
Comments:

General - Ryan Cabanas - September 23, 2009
	Pass the Trade Partner Vendor ID, Sample Request Trade ID, Sample Request Submit
Image ID, and the Image ID and get the new Streaming Image Path back for Sample
attached images.
*/


ALTER FUNCTION [dbo].[fnx_GetStreamingSampleImagePath](
	@SampleRequestTradeID uniqueidentifier
	,@TradePartnerVendorID uniqueidentifier
	,@SampleRequestSubmitImageID uniqueidentifier
	,@ImageID uniqueidentifier
)

RETURNS nvarchar(400)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(400)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)

	/*Set image quality value.*/
	SET @ImageQualityValue = '2000'

	/*Get Image Server path portion.*/
	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')

	/*Build the path.*/
	SET @StreamingImagePath =	@ImageServer
								+ '/ImageStream.ashx?IT=S&SRTID=' + CAST(@SampleRequestTradeID AS varchar(255))
								+ '&TPVID=' + CAST(@TradePartnerVendorID AS varchar(255))
								+ '&L=0&Comp=100&S=' + @ImageQualityValue
								+ '&SRSID=' + CAST(@SampleRequestSubmitImageID AS varchar(255))
								+ '&IID=' + CAST(@ImageID AS varchar(255))
								+ '&V=1'

	/*Return.*/
	RETURN @StreamingImagePath
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '633', GetDate())
GO