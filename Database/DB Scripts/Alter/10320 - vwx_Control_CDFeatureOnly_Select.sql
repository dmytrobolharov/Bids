IF OBJECT_ID(N'[dbo].[vwx_Control_CDFeatureOnly_Select]') IS NOT NULL
 DROP VIEW [dbo].[vwx_Control_CDFeatureOnly_Select]
GO

CREATE VIEW [dbo].[vwx_Control_CDFeatureOnly_Select]
AS
SELECT Level3ID, Level3Desc, Detail, ImageID, ImageVersion, AuxField1, AuxField2, 
       AuxField3, AuxField4, AuxField5, Active, MDate, MUser, CUser, CDate, 
	   '<img src="'+
	   (SELECT AppSettingValue FROM sAppSetting
	    WHERE AppSettingKey = 'ImageServer' AND ConfigFileName = 'Server.config') +
	   '/ImageStream.ashx?IT=CD&S=50&V=' + CAST(ISNULL(ImageVersion, 0) AS NVARCHAR(5)) + 
	   '&ID=' + CAST(ISNULL(ImageID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + '" />' AS CDFImage
FROM dbo.pConLevel3


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10320', GetUTCDate())
GO
