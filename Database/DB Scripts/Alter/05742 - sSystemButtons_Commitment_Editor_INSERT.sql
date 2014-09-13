IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString='btn_commitment_editor.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_edit_file.gif', 'btn_commitment_editor.gif', 'Commitment Editor')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05742', GetDate())
GO
