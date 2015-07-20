IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_activity_log.gif')
BEGIN
INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
VALUES('icon_log.gif', 'btn_activity_log.gif', 'activity log')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04997', GetDate())
GO