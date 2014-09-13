/****** Script for SelectTopNRows command from SSMS  ******/
update sAppSetting set AppSettingValue = 'Quality=lossless'
  WHERE     ConfigFileName = 'Image.config'
  and AppSettingKey = 'SAVESETTING_AI'
  GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06091', GetDate())
GO
