IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString='btn_apply_colorways.gif')
BEGIN
	INSERT INTO sSystemButtons(ButtonIcon, DesignString, en_US) VALUES('Icon_pdf_32.off.gif', 'btn_apply_colorways.gif', 'apply')
END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05495', GetDate())
GO
