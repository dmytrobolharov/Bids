
-- Items which are no longer necessary for functioning of system
-- These have been replaced by the ImageServer...

delete from rReportSetting
	where SettingType = 'ImagePath'
delete from rReportSetting
	where SettingType = 'ImageCarePath'
delete from rReportSetting
	where SettingType = 'ImagePOMPath'
delete from rReportSetting
	where SettingType = 'ImageSamplePath'
delete from rReportSetting
	where SettingType = 'ImageColorPath'
delete from rReportSetting
	where SettingType = 'ImageReportPath'


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '1083', GetDate())
GO