UPDATE [dbo].[sSystemButtons]
   SET [ButtonIcon] = 'icon_press.gif'
 WHERE [DesignString] = 'btn_nav_down.gif'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05507', GetDate())
GO
