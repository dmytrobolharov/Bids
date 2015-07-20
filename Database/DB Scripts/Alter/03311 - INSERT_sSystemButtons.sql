SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_create_translation.gif')
	BEGIN
		INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
		VALUES ('icon_form_new.gif', 'btn_create_translation.gif', 'create translation')
	END
GO

IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_add_new_lang.gif')
	BEGIN
		INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
		VALUES ('icon_add.gif', 'btn_add_new_lang.gif', 'add new language')
	END
GO

IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_Desk_Help.gif')
	BEGIN
		INSERT INTO sSystemButtons (ButtonIcon, ButtonType, DesignString, en_US)
		VALUES ('icon_help.gif', 'TopMenu', 'btn_Desk_Help.gif', 'Help')
	END
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03311'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03311', GetDate())
END

GO