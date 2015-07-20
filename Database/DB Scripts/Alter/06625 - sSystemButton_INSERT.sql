IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_new.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_new.gif', 'add New', 'icon_add.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_add_existing.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_add_existing.gif', 'add Existing', 'icon_add.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_samplesize.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_samplesize.gif', 'sample size', 'Icon_edit_file.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_showhidesize.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_showhidesize.gif', 'show hide size', 'Icon_change.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_MeasHowto.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_MeasHowto.gif', 'how to meas', 'Icon_change.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_samplequickedit.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_samplequickedit.gif', 'edit sample only', 'icon_detail.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_pomlink.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pomlink.gif', 'link pom', 'Icon_related.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_pom_critical.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_critical.gif', 'critical pom', 'Icon_warning.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_showOnQA.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_showOnQA.gif', 'Show On QA', 'Icon_update.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_pom_delete.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_delete.gif', 'delete pom', 'Icon_delete.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_pom_library.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_pom_library.gif', 'pom library', 'Icon_bookclose.gif')
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06625', GetDate())
GO
