IF OBJECT_ID(N'[dbo].[fnx_GetStreamingTypedImageHTML]') IS NOT NULL
 DROP FUNCTION [dbo].[fnx_GetStreamingTypedImageHTML]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingTypedImageHTML]
(
 @ImageType NVARCHAR(20),
 @ImageID UNIQUEIDENTIFIER, 
 @ImageQualityValue INT,
 @AdditionalAttributes NVARCHAR(MAX) = NULL
)
RETURNS NVARCHAR(MAX)
AS
BEGIN

  RETURN '<img src="' + 
         dbo.fnx_GetStreamingTypedImagePath(@ImageType, @ImageID, @ImageQualityValue) +
	     '" ' + ISNULL(@AdditionalAttributes, '') + ' />'
  
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10301', GetUTCDate())
GO
