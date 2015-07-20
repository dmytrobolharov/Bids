INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_save_search.gif', 'save search', 'Icon_save.gif')
INSERT INTO sSystemButtons (DesignString, en_US, ButtonIcon ) VALUES ('btn_compare.gif', 'compare', 'icon_materialMulti.gif')

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06558', GetDate())
GO
