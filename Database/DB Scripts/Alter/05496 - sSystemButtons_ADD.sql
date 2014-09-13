if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_change_log.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_changeobject.gif', 'btn_change_log.gif', 'change log')
end
GO
if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_commit.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_next.gif', 'btn_commit.gif', 'commit')
end
GO
if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_share.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_user_team.gif', 'btn_share.gif', 'share')
end
GO
if NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_generate.gif')
begin
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US)
	VALUES ('icon_next.gif', 'btn_generate.gif', 'generate')
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0', '05496', GetDate())
GO
