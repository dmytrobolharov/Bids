
/****** Object:  UserDefinedFunction [dbo].[fnx_GetStreamingImageBOLImagePath]    Script Date: 12/07/2011 14:12:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetStreamingImageBOLImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetStreamingImageBOLImagePath]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImageBOLImagePath]
(
	@ImageType nvarchar(10),
	@Size nvarchar(5),
	@ImageID nvarchar(255)
)
RETURNS nvarchar(255)

AS

BEGIN

	/*Declare variables.*/
	DECLARE @StreamingImagePath nvarchar(255)
	DECLARE @ImageServer nvarchar(200)
	
	/*Get Image Server path portion.*/
	SET @ImageServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')		
	
	SET @StreamingImagePath=@ImageServer+'/ImageStream.ashx?IT='+@ImageType+'&S='+@Size+'&ID='+@ImageID+''
	
	/*Return.*/
	RETURN @StreamingImagePath
	
END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02300'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02300', GetDate())

END

GO


