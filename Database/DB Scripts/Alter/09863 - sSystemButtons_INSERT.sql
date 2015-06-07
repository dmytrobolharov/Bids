IF NOT EXISTS (SELECT DesignString FROM sSystemButtons WHERE DesignString='btn_3DImages.gif')
	INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) 
	VALUES ('btn_3DImages.gif', '3D Images', 'Icon_image.gif')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09863', GetDate())
GO