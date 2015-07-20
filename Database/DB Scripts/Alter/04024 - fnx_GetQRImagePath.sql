/****** Object:  UserDefinedFunction [dbo].[fnx_GetQRImagePath]    Script Date: 09/28/2012 17:03:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetQRImagePath]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetQRImagePath]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetQRImagePath]    Script Date: 09/28/2012 17:03:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnx_GetQRImagePath]
(
	-- Add the parameters for the function here
	@SRSID nvarchar(50)
)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @PlmonServer nvarchar(200)
	DECLARE @Size nvarchar(5) = '32'
	DECLARE @StreamingQRImagePath nvarchar(255)
	
	-- Add the T-SQL statements to compute the return value here
	SET @PlmonServer = (SELECT TOP 1 SettingValue FROM rReportSetting WHERE SettingType = 'ImageServer')
	
	SET @StreamingQRImagePath = @PlmonServer + '/QRCode.ashx?CODE=' + @SRSID + '&SIZE=' + @Size
	--SET @StreamingQRImagePath = 'http://localhost/plmOnFileServices' + '/QRCode.ashx?CODE=' + @SRSID + '&SIZE=' + @Size

	/*Return.*/
	RETURN @StreamingQRImagePath
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04024', GetDate())
GO