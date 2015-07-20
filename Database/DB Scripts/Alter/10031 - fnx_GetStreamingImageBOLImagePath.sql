IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageBOLImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageBOLImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImageBOLImagePath]
(
	@ImageType NVARCHAR(10)
	, @Size NVARCHAR(5)
	, @ImageID NVARCHAR(255)
)
RETURNS nvarchar(255)

AS

BEGIN

	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	
	/*Get Image Server path portion.*/
	SELECT @ImageServer = AppSettingValue
	FROM sAppSetting
	WHERE AppSettingKey = 'ImageServer'
		AND ConfigFileName = 'Server.config'
	
	SET @StreamingImagePath=@ImageServer+'/ImageStream.ashx?IT='+@ImageType+'&S='+@Size+'&ID='+@ImageID+''
	
	/*Return.*/
	RETURN @StreamingImagePath
	
END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10031', GetUTCDate())
GO