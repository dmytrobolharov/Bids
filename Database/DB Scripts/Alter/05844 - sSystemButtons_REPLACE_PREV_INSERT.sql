IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE DesignString='btn_replace_prev.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('icon_refresh.gif', 'btn_replace_prev.gif', 'replace with previous...')
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05844', GetDate())
GO
