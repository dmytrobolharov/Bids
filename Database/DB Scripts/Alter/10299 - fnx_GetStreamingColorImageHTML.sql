IF OBJECT_ID(N'[dbo].[fnx_GetStreamingColorImageHTML]') IS NOT NULL
 DROP FUNCTION [dbo].[fnx_GetStreamingColorImageHTML]
GO

CREATE FUNCTION [dbo].[fnx_GetStreamingColorImageHTML]
(
 @ColorFolderID UNIQUEIDENTIFIER, 
 @ColorPaletteID UNIQUEIDENTIFIER, 
 @ImageQualityValue INT,
 @AdditionalAttributes NVARCHAR(MAX) = NULL
)
RETURNS NVARCHAR(MAX)
AS
BEGIN

  RETURN '<img src="' + 
         dbo.fnx_GetStreamingColorImagePath(@ColorFolderID, @ColorPaletteID, @ImageQualityValue) +
	     '" ' + ISNULL(@AdditionalAttributes, '') + ' />'
  
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10299', GetUTCDate())
GO
