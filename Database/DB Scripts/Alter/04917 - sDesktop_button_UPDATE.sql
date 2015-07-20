
IF NOT EXISTS (SELECT * FROM sSystemButtons WHERE ButtonType = N'TopMenu' AND DesignString = N'btn_Desk_Resource.gif')
BEGIN
	INSERT sSystemButtons(ButtonIcon, ButtonType, DesignString, en_US)
	VALUES ('icon_globe.gif', 'TopMenu', 'btn_Desk_Resource.gif', 'Resource')
END
GO

IF EXISTS (SELECT * FROM sDeskTop WHERE DeskTopID = 15 AND DeskName = 'Compliance')
BEGIN
	UPDATE sDeskTop SET DESKBUTTONNAME = 'btn_Desk_Resource.gif' WHERE DeskTopID = 15 AND DeskName = 'Compliance'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04917', GetDate())
GO
