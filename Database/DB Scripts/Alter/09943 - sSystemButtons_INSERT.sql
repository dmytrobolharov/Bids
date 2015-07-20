IF NOT EXISTS(SELECT 1 FROM sSystemButtons WHERE DesignString='btn_image_single_upload.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonIcon, DesignString, en_US)
	VALUES('Icon_image.gif', 'btn_image_single_upload.gif', 'upload image')
END

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09943', GetUTCDate())
GO
