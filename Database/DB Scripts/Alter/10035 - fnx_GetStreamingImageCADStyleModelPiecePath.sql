IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageCADStyleModelPiecePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageCADStyleModelPiecePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImageCADStyleModelPiecePath]
(
	@StyleID UNIQUEIDENTIFIER
	, @ModelID UNIQUEIDENTIFIER
	, @PieceID UNIQUEIDENTIFIER
)

RETURNS nvarchar(255)

AS

BEGIN
	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	DECLARE @ImageQualityValue nvarchar(5)

	/*Set image quality value.*/
	SET @ImageQualityValue = '600'

	/*Get Image Server path portion.*/
	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'

	/*Build the path.*/
	SET @StreamingImagePath = @ImageServer + '/ImageStream.ashx?IT=ST&Type=MD&S=' + @ImageQualityValue + '&IID=' + CAST(@StyleID AS nvarchar(255)) + '&MDID=' + CAST(@ModelID AS nvarchar(255)) + '&PCID=' + CAST(@PieceID AS nvarchar(255)) + '&' + CAST(DATEDIFF(SECOND, '20000101', GETDATE()) AS NVARCHAR(30))

	/*Return.*/
	RETURN @StreamingImagePath
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10035', GetUTCDate())
GO

