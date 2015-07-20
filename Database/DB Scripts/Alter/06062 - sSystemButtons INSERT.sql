INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('Icon_image.gif', 'btn_image_upload.gif', 'upload images')
	
	GO
	
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES ('info_icon.png', 'btn_info.gif', 'info')
	
	GO
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06062', GetDate())
GO