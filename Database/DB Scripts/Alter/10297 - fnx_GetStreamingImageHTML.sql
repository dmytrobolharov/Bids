IF OBJECT_ID(N'[dbo].[fnx_GetStreamingImageHTML]') IS NOT NULL
 DROP FUNCTION [dbo].[fnx_GetStreamingImageHTML]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingImageHTML]
(
 @ImageID UNIQUEIDENTIFIER,
 @ImageVersion INT, 
 @ImageQualityValue INT,
 @AdditionalAttributes NVARCHAR(MAX) = NULL
)
RETURNS NVARCHAR(MAX)
AS
BEGIN

  RETURN '<img src="' + 
         dbo.fnx_GetStreamingImagePath(@ImageID, @ImageVersion, @ImageQualityValue) +
	     '" ' + ISNULL(@AdditionalAttributes, '') + ' />'

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10297', GetUTCDate())
GO
