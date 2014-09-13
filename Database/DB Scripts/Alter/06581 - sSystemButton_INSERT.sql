IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_template_select.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_template_select.gif', 'select template', 'Icon_shortcut.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_template_remove.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_template_remove.gif', 'remove template', 'icon_remove1.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'quick_quote.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('quick_quote.gif', 'Quick Quote', 'icon_new.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_quotation_palette.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_quotation_palette.gif', 'Quotation Palette', 'icon_new.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_send_to.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_send_to.gif', 'Send To', 'icon_mailsent.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_clear_sel.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_clear_sel.gif', 'Clear Selection', 'Icon_minus.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_partner_add.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_partner_add.gif', 'add partner', 'Icon_add.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_ExcelImport.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_ExcelImport.gif', 'Import Excel', 'ext_xls.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_select.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_select.gif', 'select', 'Icon_select.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_goto.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_goto.gif', 'go to...', 'Icon_shortcut.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_bomapply.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_bomapply.gif', 'Apply', 'icon_save.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_replace_material.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_replace_material.gif', 'replace material', 'icon_refresh.gif')
END
IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_refreshBOM.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_refreshBOM.gif', 'Refresh Quantity', 'icon_refresh.gif')
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06581', GetDate())
GO
