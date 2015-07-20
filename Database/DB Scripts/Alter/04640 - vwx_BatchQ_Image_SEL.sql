IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BatchQ_Image_SEL]'))
DROP VIEW [dbo].[vwx_BatchQ_Image_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwx_BatchQ_Image_SEL]
AS
SELECT     
	ImageID, 
	'<img src=''../System/Control/ImageStream.ashx?S=50&IID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') 
	AS VARCHAR(40)) + '&V=' + CAST(ISNULL(Version, 1) AS VARCHAR(5)) + '''>' AS ImagePath, 
	'../System/Control/ImageStream.ashx?S=150&IID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') 
	AS VARCHAR(40)) + '&V=' + CAST(ISNULL(Version, 1) AS VARCHAR(5))  AS DataListImagePath,
	Version, ImageNo, ImageDescription, a.ImageKeywords, 
	b.ImageType AS ImageTypeName,
	b.ImageTypeID, ImageFile, 
	ImageFileType, ImageSize, ImageSubFolder1, ImageSubFolder2, ImageSubFolder3, ImageSubFolder4, ImageSubFolder5, ImageSubFolder6, 
    ImageSubFolder7, ImageSubFolder8, ImageSubFolder9, ImageSubFolder10, ImageSubFolder11, ImageSubFolder12, ImageSubFolder13
FROM pImage a WITH(NOLOCK)
	LEFT OUTER JOIN  pImageType b WITH(NOLOCK) ON a.ImageSubFolder1 = b.ImageType
	LEFT OUTER JOIN iCustom2 c WITH(NOLOCK) ON a.ImageSubFolder3 = c.Custom
	LEFT OUTER JOIN aCustom3 d  WITH(NOLOCK) ON a.ImageSubFolder4 = d.Custom

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04640', GetDate())
GO
