UPDATE sAppSetting
SET AppSettingValue = 'NEW'
WHERE UPPER(ConfigFileName) = UPPER('License.config')
AND UPPER(AppSettingKey) = UPPER('License')
