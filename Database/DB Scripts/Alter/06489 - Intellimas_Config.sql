IF NOT EXISTS (SELECT DeskName FROM sDeskTop WHERE DeskName = 'Intellimas')
BEGIN
	INSERT INTO sDeskTop (DesktopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskUrl, DeskSort, DeskActive, DeskFolderID, DESKBUTTONNAME, MenuWidth)
	VALUES (99, 'Intellimas', 'Intellimas', 'icon_hangtag.gif', 'Intellimas', 'customwindow(''IntellimasPopup.aspx''); //', 98, 1, 0, 'btn_Desk_Intellimas.gif', 200)
END
GO


DECLARE @AppSettingOrder INT
SELECT @AppSettingOrder = (MAX(AppSettingOrder) + 1) FROM sAppSetting WHERE ConfigFileName = 'Server.config'

IF NOT EXISTS (SELECT AppSettingKey FROM sAppSetting WHERE AppSettingKey = 'IntellimasClientUrl' AND ConfigFileName = 'Server.config')
BEGIN
	INSERT INTO sAppSetting (ConfigFileName, AppSettingComment, AppSettingKey, AppSettingValue, AppSettingNote, AppSettingOrder, CUser, CDate, MUser, MDate)
	VALUES ('Server.config', '', 'IntellimasClientUrl', 'https://www.example.com/ClickOnceDeploy/LaunchClient.aspx', '', @AppSettingOrder, 'administrator', GETDATE(), 'administrator', GETDATE())
END
GO

DECLARE @AppSettingOrder INT
SELECT @AppSettingOrder = (MAX(AppSettingOrder) + 1) FROM sAppSetting WHERE ConfigFileName = 'Server.config'

IF NOT EXISTS (SELECT AppSettingKey FROM sAppSetting WHERE AppSettingKey = 'IntellimasAdminUrl' AND ConfigFileName = 'Server.config')
BEGIN
	INSERT INTO sAppSetting (ConfigFileName, AppSettingComment, AppSettingKey, AppSettingValue, AppSettingNote, AppSettingOrder, CUser, CDate, MUser, MDate)
	VALUES ('Server.config', '', 'IntellimasAdminUrl', 'https://www.example.com/ClickOnceDeploy/LaunchAdmin.aspx', '', @AppSettingOrder, 'administrator', GETDATE(), 'administrator', GETDATE())
END
GO

DECLARE @AppSettingOrder INT
SELECT @AppSettingOrder = (MAX(AppSettingOrder) + 1) FROM sAppSetting WHERE ConfigFileName = 'Server.config'

IF NOT EXISTS (SELECT AppSettingKey FROM sAppSetting WHERE AppSettingKey = 'IntellimasLicenseUrl' AND ConfigFileName = 'Server.config')
BEGIN
	INSERT INTO sAppSetting (ConfigFileName, AppSettingComment, AppSettingKey, AppSettingValue, AppSettingNote, AppSettingOrder, CUser, CDate, MUser, MDate)
	VALUES ('Server.config', '', 'IntellimasLicenseUrl', 'https://www.example.com/ClickOnceDeploy/LaunchLicense.aspx', '', @AppSettingOrder, 'administrator', GETDATE(), 'administrator', GETDATE())
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06489', GetDate())
GO
