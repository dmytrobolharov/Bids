IF OBJECT_ID(N'[dbo].[vwx_BatchQ_Image_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_BatchQ_Image_SEL]
GO

CREATE VIEW [dbo].[vwx_BatchQ_Image_SEL]
AS
SELECT ImageID, dbo.fnx_GetStreamingImageHTML(ImageID, Version, 50, '') AS ImagePath, 
	   dbo.fnx_GetStreamingImageHTML(ImageID, Version, 15, '') AS DataListImagePath, 
	   Version, ImageNo, ImageDescription, a.ImageKeywords, 
	   b.ImageType AS ImageTypeName, b.ImageTypeID, ImageFile, 
	   ImageFileType, ImageSize, ImageSubFolder1, ImageSubFolder2, ImageSubFolder3, 
	   ImageSubFolder4, ImageSubFolder5, ImageSubFolder6, ImageSubFolder7, ImageSubFolder8, 
	   ImageSubFolder9, ImageSubFolder10, ImageSubFolder11, ImageSubFolder12, ImageSubFolder13
FROM pImage a WITH(NOLOCK)
LEFT OUTER JOIN  pImageType b WITH(NOLOCK) ON a.ImageSubFolder1 = b.ImageType
LEFT OUTER JOIN iCustom2 c WITH(NOLOCK) ON a.ImageSubFolder3 = c.Custom
LEFT OUTER JOIN aCustom3 d  WITH(NOLOCK) ON a.ImageSubFolder4 = d.Custom


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10311', GetUTCDate())
GO
