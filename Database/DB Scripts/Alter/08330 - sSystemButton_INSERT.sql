IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_divstype.gif')
BEGIN
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_divstype.gif', 'Dev. Workflow filter', 'Icon_related.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08330', GetDate())
GO
