IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_Image_SEL]'))
DROP VIEW [dbo].[vwx_Image_SEL]
GO

CREATE VIEW [dbo].[vwx_Image_SEL]
AS
SELECT      '<img src=''' +
              (SELECT TOP (1) AppSettingValue FROM dbo.sAppSetting WHERE (AppSettingKey = 'ImageServer')) + 
                '/ImageStream.ashx?S=25&IID=' + CAST(ISNULL(dbo.pImage.ImageID, N'00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + 
                '&V=' + CAST(ISNULL(dbo.pImage.[Version], N'0') AS NVARCHAR(5)) + '''  />' AS ImagePath, 
             dbo.pImage.*,
			 SUBSTRING(ImageNo, 0, LEN(ImageNo) - PATINDEX('%[a-Z]%', REVERSE(ImageNo))+2) as ImageCodeSort, CAST(TempNo as INT) as ImageNoSort
FROM         dbo.pImage
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09314', GetDate())
GO